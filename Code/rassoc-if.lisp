(cl:in-package #:constrictor)

(declaim (inline rassoc-if-core))

(defun rassoc-if-core (predicate alist key)
  (with-key (key)
    (with-alist-elements (element alist)
      (when (funcall predicate (apply-key (cdr element)))
        (return-from rassoc-if-core element)))))

(declaim (notinline rassoc-if-core))

(declaim (inline rassoc-if))

(defun rassoc-if (predicate alist &key key)
  (with-canonical-key (key)
    (rassoc-core predicate alist key)))

(declaim (notinline rassoc-if))
