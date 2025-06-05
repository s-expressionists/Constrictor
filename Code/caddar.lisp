(cl:in-package #:constrictor)

(declaim (inline caddar))

(defun caddar (list)
  (declare (inline car cddar))
  (car (cddar list)))

(declaim (notinline caddar))

(setf (documentation 'caddar 'function)
      (format nil
              "Syntax: caddar list~@
               ~@
               A call to this function is equivalent in all possible~@
               respects to a call (car (cdr (cdr (car list))))"))
