(cl:in-package #:constrictor)

(declaim (inline nthcdr))

(defun nthcdr (n list)
  (unless (listp list)
    (error 'must-be-list :datum list))
  (loop for result on list
        repeat n
        until (atom result)
        count t into iteration-count
        finally (cond ((= n iteration-count)
                       (return result))
                      ((null result)
                       (return nil))
                      (t (error 'dotted-list-with-too-few-cons-cells
                                :minimum-cons-cell-count n
                                :offending-list list)))))

(declaim (notinline nthcdr))
