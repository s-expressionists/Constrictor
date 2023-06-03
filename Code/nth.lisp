(cl:in-package #:constrictor)

(declaim (inline nth))

(defun nth (n list)
  (unless (listp list)
    (error 'list-expected :datum list))
  (check-type n (integer 0))
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

(setf (documentation 'nth 'function)
      (format nil
              "Syntax: nth n list~@
               ~@
               Return the Nth element of LIST, where N=0~@
               means the first element of LIST.  LIST may be~@
               a dotted list or a circular list, but if LIST~@
               has at most N CONS cells, then an error is~@
               signaled.  If N is not a non-negative integer,~@
               then an error is signaled."))
