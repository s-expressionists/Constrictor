(cl:in-package #:constrictor)

(declaim (inline member-core))

(defun member-core
    (item list key key-supplied-p test test-supplied-p test-not test-not-supplied-p)
  (with-key (key key-supplied-p)
    (with-test (test test-supplied-p test-not test-not-supplied-p)
      (with-proper-list-rests (rest list)
        (when (apply-test item (apply-key (car rest)))
          (return-from member-core rest))))))

(declaim (notinline member-core))

(declaim (inline member))

(defun member
    (item list
     &key
       (key #'identity key-supplied-p)
       (test #'eql test-supplied-p)
       (test-not #'eql test-not-supplied-p))
  (member-core item list
               key key-supplied-p
               test test-supplied-p
               test-not test-not-supplied-p))

(declaim (notinline member))

(setf (documentation 'member 'function)
      (format nil
              "Syntax: member item list &key key test test-not~@
               ~%~a~%~%~a~%~%~a~%~@
               Either TEST or TEST-NOT is applied to the result of~@
               applying KEY to an element of LIST, and if that element~@
               satisfies the test, the suffix of LIST starting at that~@
               element is returned.~%~%~a"
              *key*
              *key-applied-to-elements-of-list*
              *test-and-test-not*
              *list-should-be-proper*))
