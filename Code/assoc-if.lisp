(cl:in-package #:constrictor)

(declaim (inline assoc-if-core))

(defun assoc-if-core (predicate alist key key-supplied-p)
  (with-key (key key-supplied-p)
    (with-alist-elements (element alist)
      (when (funcall predicate (apply-key (car element)))
        (return-from assoc-if-core element)))))

(declaim (notinline assoc-if-core))

(declaim (inline assoc-if))

(defun assoc-if (predicate alist &key (key nil key-supplied-p))
  (assoc-core predicate alist key key-supplied-p))

(declaim (notinline assoc-if))
