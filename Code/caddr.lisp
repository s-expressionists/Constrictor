(cl:in-package #:constrictor)

(declaim (inline caddr))

(defun caddr (list)
  (declare (inline car cddr))
  (car (cddr list)))

(declaim (notinline caddr))

(setf (documentation 'caddr 'function)
      (format nil
              "Syntax: caddr list~@
               ~@
               A call to this function is equivalent in all possible~@
               respects to a call (car (cdr (cdr list)))"))
