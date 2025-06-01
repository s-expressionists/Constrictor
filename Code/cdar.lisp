(cl:in-package #:constrictor)

(declaim (inline cdar))

(defun cdar (list)
  (declare (inline car cdr))
  (car (cdr list)))

(declaim (notinline cdar))

(setf (documentation 'cdar 'function)
      (format nil
              "Syntax: cdar list~@
               ~@
               A call to this function is equivalent in all possible~@
               respects to a call (cdr (car list))"))
