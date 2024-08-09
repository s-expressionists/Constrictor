(cl:in-package #:constrictor)

(declaim (inline nunion-core))

(defun nunion-core
    (list-1 list-2 key key-supplied-p test test-supplied-p test-not test-not-supplied-p)
  (check-type list-1 proper-list)
  (check-type list-2 proper-list)
  (with-key (key key-supplied-p)
    (with-test (test test-supplied-p test-not test-not-supplied-p)
      (loop with result = list-2
            with remaining = list-1
            until (null remaining)
            do (loop for element-2 in list-2
                     when (apply-test (apply-key (car remaining))
                                      (apply-key element-2))
                       do (pop remaining)
                          (return nil)
                       finally (rotatef (cdr remaining) result remaining))
            finally (return result)))))

(declaim (notinline nunion-core))

(declaim (inline nunion))

(defun nunion
    (list-1 list-2
     &key
       (key #'identity key-supplied-p)
       (test #'eql test-supplied-p)
       (test-not #'eql test-not-supplied-p))
  (nunion-core list-1 list-2
               key key-supplied-p
               test test-supplied-p
               test-not test-not-supplied-p))

(define-compiler-macro nunion (&whole form &rest arguments)
  (let ((lambda-list
          '((list-1 list-2) ; required
            ()           ; optional
            nil          ; rest
            ((:key key key-supplied-p)
             (:test test test-supplied-p)
             (:test-not test-not test-not-supplied-p))
            nil)))
    (unless (check-call-site arguments lambda-list)
      (return-from nunion form))
    (compute-compiler-macro-body
     arguments
     (butlast lambda-list)
     '(nunion-core
       list-1 list-2
       key key-supplied-p
       test test-supplied-p
       test-not test-not-supplied-p))))

(setf (documentation 'nunion 'function)
      (format nil
              "Syntax: nunion list-1 list-2 &key key test test-not~@
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
               This function may modify LIST-1 in that new elements may~@
               be added to it.  The original value of LIST-1 should not~@
               be used after a call to this function.
               ~@
               The order of the elements in the return value of~@
               this function should not be relied upon.  If there are~@
               duplicate elements in LIST-1, and there is no corresponding~@
               element in LIST-2 that satifies the test, then the return~@
               value of this function will also contain duplicate elements.~@
               Similarly, if there are duplicate elements in LIST-1, and~@
               there is no corresponding element in LIST-2 that satifies~@
               the test, then the return value of this function will also~@
               contain duplicate elements."
              *list-1-and-list-2-must-be-proper*
              *key*
              *key-applied-to-elements-of-list-1-and-list-1*
              *test-and-test-not*))
