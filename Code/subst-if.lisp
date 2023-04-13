(cl:in-package #:constrictor)

(declaim (inline subst-if))

(defun subst-if (new predicate tree &key key)
  (macrolet ((make-local (test)
               `(labels ((subst-local (tree)
                           (cond (,test new)
                                 ((atom tree) tree)
                                 (t (cons (subst-local (car tree))
                                          (subst-local (cdr tree)))))))
                  (subst-local tree))))
    (if (or (null key) (eq key #'identity) (eq key 'identity))
        (make-local (funcall predicate new))
        (make-local (funcall predicate (funcall key new))))))

(declaim (notinline subst-if))
