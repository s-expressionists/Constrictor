(cl:in-package #:constrictor)

(setf (documentation 'listp 'function)
      (format nil "Syntax: listp object~@
                   ~@
                   Return T if the object given as an argument is a list,~@
                   i.e., either a CONS cell or the symbol NIL.~@
                   Otherwise, return NIL."))
