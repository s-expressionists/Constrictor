(cl:in-package #:constrictor)

(declaim (inline copy-list))

(defun copy-list (list)
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
                       (return head)))))

(declaim (notinline copy-list))

(setf (documentation 'copy-list 'function)
      (format nil
              "Copy an association list.~@
               ~@
               The argument LIST much be an association list.~@
               If LIST is an atom other than NIL, an error of~@
               (a subtype of) type TYPE-ERROR is signaled.~@
               ~@
               If an element of LIST is not a CONS, then an error~@
               of (a subtype of) type TYPE-ERROR is signaled.~@
               ~@
               Several restarts are then available:~@
               REPLACE -- to supply a CONS cell~@
               IGNORE -- to ignore the element~@
               USE -- to use the element anyway."))
