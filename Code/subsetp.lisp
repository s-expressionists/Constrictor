(cl:in-package #:constrictor)

(declaim (inline subsetp-core))

(defun subsetp-core
    (list-1 list-2 key key-supplied-p test test-supplied-p test-not test-not-supplied-p)
  (with-key (key key-supplied-p)
    (loop for element-1 in list-1
          unless (member-core
                  (apply-key element-1) list-2
                  key key-supplied-p
                  test test-supplied-p
                  test-not test-not-supplied-p)
            return nil
          finally (return t))))

(declaim (notinline subsetp-core))

(declaim (inline subsetp))

(defun subsetp
    (list-1 list-2
     &key
       (key #'identity key-supplied-p)
       (test #'eql test-supplied-p)
       (test-not #'eql test-not-supplied-p))
  (subsetp-core list-1 list-2
                     key key-supplied-p
                     test test-supplied-p
                     test-not test-not-supplied-p))

(declaim (notinline subsetp))

(define-compiler-macro subsetp (&whole form &rest arguments)
  (let ((lambda-list
          '((list-1 list-2) ; required
            ()           ; optional
            nil          ; rest
            ((:key key key-supplied-p)
             (:test test test-supplied-p)
             (:test-not test-not test-not-supplied-p))
            nil)))
    (unless (check-call-site arguments lambda-list)
      (return-from subsetp form))
    (compute-compiler-macro-body
     arguments
     (butlast lambda-list)
     '(subsetp-core
       list-1 list-2
       key key-supplied-p
       test test-supplied-p
       test-not test-not-supplied-p))))

(setf (documentation 'subsetp 'function)
      (format nil
              "Syntax: subsetp list-1 list-2 &key key test test-not~@
               ~%~a~%~%~a~%~%~a~%~%~a~%~@
               Either TEST or TEST-NOT is applied to the result of~@
               applying KEY to an element of LIST-1 and and the result~@
               of applying KEY to an element of LIST-2 in that order.~@
               If for every element E1 of LIST-1, there is an element E2~@
               of LIST-2 such that E1 and E2 satisfy the test, then this~@
               function returns true.  Otherwise, it returns false."
              *list-1-and-list-2-must-be-proper*
              *key*
              *key-applied-to-elements-of-list-1-and-list-1*
              *test-and-test-not*))
