(cl:in-package #:constrictor)

(declaim (inline rassoc-core))

(defun rassoc-core
    (item alist key key-supplied-p test test-supplied-p test-not test-not-supplied-p)
  (with-key (key key-supplied-p)
    (with-test (test test-supplied-p test-not test-not-supplied-p)
      (with-alist-elements (element alist)
        (when (apply-test item (apply-key (cdr element)))
          (return-from rassoc-core element))))))

(declaim (notinline rassoc-core))

(declaim (inline rassoc))

(defun rassoc
    (item alist
     &key
       (key nil key-supplied-p)
       (test #'eql test-supplied-p)
       (test-not #'eql test-not-supplied-p))
  (rassoc-core item alist
               key key-supplied-p
               test test-supplied-p
               test-not test-not-supplied-p))

(declaim (notinline rassoc))
