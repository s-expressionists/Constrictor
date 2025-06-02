(cl:in-package #:constrictor)

(declaim (inline caadr))

(defun caadr (list)
  (declare (inline car cadr))
  (car (cadr list)))

(declaim (notinline caadr))

(setf (documentation 'caadr 'function)
      (format nil
              "Syntax: caadr list~@
               ~@
               A call to this function is equivalent in all possible~@
               respects to a call (car (car (cdr list)))"))
