(cl:in-package #:constrictor)

(declaim (inline cadr))

(defun cadr (list)
  (declare (inline car cdr))
  (car (cdr list)))

(declaim (notinline cadr))

(setf (documentation 'cadr 'function)
      (format nil
              "Syntax: cadr list~@
               ~@
               A call to this function is equivalent in all possible~@
               respects to a call (car (cdr list))"))
