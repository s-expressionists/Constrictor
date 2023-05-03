(cl:in-package #:constrictor)

(defgeneric atom (object)
  (:method (object) t)
  (:method ((object cons)) nil))

(setf (documentation 'atom 'function)
      (format nil "Syntax: atom object~@
                   Return T if OBJECT is an atom, i.e.,~@
                   an object other than a CONS cell.~@
                   Return NIL if OBJECT is a CONS cell."))
