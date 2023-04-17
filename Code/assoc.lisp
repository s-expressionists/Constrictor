(cl:in-package #:constrictor)

(declaim (inline assoc-core))

(defun assoc-core
    (item alist key test test-supplied-p test-not test-not-supplied-p)
  (with-key (key)
    (with-test (test test-supplied-p test-not test-not-supplied-p)
      (with-alist-elements (element alist)
        (when (apply-test item (apply-key (car element)))
          (return-from assoc-core element))))))

(declaim (notinline assoc-core))

(declaim (inline assoc))

(defun assoc
    (item alist
     &key
       (key #'identity)
       (test #'eql test-supplied-p)
       (test-not #'eql test-not-supplied-p))
  (assoc-core item alist
              key
              test test-supplied-p
              test-not test-not-supplied-p))

(declaim (notinline assoc))
