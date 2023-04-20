(cl:in-package #:constrictor)

(declaim (inline member-if-core))

(defun member-if-not-core (predicate list key key-supplied-p)
  (with-key (key key-supplied-p)
    (with-proper-list-rests (rest list)
      (unless (funcall predicate (apply-key (car rest)))
        (return-from member-if-not-core rest)))))

(declaim (notinline member-if-not-core))

(declaim (inline member-if-not))

(defun member-if-not (predicate list &key (key nil key-supplied-p))
  (member-core predicate list key key-supplied-p))

(declaim (notinline member-if-not))
