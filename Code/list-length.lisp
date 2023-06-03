(cl:in-package #:constrictor)

(declaim (inline list-length))

(defun list-length (list)
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
                 finally (cond ((null fast)
                                (return count))
                               ((eq fast slow)
                                nil)
                               (t
                                (error 'list-must-be-proper-or-circular
                                       :datum list))))))))

(declaim (notinline list-length))

(setf (documentation 'list-length 'function)
      (format nil
              "Syntax: list-length list~@
               ~@
               Return the length of LIST if LIST is a proper list.~@
               Return NIL if LIST is a circular list.~@
               Signal an error of type TYPE-ERROR if LIST is either~@
               not a list, or if it is a dotted list."))


