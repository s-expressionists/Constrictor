(cl:in-package #:constrictor)

(declaim (inline adjoin-core))

(defun adjoin-core
    (item list key key-supplied-p test test-supplied-p test-not test-not-supplied-p)
  (with-key (key key-supplied-p)
    (with-test (test test-supplied-p test-not test-not-supplied-p)
      (loop for remaining on list
            when (apply-test item (apply-key (car remaining)))
              return list
            finally (if (null remaining)
                        (return (cons item list))
                        (error 'list-must-be-proper
                               :datum remaining
                               :offending-list list))))))

(declaim (notinline adjoin-core))

(defun adjoin
    (item list
     &key
       (key nil key-supplied-p)
       (test #'eql test-supplied-p)
       (test-not #'eql test-not-supplied-p))
  (adjoin-core item list
               key key-supplied-p
               test test-supplied-p
               test-not test-not-supplied-p))
