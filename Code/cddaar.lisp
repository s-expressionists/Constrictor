(cl:in-package #:constrictor)

(declaim (inline cddaar))

(defun cddaar (list)
  (declare (inline cdr cdaar))
  (cdr (cdaar list)))

(declaim (notinline cddaar))

(setf (documentation 'cddaar 'function)
      (format nil
              "Syntax: cddaar list~@
               ~@
               A call to this function is equivalent in all possible~@
               respects to a call (cdr (cdr (car (car list))))"))
