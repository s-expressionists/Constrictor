(cl:in-package #:constrictor)

(declaim (inline endp))

(defun endp (list)
  (check-type list cl:list)
  (null list))

(declaim (notinline endp))

(setf (documentation 'endp 'function)
      (format nil
              "Syntax: endp list~@
               ~@
               This function returns true if LIST is NIL, and it returns~@
               NIL if LIST is a CONS cell.  If LIST is not a list, i.e.,~@
               neither NIL or a CONS cell, an error of type TYPE-ERROR~@
               is signaled."))
