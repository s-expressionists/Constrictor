(cl:in-package #:constrictor)

(defgeneric consp (object)
  (:method (object) nil)
  (:method ((object cons)) t))

(setf (documentation 'consp 'function)
      (format nil "CONSP OBJECT~@
                   Return T if the object given as an argument is a CONS cell.~@
                   Otherwise, return NIL."))

(defgeneric atom (object)
  (:method (object) t)
  (:method ((object cons)) nil))

(setf (documentation 'ATOM 'function)
      (format nil "ATOM OBJECT~@
                   Return T if the object given as an argument is an atom,~@
                   i.e., an object other than a CONS cell.  Return NIL if~@
                   the object given is a CONS cell."))

(defgeneric listp (object)
  (:method (object) nil)
  (:method ((object cons)) t)
  (:method ((object null)) t))
