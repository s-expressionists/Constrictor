(cl:in-package #:constrictor)

(declaim (inline caaadr))

(defun caaadr (list)
  (declare (inline car caadr))
  (car (caadr list)))

(declaim (notinline caaadr))

(setf (documentation 'caaadr 'function)
      (format nil
              "Syntax: caaadr list~@
               ~@
               A call to this function is equivalent in all possible~@
               respects to a call (car (car (car (cdr list))))"))
