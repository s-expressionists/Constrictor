(cl:in-package #:constrictor)

(declaim (inline member-if-core))

(defun member-if-not-core (predicate list key)
  (with-key (key)
    (with-proper-list-rests (rest list)
      (unless (funcall predicate (apply-key (car rest)))
        (return-from member-if-not-core rest)))))

(declaim (notinline member-if-not-core))

(declaim (inline member-if-not))

(defun member-if-not (predicate list &key key)
  (with-canonical-key (key)
    (member-core predicate list key)))

(declaim (notinline member-if-not))
