(cl:in-package #:constrictor)

(declaim (inline cdaaar))

(defun cdaaar (list)
  (declare (inline cdr caaar))
  (cdr (caaar list)))

(declaim (notinline cdaaar))

(setf (documentation 'cdaaar 'function)
      (format nil
              "Syntax: cdaaar list~@
               ~@
               A call to this function is equivalent in all possible~@
               respects to a call (cdr (car (car (car list))))"))
