(cl:in-package #:constrictor)

(declaim (inline last))

(defun last (list &optional (n 1))
  (check-type list cl:list)
  (check-type n (integer 0))
  (let ((head list)
        (tail list))
    (loop repeat n
          until (atom tail)
          do (pop tail))
    (loop until (atom tail)
          do (pop tail)
             (pop head))
    head))

(declaim (notinline last))
