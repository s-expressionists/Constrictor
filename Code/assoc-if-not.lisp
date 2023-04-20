(cl:in-package #:constrictor)

(declaim (inline assoc-if-not-core))

(defun assoc-if-not-core (predicate alist key key-supplied-p)
  (with-key (key key-supplied-p)
    (with-alist-elements (element alist)
      (unless (funcall predicate (apply-key (car element)))
        (return-from assoc-if-not-core element)))))

(declaim (notinline assoc-if-not-core))

(declaim (inline assoc-if-not))

(defun assoc-if-not (predicate alist &key (key nil key-supplied-p))
  (assoc-core predicate alist key key-supplied-p))

(declaim (notinline assoc-if-not))
