(cl:in-package #:constrictor)

(defun proper-list-p (value)
  (typecase value
    (null
     t)
    (cons
     (prog ((step1 (cdr value))
            (step2 value))
        (unless (consp (cdr step2))
          (return (null (cdr step2))))
        (setf step2 (cddr step2))
      next
        (unless (and (listp step2)
                     (consp (cdr step2)))
          (return (and (listp step2)
                       (null (cdr step2)))))
        (when (eq step2 step1)
          (return nil))
        (setf step1 (cdr step1)
              step2 (cddr step2))
        (go next)))
    (t
     nil)))

(deftype proper-list ()
  `(satisfies proper-list-p))

(defun assert-proper-list (list)
  (unless (proper-list-p list)
    (error 'type-error
           :datum list
           :expected-type 'proper-list)))

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

