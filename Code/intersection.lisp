(cl:in-package #:constrictor)

(declaim (inline intersection-core))

(defun intersection-core
    (list-1 list-2 key key-supplied-p test test-supplied-p test-not test-not-supplied-p)
  (loop for element-1 in list-1
        when (member-core
              element-1 list-2
              key key-supplied-p
              test test-supplied-p
              test-not test-not-supplied-p)
          collect element-1))

(declaim (notinline intersection-core))

(declaim (inline intersection))

(defun instersection
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
