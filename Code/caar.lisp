(cl:in-package #:constrictor)

(declaim (inline caar))

(defun caar (list)
  (declare (inline car))
  (car (car list)))

(declaim (notinline caar))

(declaim (inline (setf caar)))

(defun (setf caar) (new-value cons)
  (declare (inline rplaca car ))
  (rplaca (car cons) new-value)
  new-value)

(declaim (notinline (setf caar)))

(setf (documentation 'caar 'function)
      (format nil
              "Syntax: caar list~@
               ~@
               A call to this function is equivalent in all possible~@
               respects to a call (car (car list))"))
