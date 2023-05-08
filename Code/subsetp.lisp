(cl:in-package #:constrictor)

(declaim (inline subsetp-core))

(defun subsetp-core
    (list-1 list-2 key key-supplied-p test test-supplied-p test-not test-not-supplied-p)
  (loop for element-1 in list-1
        unless (member-core
                element-1 list-2
                key key-supplied-p
                test test-supplied-p
                test-not test-not-supplied-p)
          return nil
        finally (return t)))

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
