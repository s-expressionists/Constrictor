(cl:in-package #:constrictor)

(declaim (inline nbutlast))

(defun nbutlast (list &optional (n 1))
  (check-type list cl:list)
  (check-type n (integer 0))
  (when (zerop n)
    (return-from nbutlast list))
  (let ((tail list))
    (loop repeat n
          until (atom tail)
          do (pop tail)
          finally (when (atom tail)
                    (return-from nbutlast '())))
    (pop tail)
    (loop with head = list
          for slow on tail
          until (atom tail)
          do (pop head)
             (pop tail)
          until (atom tail)
          do (pop head)
             (pop tail)
             (when (eq slow tail)
               ;; we have a circular list
               (error 'list-must-not-be-a-circular-list
                      :offending-list list))
          finally (rplacd head '())
                  (return list))))

(declaim (notinline nbutlast))

(setf (documentation 'nbutlast 'function)
      (format nil
              "Syntax: nbutlast list &optional n~@
               ~@
               LIST must be a list that is either a proper list~@
               or a dotted list.  This function modifies LIST so~@
               that the last N CONS cells are replaced by NIL.~@
               If N is 0, then LIST is not modified, and LIST is~@
               returned as the value of NBUTLAST.  If N is greater~@
               than or equal to the number of CONS cells in LIST,~@
               then LIST is not modified, and NBUTLAST returns NIL.~@
               ~@
               If N is not a non-negative integer, then an error of~@
               type TYPE-ERROR is signaled.  If LIST is not a list,~@
               then an error of type TYPE-ERROR is signaled.  If LIST~@
               is a circular list, then an error is signaled."))
