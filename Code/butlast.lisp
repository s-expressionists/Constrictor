(cl:in-package #:constrictor)

(declaim (inline butlast))

;;; The HyperSpec doesn't specify what happens if n is 0.  There is a
;;; note that says:
;;;
;;;     (butlast list n) ==  (ldiff list (last list n))
;;;
;;; but notes are not normative.  If you do believe this note, then
;;; (butlast '(1 2 3 . 4) 0) should return (1 2 3), i.e., it doesn't
;;; return the unmodified list.
;;;
;;; This implementation works according to the HyperSpec note when n
;;; is 0.

(defun butlast (list &optional (n 1))
  (check-type list cl:list)
  (check-type n (integer 0))
  (let ((tail list))
    (loop repeat n
          until (atom tail)
          do (pop tail))
    (loop with head = list
          for slow on tail
          until (atom tail)
          do (pop tail)
          collect (prog1 (car head) (pop head))
          until (atom tail)
          do (pop tail)
          collect (prog1 (car head) (pop head))
          do (when (eq slow tail)
               ;; we have a circular list
               (error 'must-be-proper-or-dotted-list
                      :datum list)))))

(declaim (notinline butlast))

(setf (documentation 'butlast 'function)
      (format nil
              "Syntax: butlast list &optional n~@
               ~@
               LIST must be a list that is either a proper list~@
               or a dotted list.  This function returns a copy of~@
               LIST from which the last N CONS cells have been omitted.~@
               The default value for N is 1. If N is 0, then if LIST~@
               is a proper list, a copy of LIST is returned.  If N is 0~@
               and LIST is a dotted list, a proper list is returned that
               is like LIST, except that the CDR of the last CONS cell~@
               is NIL rather than the atom of the last CONS cell of LIST.~@
               If N greater than or equal to the number of CONS cells in~@
               LIST, then this function returns the empty list.~@
               ~@
               If N is not a non-negative integer, then an error of~@
               type TYPE-ERROR is signaled.  If LIST is not a list,~@
               then an error of type TYPE-ERROR is signaled.  If LIST~@
               is a circular list, then an error is signaled."))
