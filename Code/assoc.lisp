(cl:in-package #:constrictor)

(declaim (inline assoc-core))

(defun assoc-core
    (item alist key key-supplied-p test test-supplied-p test-not test-not-supplied-p)
  (with-key (key key-supplied-p)
    (with-test (test test-supplied-p test-not test-not-supplied-p)
      (with-alist-elements (element alist)
        (when (apply-test item (apply-key (car element)))
          (return-from assoc-core element))))))

(declaim (notinline assoc-core))

(declaim (inline assoc))

(defun assoc
    (item alist
     &key
       (key #'identity key-supplied-p)
       (test #'eql test-supplied-p)
       (test-not #'eql test-not-supplied-p))
  (assoc-core item alist
              key key-supplied-p
              test test-supplied-p
              test-not test-not-supplied-p))

(declaim (notinline assoc))

(define-compiler-macro assoc (&whole form &rest arguments)
  (let ((lambda-list
          '((item alist) ; required
            ()           ; optional
            nil          ; rest
            ((:key key key-supplied-p)
             (:test test test-supplied-p)
             (:test-not test-not test-not-supplied-p))
            nil)))
    (unless (check-call-site arguments lambda-list)
      (return-from assoc form))
    (compute-compiler-macro-body
     arguments
     (butlast lambda-list)
     '(assoc-core
       item alist
       key key-supplied-p
       test test-supplied-p
       test-not test-not-supplied-p))))

(setf (documentation 'assoc 'function)
      (format nil
              "Syntax assoc item alist &key key test test-not~@
               ~@
               This function returns the first CONS cell in ALIST~@
               that satisfies the test, i.e., the CAR of which is~@
               compares with ITEM to yield a true value, in terms~@
               of KEY, TEST, and TEST-NOT.  If no CONS cell satisfies~@
               the test, then this function returns NIL.~@
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
