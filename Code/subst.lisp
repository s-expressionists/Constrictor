(cl:in-package #:constrictor)

(declaim (inline subst))

(defun subst
    (new old tree
     &key
       (key nil)
       (test #'eql test-supplied-p)
       (test-not #'eql test-not-supplied-p))
  (when (and test-supplied-p test-not-supplied-p)
    (error 'both-test-and-test-not-supplied))
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

(setf (documentation 'subst 'function)
      (format nil
              "(subst new old tree &key key test test-not)~@
               TREE is a tree where the leaves are atoms and~@
               the other nodes are CONS cells.  This function~@
               traverses TREE, and if an occurrence of OLD is found,~@
               then SUBST returns NEW.~@
               ~@
               If a node in TREE is not an occurrence of OLD, then~@
               if the node is an atom, it is returned.  If the node~@
               in TREE is not an occurrence of OLD, then if the node~@
               is a CONS cell, then a new CONS cell is created such that~@
               the CAR of the new CONS cell contains the result of~@
               calling SUBST recursively on the CAR of the old CONS cell,~@
               and the CDR of the new CONS cell contains the result of~@
               calling SUBST recursively on the CDR of the old CONS cell."))
