(cl:in-package #:constrictor)

(declaim (inline caaddr))

(defun caaddr (list)
  (declare (inline car caddr))
  (car (caddr list)))

(declaim (notinline caaddr))

(setf (documentation 'caaddr 'function)
      (format nil
              "Syntax: caaddr list~@
               ~@
               A call to this function is equivalent in all possible~@
               respects to a call (car (car (cdr (cdr list))))"))
