(cl:in-package #:constrictor)

(declaim (inline intersection-core))

(defun nintersection-core
    (list-1 list-2 key key-supplied-p test test-supplied-p test-not test-not-supplied-p)
  (assert-proper-list list-1)
  (assert-proper-list list-2)
  (when (null list-1)
    (return-from nintersection-core '()))
  (with-key (key key-supplied-p)
    (with-test (test test-supplied-p test-not test-not-supplied-p)
      (loop with rest = list-1
            until (null (cdr rest))
            do (loop with element-1 = (cadr rest)
                     for element-2 in list-2
                     when (apply-test (apply-key element-1)
                                      (apply-key element-2))
                       ;; Exclude (CADR REST).
                       do (pop rest)
                       and return nil
                     finally (setf (cdr rest) (cddr rest))))
      ;; At this point, we have excluded every element in LIST-1 that
      ;; is also an element of LIST-1, except we haven't checked the
      ;; first element of LIST-1.
      (loop for element-2 in list-2
            when (apply-test (apply-key (car list-1))
                               (apply-key element-2))
              return list-1
            finally (return (cdr list-1))))))

(declaim (notinline nintersection-core))

(declaim (inline nintersection))

(defun nintersection
    (list-1 list-2
     &key
       (key #'identity key-supplied-p)
       (test #'eql test-supplied-p)
       (test-not #'eql test-not-supplied-p))
  (nintersection-core list-1 list-2
                      key key-supplied-p
                      test test-supplied-p
                      test-not test-not-supplied-p))

(define-compiler-macro nintersection (&whole form &rest arguments)
  (let ((lambda-list
          '((list-1 list-2) ; required
            ()           ; optional
            nil          ; rest
            ((:key key key-supplied-p)
             (:test test test-supplied-p)
             (:test-not test-not test-not-supplied-p))
            nil)))
    (unless (check-call-site arguments lambda-list)
      (return-from nintersection form))
    (compute-compiler-macro-body
     arguments
     (butlast lambda-list)
     '(nintersection-core
       list-1 list-2
       key key-supplied-p
       test test-supplied-p
       test-not test-not-supplied-p))))

(setf (documentation 'nintersection 'function)
      (format nil
              "Syntax: nintersection list-1 list-2 &key key test test-not~@
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
               When possible, the list structure of LIST-1 is destructively~@
               modified, so that a CONS cell of LIST-1 containing a CAR~@
               that is not an element of LIST-2 with respect to the key and~@
               the test is removed from LIST-1.  When the first element~@
               of LIST-1 is also an element of LIST-2 with respect to the~@
               key and the test, then the return value of this function~@
               is EQ to LIST-1.
               ~@
               The order of the elements in the return value of~@
               this function should not be relied upon.  The only~@
               guarantee is that an element of LIST-1 will be a member~@
               of the return value of this function if and only if~@
               it is also a member of LIST-2, with respect to the~@
               values of KEY, TEST, and TEST-NOT.  If there are duplicate~@
               elements in LIST-1, and a corresponding element in~@
               LIST-2 that satifies the test, then the return value of~@
               this function will also contain duplicate elements."
              *list-1-and-list-2-must-be-proper*
              *key*
              *key-applied-to-elements-of-list-1-and-list-1*
              *test-and-test-not*))
