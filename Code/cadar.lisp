(cl:in-package #:constrictor)

(declaim (inline cadar))

(defun cadar (list)
  (declare (inline car cdar))
  (car (cdar list)))

(declaim (notinline cadar))

(setf (documentation 'cadar 'function)
      (format nil
              "Syntax: cadar list~@
               ~@
               A call to this function is equivalent in all possible~@
               respects to a call (car (cdr (car list)))"))
