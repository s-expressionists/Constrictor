(cl:in-package #:constrictor)

(declaim (inline cdadr))

(defun cdadr (list)
  (declare (inline cdr cadr))
  (cdr (cadr list)))

(declaim (notinline cdadr))

(setf (documentation 'cdadr 'function)
      (format nil
              "Syntax: cdadr list~@
               ~@
               A call to this function is equivalent in all possible~@
               respects to a call (cdr (car (cdr list)))"))
