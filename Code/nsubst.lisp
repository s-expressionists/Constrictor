(cl:in-package #:constrictor)

(declaim (inline nsubst-core))

(defun nsubst-core (new old tree key test test-not)
  (with-key (key)
    (with-test (test test-not)
      (labels ((nsubst-local (tree)
                 (cond ((apply-test (apply-key (car tree)) old)
                        (rplaca tree new))
                       ((atom (car tree))
                        nil)
                       (t
                        (nsubst-local (car tree))))
                 (cond ((apply-test (apply-key (cdr tree)) old)
                        (rplacd tree new))
                       ((atom (cdr tree))
                        nil)
                       (t
                        (nsubst-local (cdr tree))))))
        (cond ((apply-test (apply-key tree) old)
               new)
              ((atom tree)
               tree)
              (t (nsubst-local tree)
                 tree))))))

(declaim (notinline nsubst-core))

(declaim (inline nsubst))

(defun nsubst
    (new old tree
     &key
       (key nil)
       (test #'eql test-supplied-p)
       (test-not #'eql test-not-supplied-p))
  (with-canonical-key-test-test-not
      (key test test-supplied-p test-not test-not-supplied-p)
    (nsubst-core new old tree key test test-not)))

(declaim (notinline nsubst))
