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
