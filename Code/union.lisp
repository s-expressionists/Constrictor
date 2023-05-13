(cl:in-package #:constrictor)

(declaim (inline union-core))

(defun union-core
    (list-1 list-2 key key-supplied-p test test-supplied-p test-not test-not-supplied-p)
  (assert-proper-list list-1)
  (assert-proper-list list-2)
  (with-key (key key-supplied-p)
    (with-test (test test-supplied-p test-not test-not-supplied-p)
      (loop with result = list-2
            for element-1 in list-1
            do (loop for element-2 in list-2
                     when (apply-test (apply-key element-1)
                                      (apply-key element-2))
                       return nil
                       finally (push element-1 result))
            finally (return result)))))

(declaim (notinline union-core))

(declaim (inline union))

(defun union
    (list-1 list-2
     &key
       (key #'identity key-supplied-p)
       (test #'eql test-supplied-p)
       (test-not #'eql test-not-supplied-p))
  (union-core list-1 list-2
              key key-supplied-p
              test test-supplied-p
              test-not test-not-supplied-p))
