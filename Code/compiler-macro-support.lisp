(cl:in-package #:constrictor)

;;; If the keyword arguments are acceptable to a compiler macro, then
;;; return a list of triples (keyword form gensym).  Otherwise return
;;; :UNACCEPTABLE.
;;;
;;; It is important not to call any functions that take keyword
;;; arguments in this function, because we would have an infinite
;;; recursion when this function was being used to create a compiler
;;; macro for one of those functions.
(defun process-keyword-arguments (arguments allowed-keywords)
  ;; Check that there are an even number of arguments.  This check
  ;; might be unnecessary, since the compiler may already have
  ;; signaled an error for a form with an odd number of keyword
  ;; argument, and the compiler macro was then never invoked.
  (unless (evenp (length arguments))
    (return-from process-keyword-arguments :unacceptable))
  ;; Check that every even member of ARGUMENTS is a keyword.
  (unless (loop for putative-keyword in arguments by #'cddr
                always (keywordp putative-keyword))
    (return-from process-keyword-arguments :unacceptable))
  ;; Create a list of triples of the form (keyword form gensym).
  (let ((triples (loop for (keyword form) on arguments by #'cddr
                       collect (list keyword form (gensym)))))
    ;; If :ALLOW-OTHER-KEYS T is given in the argument list, then we
    ;; are done and we can return the triples.  We recognize only T
    ;; here, because it is too complicated to figure out whether the
    ;; value is simultaneously a constant and not NIL.
    (when (loop for (keyword value) in triples
                  thereis (and (eq keyword :allow-other-keys)
                               (eq value 't)))
      (return-from process-keyword-arguments triples))
    ;; Otherwise check that every keyword is a member of the list
    ;; ALLOWED-KEYWORDS.
    (flet ((allowed-keyword-p (keyword)
             ;; In particular, do not use MEMBER here.
             (loop for allowed-keyword in allowed-keywords
                   thereis (eq keyword allowed-keyword))))
      (unless (loop for (keyword) in triples
                    always (allowed-keyword-p keyword))
        (return-from process-keyword-arguments :unacceptable)))
    triples))
