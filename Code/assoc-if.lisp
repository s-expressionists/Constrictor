(cl:in-package #:constrictor)

(declaim (inline assoc-if-core))

(defun assoc-if-core (predicate alist key key-supplied-p)
  (with-key (key key-supplied-p)
    (with-alist-elements (element alist)
      (when (funcall predicate (apply-key (car element)))
        (return-from assoc-if-core element)))))

(declaim (notinline assoc-if-core))

(declaim (inline assoc-if))

(defun assoc-if (predicate alist &key (key nil key-supplied-p))
  (assoc-core predicate alist key key-supplied-p))

(declaim (notinline assoc-if))

(define-compiler-macro assoc-if (&whole form &rest arguments)
  (let ((lambda-list
          '((predicate alist)
            ()
            nil
            ((:key key key-supplied-p))
            nil)))
    (unless (check-call-site arguments lambda-list)
      (return-from assoc-if form))
    (compute-compiler-macro-body
     arguments
     lambda-list
     '(assoc-if-core predicate alist key key-supplied-p))))

(setf (documentation 'assoc-if 'function)
      (format nil
              "Syntax assoc-if predicate alist &key key~@
               ~@
               This function returns the first CONS cell in ALIST~@
               the CAR of which satisfies the test, i.e., returns~@
               true when the KEY and the PREDICATE are applied to it.~@
               If there is no CONS cell in ALIST with a CAR that~@
               satisfies the test, then this function returns NIL.~@
               ~@
               KEY must be NIL or a designator for a function of~@
               one argument.  If KEY is NIL, then it is as if the~@
               function named IDENTITY had been supplied instead.~@
               ~@
               If ALIST contains an element that is not permitted in~@
               an association list, and that element occurs before the~@
               first element that satisfies the test, then an error~@
               of type TYPE-ERROR is signaled."))
