(cl:in-package #:constrictor)

(declaim (inline subst-if-not-core))

(defun subst-if-not-core (new predicate tree key)
  (with-key (key)
    (labels ((subst-local (tree)
               (cond ((not (funcall predicate (apply-key tree)))
                      new)
                     ((atom tree) tree)
                     (t (cons (subst-local (car tree))
                              (subst-local (cdr tree)))))))
      (subst-local tree))))

(declaim (notinline subst-if-not-core))

(declaim (inline subst-if-not))

(defun subst-if-not (new predicate tree &key key)
  (subst-if-not-core new predicate tree key))

(declaim (notinline subst-if-not))
