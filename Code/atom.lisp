(cl:in-package #:constrictor)

(defgeneric atom (object)
  (:method (object) t)
  (:method ((object cons)) nil))

(setf (documentation 'atom 'function)
      (format nil "ATOM OBJECT~@
                   Return T if the object given as an argument is an atom,~@
                   i.e., an object other than a CONS cell.  Return NIL if~@
                   the object given is a CONS cell."))
