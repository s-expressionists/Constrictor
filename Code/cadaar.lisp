(cl:in-package #:constrictor)

(declaim (inline cadaar))

(defun cadaar (list)
  (declare (inline car cdaar))
  (car (cdaar list)))

(declaim (notinline cadaar))

(setf (documentation 'cadaar 'function)
      (format nil
              "Syntax: cadaar list~@
               ~@
               A call to this function is equivalent in all possible~@
               respects to a call (car (cdr (car (car list))))"))
