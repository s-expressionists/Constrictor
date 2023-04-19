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
    ;; There must be at least as many arguments as there are required
    ;; parameters.
    (unless (>= (length arguments) required)
      (return-from check-call-site nil))))
