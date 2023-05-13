(cl:in-package #:constrictor)

(declaim (inline nunion-core))

(defun nunion-core
    (list-1 list-2 key key-supplied-p test test-supplied-p test-not test-not-supplied-p)
  (with-key (key key-supplied-p)
    (with-test (test test-supplied-p test-not test-not-supplied-p)
      (loop with result = list-2
            with remaining = list-1
            until (atom remaining)
            do (loop for element-2 in list-2
                     when (apply-test (apply-key (car remaining))
                                      (apply-key element-2))
                       do (pop remaining)
                          (return nil)
                       finally (rotatef (cdr remaining) result remaining))
            finally (if (null remaining)
                        (return result)
                        (error 'list-must-be-proper
                               :offending-list list-1))))))

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
