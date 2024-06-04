(cl:in-package #:constrictor)

(declaim (inline list-length))

(defun list-length (x)
  (prog ((count 0)
         (step2 x)
         (step1 x))
   next
     (when (endp step2)
       (return count))
     (when (endp (cdr step2))
       (return (+ count 1)))
     (incf count 2)
     (setf step2 (cddr step2)
           step1 (cdr step1))
     (unless (and (eq step2 step1)
                  (plusp count))
       (go next))))

(declaim (notinline list-length))

(setf (documentation 'list-length 'function)
      (format nil
              "Syntax: list-length list~@
               ~@
               Return the length of LIST if LIST is a proper list.~@
               Return NIL if LIST is a circular list.~@
               Signal an error of type TYPE-ERROR if LIST is either~@
               not a list, or if it is a dotted list."))


