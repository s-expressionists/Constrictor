(cl:in-package #:constrictor)

(declaim (inline cadadr))

(defun cadadr (list)
  (declare (inline car cdadr))
  (car (cdadr list)))

(declaim (notinline cadadr))

(setf (documentation 'cadadr 'function)
      (format nil
              "Syntax: cadadr list~@
               ~@
               A call to this function is equivalent in all possible~@
               respects to a call (car (cdr (car (cdr list))))"))
