(cl:in-package #:constrictor)

(declaim (inline cdaddr))

(defun cdaddr (list)
  (declare (inline cdr caddr))
  (cdr (caddr list)))

(declaim (notinline cdaddr))

(setf (documentation 'cdaddr 'function)
      (format nil
              "Syntax: cdaddr list~@
               ~@
               A call to this function is equivalent in all possible~@
               respects to a call (cdr (car (cdr (cdr list))))"))
