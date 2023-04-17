(cl:in-package #:constrictor)

(declaim (inline rassoc-if-not-core))

(defun rassoc-if-not-core (predicate alist key)
  (with-key (key)
    (with-alist-elements (element alist)
      (unless (funcall predicate (apply-key (cdr element)))
        (return-from rassoc-if-not-core element)))))

(declaim (notinline rassoc-if-not-core))

(declaim (inline rassoc-if-not))

(defun rassoc-if-not (predicate alist &key key)
  (rassoc-core predicate alist key))

(declaim (notinline rassoc-if-not))
