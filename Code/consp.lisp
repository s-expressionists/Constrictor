(cl:in-package #:constrictor)

(defgeneric consp (object)
  (:method (object) nil)
  (:method ((object cons)) t))

(setf (documentation 'consp 'function)
      (format nil "CONSP OBJECT~@
                   Return T if the object given as an argument is a CONS cell.~@
                   Otherwise, return NIL."))
