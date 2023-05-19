(cl:in-package #:constrictor)

(declaim (inline subst-if-not-core))

(defun subst-if-not-core (new predicate tree key key-supplied-p)
  (with-key (key key-supplied-p)
    (labels ((subst-local (tree)
               (cond ((not (funcall predicate (apply-key tree)))
                      new)
                     ((atom tree) tree)
                     (t (cons (subst-local (car tree))
                              (subst-local (cdr tree)))))))
      (subst-local tree))))

(declaim (notinline subst-if-not-core))

(declaim (inline subst-if-not))

(defun subst-if-not (new predicate tree &key (key nil key-supplied-p))
  (subst-if-not-core new predicate tree key key-supplied-p))

(declaim (notinline subst-if-not))

(setf (documentation 'subst-if-not 'function)
      (format nil
              "Syntax: subst-if-not new predicate tree &key key~@
               ~@
               TREE is a tree where the leaves are atoms and~@
               the other nodes are CONS cells.  KEY is a designator~@
               for a function of one argument, or NIL.  If KEY is~@
               NIL or not supplied, then the function named IDENTITY~@
               is used.~@
               ~@
               This function traverses TREE, and applies first KEY~@
               to the node, and then PREDICATE to the value returned~@
               by applying KEY.  If the value obtained in NIL, then~@
               NEW is substituted for the node.  If the value obtained~@
               is true, and the node is an atom, then the node is~@
               returned.  Otherwise, i.e., the value returned is NIL~@
               and the node is a CONS cell, a new CONS cell is created~@
               such that the CAR is the value of recursively calling~@
               SUBST-IF-NOT on the CAR of the old CONS cell, and the CDR~@
               is the value of recursively calling SUBST-IF-NOT on the~@
               CDR of the old CONS cell."))
