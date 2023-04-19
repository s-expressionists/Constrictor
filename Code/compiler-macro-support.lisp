(cl:in-package #:constrictor)

;;; We define a special version of a lambda list.  Such a lambda list
;;; is a proper list with 5 elements:
;;;
;;;  * A list of required parameters.  Each required parameter is a
;;;    symbol.
;;;
;;;  * A list of optional parameters.  Each optional parameter is a
;;;    list of two symbols.  The first symbol is the parameter itself
;;;    to be assigned to when there is an corresponding optional
;;;    argument in the call.  If there is no corresponding optional
;;;    parameter, we assign NIL to this parameter.  The second symbol
;;;    is a "supplied-p" parameter.  We assign T to that parameter
;;;    when there is a corresponding optional argument in the call,
;;;    and NIL to it otherwise.
;;;
;;;  * The name of a rest parameter, or NIL if there is no rest
;;;    parameter.  We assign a list of the remaining arguments to the
;;;    rest parameter if it is present.
;;;
;;;  * A list of keyword parameters.  Each keyword parameter is a list
;;;    of three symbols.  The first symbol is the keyword that should
;;;    be recognized in the call.  The second symbol is the parameter
;;;    itself.  the third symbol is a "supplied-p" parameter that
;;;    works in the same wasy as for optional parameters.  If there
;;;    are no keyword parameters, but the original lambda list has the
;;;    lambda-list keword &KEY in it, then this element is T.
;;;
;;;  * The symbol &ALLOW-OTHER-KEYS or NIL if other keys are not
;;;    allowed.

(defun check-call-site (arguments lambda-list)
  (destructuring-bind (required optional rest key allow-other-keys)
      lambda-list
    (declare (ignore rest))
    ;; There must be at least as many arguments as there are required
    ;; parameters.
    (unless (>= (length arguments) (length required))
      (return-from check-call-site nil))
    (let ((required+optional-count (+ (length required) (length optional))))
      ;; If there are no keyword parameters, then there can be at most
      ;; as many arguments as there are required and optional
      ;; parameters.
      (when (and (null key)
                 (> (length arguments) required+optional-count))
        (return-from check-call-site nil))
      (let ((keyword-arguments (subseq arguments required+optional-count)))
        ;; Check that there is an even number of keyword arguments.
        ;; If there are no keyword parameters, and the previous check
        ;; passes, then there are no remaining arguments, and zero is
        ;; even so we are fine.
        (unless (evenp (length keyword-arguments))
          (return-from check-call-site nil))
        ;; Check that every even keyword argument is a keyword.
        (loop for putative-keyword in keyword-arguments by #'cddr
              unless (keywordp putative-keyword)
                do (return-from check-call-site nil))
        (let ((other-keys-allowed-p
                (or allow-other-keys
                    (loop for (keyword value) on keyword-arguments by #'cddr
                            thereis (and (eq keyword :allow-other-keys)
                                         (eq value 't))))))
          ;; If other keys are not allowed, then check that every
          ;; keyword in the keyword arguments is in the list of
          ;; keyword parameters in the lambda list.
          (unless other-keys-allowed-p
            (loop for keyword in keyword-arguments by #'cddr
                  unless (loop for (allowed-keyword) in key
                                 thereis (eq keyword allowed-keyword))
                    do (return-from check-call-site nil))))))))
