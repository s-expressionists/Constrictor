(cl:in-package #:constrictor)

(declaim (inline caaar))

(defun caaar (list)
  (declare (inline car caar))
  (car (caar list)))

(declaim (notinline caaar))

(setf (documentation 'caaar 'function)
      (format nil
              "Syntax: caaar list~@
               ~@
               A call to this function is equivalent in all possible~@
               respects to a call (car (car (car list)))"))
