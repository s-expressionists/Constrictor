(cl:in-package #:constrictor)

(declaim (inline set-difference-core))

(defun set-difference-core
    (list-1 list-2 key key-supplied-p test test-supplied-p test-not test-not-supplied-p)
  (with-key (key key-supplied-p)
    (with-test (test test-supplied-p test-not test-not-supplied-p)
      (loop with result = '()
            for element-1 in list-1
            do (loop for element-2 in list-2
                     when (apply-test (apply-key element-1)
                                      (apply-key element-2))
                       return nil
                     finally (push element-1 result))
            finally (return result)))))

(declaim (notinline set-difference-core))

(declaim (inline set-difference))

(defun set-difference
    (list-1 list-2
     &key
       (key #'identity key-supplied-p)
       (test #'eql test-supplied-p)
       (test-not #'eql test-not-supplied-p))
  (set-difference-core list-1 list-2
                       key key-supplied-p
                       test test-supplied-p
                       test-not test-not-supplied-p))

(setf (documentation 'set-difference 'function)
      (format nil
              "Syntax: set-difference list-1 list-2 &key key test test-not~@
               LIST-1 and LIST-2 must be proper lists.  If either LIST-1~@
               or LIST-2 is not a proper list, then an error of type~@
               TYPE-ERROR is signaled.~@
               ~@
               KEY is either NIL or a designator for a function of one~@
               argument.  If KEY is NIL or not provided, it defaults to~@
               the function named IDENTITY.  The function denoted by KEY~@
               is applied to each element of LIST-1 and LIST-2 before the~@
               test is applied.  KEY is typically used to extract a slot~@
               from an element of either LIST-1 or LIST-2 to be used for~@
               the test, but this is not a requirement.~@
               ~@
               TEST and TEST-NOT are designators for functions of two~@
               arguments.  The return value is used by SET-DIFFERENCE~@
               as a generalized Boolean to determine whether the test~@
               is satisfied.  TEST and TEST-NOT can not both be provided.~@
               If neither TEST nor TEST-NOT is provided, then the default~@
               is the function named EQL for TEST.  Either TEST or~@
               TEST-NOT is applied to the result of applying KEY to~@
               an element of LIST-1 and and the result of applying KEY~@
               to an element of LIST-2 in that order.  For some element~@
               E1 of LIST-1, if for some element E2 of LIST-2, the~@
               test is satisfied, then E1 is excluded from the return~@
               value of SET-DIFFERENCE.  Otherwise, i.e., if for every~@
               element E2 of LIST-2 the test is not satisfied, then E1~@
               is include in the return value of SET-DIFFERENCE.~@
               ~@
               The order of the elements in the return value of~@
               SET-DIFFERENCE should not be relied upon.  The only~@
               guarantee is that an element of LIST-1 will be a member~@
               of the return value of SET-DIFFERENCE if and only if~@
               it is not also a member of LIST-2, with respect to the~@
               values of KEY, TEST, and TEST-NOT.  If there are duplicate~@
               elements in LIST-1, and no corresponding element in~@
               LIST-2 that satifies the test, then the return value of~@
               SET-DIFFERENCE will also contain duplicate elements."))
