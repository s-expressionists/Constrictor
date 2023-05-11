(cl:in-package #:constrictor)

(declaim (inline intersection-core))

(defun intersection-core
    (list-1 list-2 key key-supplied-p test test-supplied-p test-not test-not-supplied-p)
  (with-key (key key-supplied-p)
    (with-test (test test-supplied-p test-not test-not-supplied-p)
      (loop with result = '()
            for element-1 in list-1
            do (loop for element-2 in list-2
                     when (apply-test (apply-key element-1)
                                      (apply-key element-2))
                       do (push element-2 result))
            finally (return result)))))

(declaim (notinline intersection-core))

(declaim (inline intersection))

(defun intersection
    (list-1 list-2
     &key
       (key #'identity key-supplied-p)
       (test #'eql test-supplied-p)
       (test-not #'eql test-not-supplied-p))
  (intersection-core list-1 list-2
                     key key-supplied-p
                     test test-supplied-p
                     test-not test-not-supplied-p))

(declaim (notinline intersection))

(setf (documentation 'intersection 'function)
      (format nil
              "Syntax: intersection list-1 list-2 &key key test test-not~@
               ~%~a~%~%~a~%~%~a~%~%~a~%~@
               Either TEST or TEST-NOT is applied to the result of~@
               applying KEY to an element of LIST-1 and and the result~@
               of applying KEY to an element of LIST-2 in that order.~@
               For some element E1 of LIST-1, if for some element E2 of~@
               LIST-2, the test is satisfied, then E1 is included in~@
               the return value of this function.  Otherwise, i.e., if~@
               for every element E2 of LIST-2 the test is not satisfied,~@
               then E1 is excluded from the return value of this function.~@
               ~@
               The order of the elements in the return value of~@
               this function should not be relied upon.  The only~@
               guarantee is that an element of LIST-1 will be a member~@
               of the return value of this function if and only if~@
               it is also a member of LIST-2, with respect to the~@
               values of KEY, TEST, and TEST-NOT.  If there are duplicate~@
               elements in LIST-1, and there is a corresponding element in~@
               LIST-2 that satifies the test, then the return value of~@
               this function will also contain duplicate elements."
              *list-1-and-list-2-must-be-proper*
              *key*
              *key-applied-to-elements-of-list-1-and-list-1*
              *test-and-test-not*))
