(cl:in-package #:constrictor)

(declaim (inline copy-tree))

(defun copy-tree (tree)
  (labels ((copy-tree-local (tree)
             (if (atom tree)
                 tree
                 (cons (copy-tree-local (car tree))
                       (copy-tree-local (cdr tree))))))
    (copy-tree-local tree)))

(declaim (notinline copy-tree))

(setf (documentation 'copy-tree 'function)
      (format nil
              "Syntax: copy-tree tree~@
               ~@
               This function returns a copy of TREE.  If TREE is~@
               an atom, then it is returned.  If not, this function~@
               returnes a new CONS cell which contains the result of~@
               recursively calling COPY-TREE on the CAR of TREE in its~@
               CAR slot, and the result of recursively calling COPY-TREE~@
               on the CDR of TREE in its CDR slot."))
