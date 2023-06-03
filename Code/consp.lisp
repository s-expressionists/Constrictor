(cl:in-package #:constrictor)

(setf (documentation 'consp 'function)
      (format nil "Syntax: consp object~@
                   ~@
                   Return T if OBJECT is a CONS cell.~@
                   Otherwise, return NIL."))
