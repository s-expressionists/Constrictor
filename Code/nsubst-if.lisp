(cl:in-package #:constrictor)

(declaim (inline nsubst-if-core))

(defun nsubst-if-core (new predicate tree key)
  (with-key (key)
    (labels ((nsubst-if-local (tree)
                 (cond ((funcall predicate (apply-key (car tree)))
                        (rplaca tree new))
                       ((atom (car tree))
                        nil)
                       (t
                        (nsubst-if-local (car tree))))
                 (cond ((funcall predicate (apply-key (cdr tree)))
                        (rplacd tree new))
                       ((atom (cdr tree))
                        nil)
                       (t
                        (nsubst-if-local (cdr tree))))))
      (cond ((funcall predicate (apply-key tree))
             new)
            ((atom tree)
             tree)
            (t (nsubst-if-local tree)
               tree)))))

(declaim (notinline nsubst-if-core))

(declaim (inline nsubst-if))

(defun nsubst-if (new predicate tree &key key)
  (with-canonical-key (key)
    (nsubst-if-core new predicate tree key)))

(declaim (notinline nsubst-if))
