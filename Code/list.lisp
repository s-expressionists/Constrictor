(cl:in-package #:constrictor)

(declaim (inline list))

(defun list (&rest objects)
  (copy-list objects))

(declaim (notinline list))

(declaim (inline list*))

(defun list* (object &rest objects)
  (if (null objects)
      object
      (loop with head = (cons object nil)
            for tail = head then (cdr tail)
            for rest = objects then first
            for first = (cdr objects) then (cdr first)
            until (null first)
            do (setf (cdr tail)
                     (cons (car rest) nil))
            finally (setf (cdr tail) (car rest))
                    (return head))))

(declaim (notinline list*))
