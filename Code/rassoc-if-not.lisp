(cl:in-package #:constrictor)

(declaim (inline rassoc-if-not-core))

(defun rassoc-if-not-core (predicate alist key key-supplied-p)
  (with-key (key key-supplied-p)
    (with-alist-elements (element alist)
      (unless (funcall predicate (apply-key (cdr element)))
        (return-from rassoc-if-not-core element)))))

(declaim (notinline rassoc-if-not-core))

(declaim (inline rassoc-if-not))

(defun rassoc-if-not (predicate alist &key (key nil key-supplied-p))
  (rassoc-core predicate alist key key-supplied-p))

(declaim (notinline rassoc-if-not))

(setf (documentation 'rassoc-if-not 'function)
      (format nil
              "Syntax rassoc-if-not predicate alist &key key~@
               ~@
               This function returns the first CONS cell in ALIST~@
               the CDR of which satisfies the test, i.e., returns~@
               NIL when the KEY and the PREDICATE are applied to it.~@
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
