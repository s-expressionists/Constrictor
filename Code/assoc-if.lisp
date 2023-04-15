(cl:in-package #:constrictor)

(declaim (inline assoc-if-core))

(defun assoc-if-core (predicate alist key)
  (with-key (key)
    (with-alist-elements (element alist)
      (when (funcall predicate (apply-key (car element)))
        (return-from assoc-if-core element)))))

(declaim (notinline assoc-if-core))

(declaim (inline assoc-if))

(defun assoc-if (predicate alist &key key)
  (with-canonical-key (key)
    (assoc-core predicate alist key)))

(declaim (notinline assoc-if))
