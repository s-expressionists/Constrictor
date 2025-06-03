(cl:in-package #:constrictor)

(declaim (inline cdaar))

(defun cdaar (list)
  (declare (inline cdr caar))
  (cdr (caar list)))

(declaim (notinline cdaar))

(setf (documentation 'cdaar 'function)
      (format nil
              "Syntax: cdaar list~@
               ~@
               A call to this function is equivalent in all possible~@
               respects to a call (cdr (car (car list)))"))
