(cl:in-package #:constrictor)

(declaim (inline cdddar))

(defun cdddar (list)
  (declare (inline cdr cddar))
  (cdr (cddar list)))

(declaim (notinline cdddar))

(setf (documentation 'cdddar 'function)
      (format nil
              "Syntax: cdddar list~@
               ~@
               A call to this function is equivalent in all possible~@
               respects to a call (cdr (cdr (cdr (car list))))"))
