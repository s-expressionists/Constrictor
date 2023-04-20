(cl:in-package #:constrictor)

(declaim (inline member-if-core))

(defun member-if-core (predicate list key key-supplied-p)
  (with-key (key key-supplied-p)
    (with-proper-list-rests (rest list)
      (when (funcall predicate (apply-key (car rest)))
        (return-from member-if-core rest)))))

(declaim (notinline member-if-core))

(declaim (inline member-if))

(defun member-if (predicate list &key (key nil key-supplied-p))
  (member-core predicate list key key-supplied-p))

(declaim (notinline member-if))
