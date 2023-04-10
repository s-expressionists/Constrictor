(cl:in-package #:constrictor)

(declaim (inline endp))

(defun endp (list)
  (check-type list cl:list)
  (null list))

(declaim (notinline endp))
