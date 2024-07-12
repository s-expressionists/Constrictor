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
  (member-if-core predicate list key key-supplied-p))

(declaim (notinline member-if))

(setf (documentation 'member-if 'function)
      (format nil
              "Syntax: member-if predicate list &key key~@
               ~%~a~%~%~a~%~@
               PREDICATE is applied to the result of applying KEY~@
               to an element of LIST, and if PREDICATE returns true~@
               for that element, then the suffix of LIST starting at~@
               that element is returned.~%~%~a"
              *key*
              *key-applied-to-elements-of-list*
              *list-should-be-proper*))
