(cl:in-package #:constrictor)

(declaim (inline nconc))

(defun nconc (&rest lists)
  (if (null lists)
      nil
      (labels ((local-nconc (lists)
                 (destructuring-bind (first . rest) lists
                   (cond ((null rest) first)
                         ((null first) (local-nconc rest))
                         ((atom first)
                          (error 'type-error
                                 :datum first
                                 :expected-type 'cl:list))
                         ((null (cdr rest))
                          (rplacd (last first) (car rest))
                          first)
                         (t
                          (local-nconc
                           (cons (local-nconc (list first (car rest)))
                                 (cdr rest))))))))
        (local-nconc lists))))

(declaim (notinline nconc))

(setf (documentation 'nconc 'function)
      (format nil
              "Syntax: nconc &rest lists~@
               ~@
               Concatenate the objects in LISTS by destructively~@
               modifying the last CONS cell of every object except~@
               the last one so that it refers to the next object in~@
               order.  The last object in LISTS may be any object.~@
               Every object other than the last must be a proper list~@
               or a dotted list.  If an object other than the last is~@
               not a list, an error of type TYPE-ERROR is signaled.~@
               If an object other than the last is a circular list~@
               an error is signaled."))
