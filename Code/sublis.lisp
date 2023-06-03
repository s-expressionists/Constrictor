(cl:in-package #:constrictor)

(declaim (inline sublis-core))

(defun sublis-core
    (alist tree key key-supplied-p test test-supplied-p test-not test-not-supplied-p)
  (labels ((sublis-local (tree)
             (let ((entry (assoc-core tree alist
                                      key key-supplied-p
                                      test test-supplied-p
                                      test-not test-not-supplied-p)))
               (if (null entry)
                   (if (atom tree)
                       tree
                       (cons (sublis-local (car tree))
                             (sublis-local (cdr tree))))
                   (cdr entry)))))
    (sublis-local tree)))

(declaim (notinline sublis-core))

(declaim (inline sublis))

(defun sublis
    (alist tree
     &key
       (key nil key-supplied-p)
       (test #'eql test-supplied-p)
       (test-not #'eql test-not-supplied-p))
  (sublis-core alist tree
              key key-supplied-p
              test test-supplied-p
              test-not test-not-supplied-p))

(declaim (notinline sublis))

(setf (documentation 'sublis 'function)
      (format nil
              "Syntax: sublis alist tree &key key test test-not)~@
               ~@
               TREE is a tree where the leaves are atoms and~@
               the other nodes are CONS cells.  This function~@
               traverses TREE, and if an node is found that~@
               appears as key in ALIST, then the corresponding~@
               value associated with the key is returned.~@
               ~@
               If a node in TREE does not appear as a key in ALIST,
               then if the node is an atom, it is returned.  If the node~@
               in TREE does not appear as a key in ALIST, then if the node~@
               is a CONS cell, then a new CONS cell is created such that~@
               the CAR of the new CONS cell contains the result of~@
               calling SUBLIS recursively on the CAR of the old CONS cell,~@
               and the CDR of the new CONS cell contains the result of~@
               calling SUBLIS recursively on the CDR of the old CONS cell."))
