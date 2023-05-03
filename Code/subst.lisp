(cl:in-package #:constrictor)

(declaim (inline subst-core))

(defun subst-core
    (new old tree key key-supplied-p test test-supplied-p test-not test-not-supplied-p)
  (with-key (key key-supplied-p)
    (with-test (test test-supplied-p test-not test-not-supplied-p)
      (labels ((subst-local (tree)
                 (cond ((apply-test (apply-key tree) old)
                        new)
                       ((atom tree) tree)
                       (t (cons (subst-local (car tree))
                                (subst-local (cdr tree)))))))
        (subst-local tree)))))

(declaim (notinline subst-core))

(declaim (inline subst))

(defun subst
    (new old tree
     &key
       (key nil key-supplied-p)
       (test #'eql test-supplied-p)
       (test-not #'eql test-not-supplied-p))
  (subst-core new old tree
              key key-supplied-p
              test test-supplied-p
              test-not test-not-supplied-p))

(declaim (notinline subst))

(setf (documentation 'subst 'function)
      (format nil
              "Syntax: subst new old tree &key key test test-not)~@
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
