(cl:in-package #:constrictor)

(declaim (inline cddar))

(defun cddar (list)
  (declare (inline cdr cdar))
  (cdr (cdar list)))

(declaim (notinline cddar))

(setf (documentation 'cddar 'function)
      (format nil
              "Syntax: cddar list~@
               ~@
               A call to this function is equivalent in all possible~@
               respects to a call (cdr (cdr (car list)))"))
