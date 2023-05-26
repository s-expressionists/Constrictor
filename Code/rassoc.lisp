(cl:in-package #:constrictor)

(declaim (inline rassoc-core))

(defun rassoc-core
    (item alist key key-supplied-p test test-supplied-p test-not test-not-supplied-p)
  (with-key (key key-supplied-p)
    (with-test (test test-supplied-p test-not test-not-supplied-p)
      (with-alist-elements (element alist)
        (when (apply-test item (apply-key (cdr element)))
          (return-from rassoc-core element))))))

(declaim (notinline rassoc-core))

(declaim (inline rassoc))

(defun rassoc
    (item alist
     &key
       (key nil key-supplied-p)
       (test #'eql test-supplied-p)
       (test-not #'eql test-not-supplied-p))
  (rassoc-core item alist
               key key-supplied-p
               test test-supplied-p
               test-not test-not-supplied-p))

(declaim (notinline rassoc))

(setf (documentation 'rassoc 'function)
      (format nil
              "Syntax assoc item alist &key key test test-not~@
               ~@
               This function returns the first CONS cell in ALIST~@
               the CDR of which satisfies the test, i.e., that~@
               compares with ITEM to yield a true value, in terms~@
               of KEY, TEST, and TEST-NOT.  If no CONS cell contains~@
               a CDR that satisfies the test, then this function~@
               returns NIL.~@
               ~@
               KEY must be NIL or a designator for a function of~@
               one argument.  If KEY is NIL, then it is as if the~@
               function named IDENTITY had been supplied instead.~@
               Either of TEST or TEST-NOT must be a designator for~@
               a function of two arguments.  If neither TEST nor~@
               TEST-NOT is given, then it is as if the function named~@
               EQL had been supplied as the value of TEST.  If both~@
               TEST and TEST-NOT are supplied, then an error is signaled.~@
               ~@
               If ALIST contains an element that is not permitted in~@
               an association list, and that element occurs before the~@
               first element that satisfies the test, then an error~@
               of type TYPE-ERROR is signaled."))
