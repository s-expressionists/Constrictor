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
