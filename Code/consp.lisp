(cl:in-package #:constrictor)

(defgeneric consp (object)
  (:method (object) nil)
  (:method ((object cons)) t))

(setf (documentation 'consp 'function)
      (format nil "Syntax: consp object~@
                   Return T if OBJECT is a CONS cell.~@
                   Otherwise, return NIL."))
