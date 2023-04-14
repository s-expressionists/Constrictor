(cl:in-package #:constrictor)

(declaim (inline nth))

(defun nth (n list)
  (unless (listp list)
    (error 'must-be-list :datum list))
  (loop for result on list
        repeat n
        until (atom result)
        count t into iteration-count
        finally (cond ((and (= n iteration-count) (consp result))
                       (return (car result)))
                      ((null result)
                       (return nil))
                      (t (error 'dotted-list-with-too-few-cons-cells
                                :minimum-cons-cell-count (1+ n)
                                :offending-list list)))))

(declaim (notinline nth))
