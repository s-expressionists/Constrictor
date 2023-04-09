(cl:in-package #:constrictor)

(declaim (inline subst))

(defun subst
    (new old tree
     &key
       (key nil)
       (test #'eql test-supplied-p)
       (test-not #'eql test-not-supplied-p))
  (when (and test-supplied-p test-not-supplied-p)
    (error 'both-test-and-test-not-supplied
           "Both keyword arguments :TEST and :TEST-NOT supplied."))
  (macrolet ((make-local (test)
               `(labels ((subst-local (tree)
                           (cond (,test new)
                                 ((atom tree) tree)
                                 (t (cons (subst-local (car tree))
                                          (subst-local (cdr tree)))))))
                  (subst-local tree))))
    (if (or (null key) (eq key #'identity) (eq key 'identity))
        (cond ((and (not test-not-supplied-p)
                    (or (eq test #'eql) (eq test 'eql)))
               (make-local (eql tree old)))
              ((and (not test-not-supplied-p)
                    (or (eq test #'eq) (eq test 'eq)))
               (make-local (eq tree old)))
              ((not test-not-supplied-p)
               (make-local (funcall test tree old)))
              (t
               (make-local (not (funcall test-not tree old)))))
        (cond ((and (not test-not-supplied-p)
                    (or (eq test #'eql) (eq test 'eql)))
               (make-local (eql (funcall key tree) old)))
              ((and (not test-not-supplied-p)
                    (or (eq test #'eq) (eq test 'eq)))
               (make-local (eq (funcall key tree) old)))
              ((not test-not-supplied-p)
               (make-local (funcall test (funcall key tree) old)))
              (t
               (make-local (not (funcall test (funcall key tree) old))))))))

(declaim (notinline subst))
