(cl:in-package #:constrictor)

(declaim (inline cdddr))

(defun cdddr (list)
  (declare (inline cdr cddr))
  (cdr (cddr list)))

(declaim (notinline cdddr))

(setf (documentation 'cdddr 'function)
      (format nil
              "Syntax: cdddr list~@
               ~@
               A call to this function is equivalent in all possible~@
               respects to a call (cdr (cdr (cdr list)))"))
