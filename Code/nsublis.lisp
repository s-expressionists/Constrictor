(cl:in-package #:constrictor)

(declaim (inline nsublis-core))

(defun nsublis-core
    (alist tree key key-supplied-p test test-supplied-p test-not test-not-supplied-p)
  (with-key (key key-supplied-p)
    (labels ((nsublis-local (tree)
               (let ((entry (assoc-core (apply-key tree) alist
                                        nil nil
                                        test test-supplied-p
                                        test-not test-not-supplied-p)))
                 (cond ((consp entry)
                        (cdr entry))
                       ((consp tree)
                        (rplaca tree (nsublis-local (car tree)))
                        (rplacd tree (nsublis-local (cdr tree)))
                        tree)
                       (t
                        tree)))))
      (nsublis-local tree))))

(declaim (notinline nsublis-core))

(declaim (inline nsublis))

(defun nsublis
    (alist tree
     &key
       (key nil key-supplied-p)
       (test #'eql test-supplied-p)
       (test-not #'eql test-not-supplied-p))
  (nsublis-core alist tree
              key key-supplied-p
              test test-supplied-p
              test-not test-not-supplied-p))

(declaim (notinline nsublis))

(setf (documentation 'nsublis 'function)
      (format nil
              "Syntax: nsublis alist tree &key key test test-not)~@
               ~@
               TREE is a tree where the leaves are atoms and~@
               the other nodes are CONS cells.  This function~@
               traverses TREE, and if an node is found that~@
               appears as key in ALIST, then the corresponding~@
               value associated with the key is used to destructively~@
               replace the node.~@
               ~@
               If a node in TREE does not appear as a key in ALIST,
               then if the node is an atom, it is returned.  If the node~@
               in TREE does not appear as a key in ALIST, then if the node~@
               is a CONS cell, then the CAR and the CDR of the CONS cell~@
               are both processed recursively, and then the modified node~@
               is returned."))
