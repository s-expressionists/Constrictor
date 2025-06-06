(cl:in-package #:constrictor)

(declaim (inline cdaadr))

(defun cdaadr (list)
  (declare (inline cdr caadr))
  (cdr (caadr list)))

(declaim (notinline cdaadr))

(setf (documentation 'cdaadr 'function)
      (format nil
              "Syntax: cdaadr list~@
               ~@
               A call to this function is equivalent in all possible~@
               respects to a call (cdr (car (car (cdr list))))"))
