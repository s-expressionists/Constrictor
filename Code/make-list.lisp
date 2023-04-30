(cl:in-package #:constrictor)

(declaim (inline make-list))

(defun make-list (length &key (initial-element nil))
  (check-type length (integer 0))
  (loop repeat length
        collect initial-element))
