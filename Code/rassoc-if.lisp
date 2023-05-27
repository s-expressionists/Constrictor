(cl:in-package #:constrictor)

(declaim (inline rassoc-if-core))

(defun rassoc-if-core (predicate alist key key-supplied-p)
  (with-key (key key-supplied-p)
    (with-alist-elements (element alist)
      (when (funcall predicate (apply-key (cdr element)))
        (return-from rassoc-if-core element)))))

(declaim (notinline rassoc-if-core))

(declaim (inline rassoc-if))

(defun rassoc-if (predicate alist &key (key nil key-supplied-p))
  (rassoc-if-core predicate alist key key-supplied-p))

(declaim (notinline rassoc-if))

(setf (documentation 'rassoc-if 'function)
      (format nil
              "Syntax rassoc-if predicate alist &key key~@
               ~@
               This function returns the first CONS cell in ALIST~@
               the CDR of which satisfies the test, i.e., returns~@
               true when the KEY and the PREDICATE are applied to it.~@
               If there is no CONS cell in ALIST with a CDR that~@
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
