(cl:in-package #:constrictor)

(declaim (inline member-if-core))

(defun member-if-core (predicate list key)
  (with-key (key)
    (with-proper-list-rests (rest list)
      (when (funcall predicate (apply-key (car rest)))
        (return-from member-if-core rest)))))

(declaim (notinline member-if-core))

(declaim (inline member-if))

(defun member-if (predicate list &key key)
  (with-canonical-key (key)
    (member-core predicate list key)))

(declaim (notinline member-if))
