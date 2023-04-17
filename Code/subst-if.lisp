(cl:in-package #:constrictor)

(declaim (inline subst-if-core))

(defun subst-if-core (new predicate tree key)
  (with-key (key)
    (labels ((subst-local (tree)
               (cond ((funcall predicate (apply-key tree))
                      new)
                     ((atom tree) tree)
                     (t (cons (subst-local (car tree))
                              (subst-local (cdr tree)))))))
      (subst-local tree))))

(declaim (notinline subst-if-core))

(declaim (inline subst-if))

(defun subst-if (new predicate tree &key key)
  (subst-if-core new predicate tree key))

(declaim (notinline subst-if))
