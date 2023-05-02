(cl:in-package #:constrictor)

(defgeneric listp (object)
  (:method (object) nil)
  (:method ((object cons)) t)
  (:method ((object cl:null)) t))

(setf (documentation 'listp 'function)
      (format nil "LISTP OBJECT~@
                   Return T if the object given as an argument is a list, i.e.,~@
                   either a CONS cell or the symbol NIL.  Otherwise, return NIL."))
