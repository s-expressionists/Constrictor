(cl:in-package #:constrictor)

(declaim (inline intersection-core))

(defun intersection-core
    (list-1 list-2 key key-supplied-p test test-supplied-p test-not test-not-supplied-p)
  (with-key (key key-supplied-p)
    (with-test (test test-supplied-p test-not test-not-supplied-p)
      (loop with result = '()
            for element-1 in list-1
            do (loop for element-2 in list-2
                     when (apply-test (apply-key element-1)
                                      (apply-key element-2))
                       do (push element-2 result))
            finally (return result)))))

(declaim (notinline intersection-core))

(declaim (inline intersection))

(defun intersection
    (list-1 list-2
     &key
       (key #'identity key-supplied-p)
       (test #'eql test-supplied-p)
       (test-not #'eql test-not-supplied-p))
  (intersection-core list-1 list-2
                     key key-supplied-p
                     test test-supplied-p
                     test-not test-not-supplied-p))

(declaim (notinline intersection))
