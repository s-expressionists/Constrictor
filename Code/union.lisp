(cl:in-package #:constrictor)

(declaim (inline union-core))

(defun union-core
    (list-1 list-2 key key-supplied-p test test-supplied-p test-not test-not-supplied-p)
  (assert-proper-list list-1)
  (assert-proper-list list-2)
  (with-key (key key-supplied-p)
    (with-test (test test-supplied-p test-not test-not-supplied-p)
      (loop with result = list-2
            for element-1 in list-1
            do (loop for element-2 in list-2
                     when (apply-test (apply-key element-1)
                                      (apply-key element-2))
                       return nil
                       finally (push element-1 result))
            finally (return result)))))

(declaim (notinline union-core))

(declaim (inline union))

(defun union
    (list-1 list-2
     &key
       (key #'identity key-supplied-p)
       (test #'eql test-supplied-p)
       (test-not #'eql test-not-supplied-p))
  (union-core list-1 list-2
              key key-supplied-p
              test test-supplied-p
              test-not test-not-supplied-p))

(setf (documentation 'union 'function)
      (format nil
              "Syntax: union list-1 list-2 &key key test test-not~@
               ~%~a~%~%~a~%~%~a~%~%~a~%~@
               Either TEST or TEST-NOT is applied to the result of~@
               applying KEY to an element of LIST-1 and and the result~@
               of applying KEY to an element of LIST-2 in that order.~@
               For elements E1 of LIST-1 and E2 of LIST-2, if the test~@
               is satisfied, either E1 or E2 (but not both) will be~@
               included in the return value of this function.  Any~@
               element E1 of LIST-1 for which there is no element E2~@
               in LIST-2 that satisfies the test will be included in~@
               in the return value of this function.  Similarly, any~@
               element E2 of LIST-2 for which there is no element E1~@
               in LIST-1 that satisfies the test will be included in~@
               in the return value of this function.
               ~@
               The order of the elements in the return value of~@
               this function should not be relied upon.  If there are~@
               duplicate elements in LIST-1, and there is no corresponding~@
               element in LIST-2 that satifies the test, then the return~@
               value of this function will also contain duplicate elements."
              *list-1-and-list-2-must-be-proper*
              *key*
              *key-applied-to-elements-of-list-1-and-list-1*
              *test-and-test-not*))
