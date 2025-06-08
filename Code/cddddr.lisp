(cl:in-package #:constrictor)

(declaim (inline cddddr))

(defun cddddr (list)
  (declare (inline cdr cdddr))
  (cdr (cdddr list)))

(declaim (notinline cddddr))

(setf (documentation 'cddddr 'function)
      (format nil
              "Syntax: cddddr list~@
               ~@
               A call to this function is equivalent in all possible~@
               respects to a call (cdr (cdr (cdr (cdr list))))"))
