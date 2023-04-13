(cl:in-package #:constrictor)

(declaim (inline subst-if-not))

(defun subst-if-not (new predicate tree &key key)
  (macrolet ((make-local (test)
               `(labels ((subst-local (tree)
                           (cond (,test new)
                                 ((atom tree) tree)
                                 (t (cons (subst-local (car tree))
                                          (subst-local (cdr tree)))))))
                  (subst-local tree))))
    (if (or (null key) (eq key #'identity) (eq key 'identity))
        (make-local (not (funcall predicate new)))
        (make-local (not (funcall predicate (funcall key new)))))))

(declaim (notinline subst-if-not))
