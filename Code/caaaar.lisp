(cl:in-package #:constrictor)

(declaim (inline caaaar))

(defun caaaar (list)
  (declare (inline car caaar))
  (car (caaar list)))

(declaim (notinline caaaar))

(setf (documentation 'caaaar 'function)
      (format nil
              "Syntax: caaaar list~@
               ~@
               A call to this function is equivalent in all possible~@
               respects to a call (car (car (car (car list))))"))
