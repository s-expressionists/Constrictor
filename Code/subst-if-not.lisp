(cl:in-package #:constrictor)

(declaim (inline subst-if-not-core))

(defun subst-if-not-core (new predicate tree key key-supplied-p)
  (with-key (key key-supplied-p)
    (labels ((subst-local (tree)
               (cond ((not (funcall predicate (apply-key tree)))
                      new)
                     ((atom tree) tree)
                     (t (cons (subst-local (car tree))
                              (subst-local (cdr tree)))))))
      (subst-local tree))))

(declaim (notinline subst-if-not-core))

(declaim (inline subst-if-not))

(defun subst-if-not (new predicate tree &key (key nil key-supplied-p))
  (subst-if-not-core new predicate tree key key-supplied-p))

(declaim (notinline subst-if-not))
