(cl:in-package #:constrictor)

(declaim (inline cadddr))

(defun cadddr (list)
  (declare (inline car cdddr))
  (car (cdddr list)))

(declaim (notinline cadddr))

(setf (documentation 'cadddr 'function)
      (format nil
              "Syntax: cadddr list~@
               ~@
               A call to this function is equivalent in all possible~@
               respects to a call (car (cdr (cdr (cdr list))))"))
