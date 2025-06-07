(cl:in-package #:constrictor)

(declaim (inline cddadr))

(defun cddadr (list)
  (declare (inline cdr cdadr))
  (cdr (cdadr list)))

(declaim (notinline cddadr))

(setf (documentation 'cddadr 'function)
      (format nil
              "Syntax: cddadr list~@
               ~@
               A call to this function is equivalent in all possible~@
               respects to a call (cdr (cdr (car (cdr list))))"))
