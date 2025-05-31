(cl:in-package #:constrictor)

(declaim (inline caar))

(defun caar (list)
  (declare (inline car))
  (car (car list)))

(declaim (notinline caar))

(setf (documentation 'caar 'function)
      (format nil
              "Syntax: caar list~@
               ~@
               A call to this function is equivalent in all possible~@
               respects to a call (car (car list))"))
