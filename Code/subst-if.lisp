(cl:in-package #:constrictor)

(declaim (inline subst-if-core))

(defun subst-if-core (new predicate tree key key-supplied-p)
  (with-key (key key-supplied-p)
    (labels ((subst-local (tree)
               (cond ((funcall predicate (apply-key tree))
                      new)
                     ((atom tree) tree)
                     (t (cons (subst-local (car tree))
                              (subst-local (cdr tree)))))))
      (subst-local tree))))

(declaim (notinline subst-if-core))

(declaim (inline subst-if))

(defun subst-if (new predicate tree &key (key nil key-supplied-p))
  (subst-if-core new predicate tree key key-supplied-p))

(declaim (notinline subst-if))
