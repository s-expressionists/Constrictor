(cl:in-package #:constrictor)

(declaim (inline make-list))

;;; We could have used the COLLECT LOOP keyword, but it is then likely
;;; that there is an additional test. 
(defun make-list (length &key (initial-element nil))
  (check-type length (integer 0))
  (loop with result = '()
        repeat length
        do (push initial-element result)
        finally (return result)))
