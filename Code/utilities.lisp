(cl:in-package #:constrictor)

(defun proper-list-p (list)
  (cond ((null list)
         0)
        ((atom list)
         (error 'list-must-be-proper-or-circular
                :datum list))
        (t
         (let ((fast list)
               (slow list)
               (count 0))
           (loop do (pop fast)
                    (incf count)
                 until (atom fast)
                 do (pop fast)
                    (incf count)
                    (pop slow)
                 until (or (atom fast) (eq fast slow))
                 finally (return (null fast)))))))

(defun assert-proper-list (list)
  (unless (proper-list-p list)
    (error 'list-must-be-proper
           :offending-list list)))

(defun copy-list-and-last (list)
  (cond ((null list)
         '())
        ((atom list)
         (error 'list-expected :datum list))
        (t
         (loop with head = (cons (car list) nil)
               for tail = head then (cdr tail)
               for rest = (cdr list) then (cdr rest)
               until (atom rest)
               do (setf (cdr tail)
                        (cons (car rest) nil))
               finally (setf (cdr tail) rest)
                       (return (values head tail))))))

(setf (documentation 'copy-list-and-last 'function)
      (format nil
              "Syntax: copy-list-and-last list~@
               ~@
               LIST must be a proper list or a dotted list.~@
               If a circular list is given as the value of LIST~@
               then this function will not terminate.  If LIST is~@
               an atom, then an error of type TYPE-ERROR will be~@
               signaled.~@
               ~@
               The list structure of LIST is copied, so that the~@
               return value of this function contains a copy of~@
               each of the top-level CONS cells of LIST.  Each copy~@
               contains the same CAR as the original cons cell, and~@
               the last CONS cell of the value returned form this~@
               function contains the same CDR as the last CONS cell~@
               of LIST.~@
               ~@
               If LIST is a CONS cell, then this function returns a~@
               second value which is the last CONS cell of the first~@
               return value."))

