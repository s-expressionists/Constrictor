(cl:in-package #:constrictor)

(declaim (inline rassoc-core))

(defun rassoc-core
    (item alist key test test-supplied-p test-not test-not-supplied-p)
  (with-key (key)
    (with-test (test test-supplied-p test-not test-not-supplied-p)
      (with-alist-elements (element alist)
        (when (apply-test item (apply-key (cdr element)))
          (return-from rassoc-core element))))))

(declaim (notinline rassoc-core))

(declaim (inline rassoc))

(defun rassoc
    (item alist
     &key
       key
       (test #'eql test-supplied-p)
       (test-not #'eql test-not-supplied-p))
  (with-canonical-key-test-test-not
      (key test test-supplied-p test-not test-not-supplied-p)
    (rassoc-core item alist
                 key
                 test test-supplied-p
                 test-not test-not-supplied-p)))

(declaim (notinline rassoc))
