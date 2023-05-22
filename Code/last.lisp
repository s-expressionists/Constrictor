(cl:in-package #:constrictor)

(declaim (inline last))

(defun last (list &optional (n 1))
  (check-type list cl:list)
  (check-type n (integer 0))
  ;; We make an explicit test for the empty list, because the form (EQ
  ;; SLOW TAIL) would otherwise return true, and we would incorrectly
  ;; report the list as being circular.
  (if (null list)
      nil
      ;; The CONS cells starting at HEAD will be returned.  TAIL is
      ;; used to detect the end of the list.
      (let ((tail list))
        (loop repeat n
              until (atom tail)
              do (pop tail))
        (loop with head = list
              with slow = list
              until (atom tail)
              do (pop tail)
                 (pop head)
              until (atom tail)
              do (pop tail)
                 (pop head)
                 (pop slow)
              until (eq slow tail)
              finally (if (eq slow tail)
                          (error 'list-must-not-be-a-circular-list
                                 :datum list)
                          (return head))))))

(declaim (notinline last))

(setf (documentation 'last 'function)
      (format nil
              "Syntax: last list &optional n~@
               ~@
               LIST must be a list that is either a proper list~@
               or a dotted list.  This function returns the lst N~@
               CONS cell of LIST.  The default value for N is 1.~@
               If N is 0, then the atom that terminates the list is~@
               returned.  If N greater than or equal to the number~@
               of CONS cells in LIST, then this function returns LIST.~@
               ~@
               If N is not a non-negative integer, then an error of~@
               type TYPE-ERROR is signaled.  If LIST is not a list,~@
               then an error of type TYPE-ERROR is signaled.  If LIST~@
               is a circular list, then an error is signaled."))
