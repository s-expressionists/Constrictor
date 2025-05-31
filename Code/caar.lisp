(cl:in-package #:constrictor)

(declaim (inline caar))

(defun caar (list)
  (declare (inline car))
  (car (car list)))

(declaim (notinline caar))
