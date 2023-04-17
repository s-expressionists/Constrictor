(cl:in-package #:constrictor)

(declaim (inline nsubst-if-not-core))

(defun nsubst-if-not-core (new predicate tree key)
  (with-key (key)
    (labels ((nsubst-if-not-local (tree)
                 (cond ((not (funcall predicate (apply-key (car tree))))
                        (rplaca tree new))
                       ((atom (car tree))
                        nil)
                       (t
                        (nsubst-if-not-local (car tree))))
                 (cond ((not (funcall predicate (apply-key (cdr tree))))
                        (rplacd tree new))
                       ((atom (cdr tree))
                        nil)
                       (t
                        (nsubst-if-not-local (cdr tree))))))
      (cond ((not (funcall predicate (apply-key tree)))
             new)
            ((atom tree)
             tree)
            (t (nsubst-if-not-local tree)
               tree)))))

(declaim (notinline nsubst-if-not-core))

(declaim (inline nsubst-if-not))

(defun nsubst-if-not (new predicate tree &key key)
  (nsubst-if-not-core new predicate tree key))

(declaim (notinline nsubst-if-not))
