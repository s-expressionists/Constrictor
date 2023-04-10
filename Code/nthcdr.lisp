(cl:in-package #:constrictor)

(defun nthcdr (n list)
  (unless (listp list)
    (cl:error 'type-error
              :datum list
              :expected-type 'cl:list))
  (loop for result on list
        repeat n
        until (atom result)
        count t into iteration-count
        finally (cond ((= n iteration-count)
                       (return result))
                      ((null result)
                       (return nil))
                      (t (error 'dotted-list-with-too-few-cons-cells
                                "Either a dotted list with at least ~s CONS~@
                                 cells, a proper list, or a circular list~@
                                 was expected but the following was given:~@
                                 ~s" n list)))))


           
