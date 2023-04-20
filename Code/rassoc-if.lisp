(cl:in-package #:constrictor)

(declaim (inline rassoc-if-core))

(defun rassoc-if-core (predicate alist key key-supplied-p)
  (with-key (key key-supplied-p)
    (with-alist-elements (element alist)
      (when (funcall predicate (apply-key (cdr element)))
        (return-from rassoc-if-core element)))))

(declaim (notinline rassoc-if-core))

(declaim (inline rassoc-if))

(defun rassoc-if (predicate alist &key (key nil key-supplied-p))
  (rassoc-core predicate alist key key-supplied-p))

(declaim (notinline rassoc-if))
