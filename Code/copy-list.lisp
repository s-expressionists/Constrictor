(cl:in-package #:constrictor)

(declaim (inline copy-list))

(defun copy-list (list)
  (cond ((null list)
         '())
        ((atom list)
         (cl:error 'type-error
                   :expect-type 'list
                   :datum list))
        (t
         (loop with head = (cons (car list) nil)
               for tail = head then (cdr tail)
               for rest = (cdr list) then (cdr rest)
               until (atom rest)
               do (setf (cdr tail)
                        (cons (car rest) nil))
               finally (setf (cdr tail) rest)
                       (return head)))))
               
