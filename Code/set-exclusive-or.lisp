(cl:in-package #:constrictor)

(declaim (inline set-exclusive-or-core))

(defun set-exclusive-or-core
    (list-1 list-2 key key-supplied-p test test-supplied-p test-not test-not-supplied-p)
  (check-type list-1 proper-list)
  (check-type list-2 proper-list)
  (with-key (key key-supplied-p)
    (with-test (test test-supplied-p test-not test-not-supplied-p)
      (let ((result '()))
        (loop for element-1 in list-1
              do (loop for element-2 in list-2
                       when (apply-test (apply-key element-1)
                                        (apply-key element-2))
                         return nil
                       finally (push element-1 result)))
        (loop for element-2 in list-2
              do (loop for element-1 in list-1
                       when (apply-test (apply-key element-1)
                                        (apply-key element-2))
                         return nil
                       finally (push element-2 result)))
        result))))

(declaim (notinline set-exclusive-or-core))

(declaim (inline set-exclusive-or))

(defun set-exclusive-or
    (list-1 list-2
     &key
       (key #'identity key-supplied-p)
       (test #'eql test-supplied-p)
       (test-not #'eql test-not-supplied-p))
  (set-exclusive-or-core list-1 list-2
                         key key-supplied-p
                         test test-supplied-p
                         test-not test-not-supplied-p))

(define-compiler-macro set-exclusive-or (&whole form &rest arguments)
  (let ((lambda-list
          '((list-1 list-2) ; required
            ()           ; optional
            nil          ; rest
            ((:key key key-supplied-p)
             (:test test test-supplied-p)
             (:test-not test-not test-not-supplied-p))
            nil)))
    (unless (check-call-site arguments lambda-list)
      (return-from set-exclusive-or form))
    (compute-compiler-macro-body
     arguments
     (butlast lambda-list)
     '(set-exclusive-or-core
       list-1 list-2
       key key-supplied-p
       test test-supplied-p
       test-not test-not-supplied-p))))

(setf (documentation 'set-exclusive-or 'function)
      (format nil
              "Syntax: set-exclusive-or list-1 list-2 &key key test test-not~@
               ~%~a~%~%~a~%~%~a~%~%~a~%~@
               Either TEST or TEST-NOT is applied to the result of~@
               applying KEY to an element of LIST-1 and and the result~@
               of applying KEY to an element of LIST-2 in that order.~@
               If for some elements E1 of LIST-1 and E2 of LIST-2, the~@
               test is satisfied, neither E1 nor E2 is included in the~@
               return value of this function.  All other elements of~@
               LIST-1 and LIST-2 are included in the return value of~@
               this function.~@
               ~@
               The order of the elements in teh return value of this~@
               function should not be relied upon.  If there are duplicate~@
               elements E1 and E2 in LIST-1 for which there is no element~@
               in LIST-2 that satisfies the test, then both E1 and E2 might~@
               be included in the result.  If there are duplicate elements~@
               E1 and E2 of LIST-2 for which there is no element in LIST-1~@
               that satisfies the test, then both E1 and #2 might be~@
               included in the result."
              *list-1-and-list-2-must-be-proper*
              *key*
              *key-applied-to-elements-of-list-1-and-list-1*
              *test-and-test-not*))
