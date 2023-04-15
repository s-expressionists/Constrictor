(cl:in-package #:constrictor)

(declaim (inline assoc-if-not-core))

(defun assoc-if-not-core (predicate alist key)
  (with-key (key)
    (with-alist-elements (element alist)
      (unless (funcall predicate (apply-key (car element)))
        (return-from assoc-if-not-core element)))))

(declaim (notinline assoc-if-not-core))

(declaim (inline assoc-if-not))

(defun assoc-if-not (predicate alist &key key)
  (with-canonical-key (key)
    (assoc-core predicate alist key)))

(declaim (notinline assoc-if-not))
