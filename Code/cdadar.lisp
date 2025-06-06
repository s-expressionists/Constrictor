(cl:in-package #:constrictor)

(declaim (inline cdadar))

(defun cdadar (list)
  (declare (inline cdr cadar))
  (cdr (cadar list)))

(declaim (notinline cdadar))

(setf (documentation 'cdadar 'function)
      (format nil
              "Syntax: cdadar list~@
               ~@
               A call to this function is equivalent in all possible~@
               respects to a call (cdr (car (cdr (car list))))"))
