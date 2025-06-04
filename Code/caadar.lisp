(cl:in-package #:constrictor)

(declaim (inline caadar))

(defun caadar (list)
  (declare (inline car cadar))
  (car (cadar list)))

(declaim (notinline caadar))

(setf (documentation 'caadar 'function)
      (format nil
              "Syntax: caadar list~@
               ~@
               A call to this function is equivalent in all possible~@
               respects to a call (car (car (cdr (car list))))"))
