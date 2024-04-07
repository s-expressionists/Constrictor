(cl:in-package #:constrictor)

(declaim (inline (setf nth)))

(defun (setf nth) (new-object n list)
  (setf (car (nthcdr n list)) new-object))

(declaim (notinline (setf nth)))

(setf (documentation '(setf nth) 'function)
      (format nil
              "Syntax: setf (nth n list) new-object~@
               ~@
               Set the Nth element of LIST to NEW-OBJECT, where~@
               N=0 means the first element of LIST.  LIST may be~@
               a dotted list or a circular list, but if LIST~@
               has at most N CONS cells, then an error is~@
               signaled.  If N is not a non-negative integer,~@
               then an error is signaled.~@
               ~@
               (SETF (NTH N LIST) NEW-OBJECT has the same semantics~@
               as (SETF (CAR (NTHCDR N LIST)) NEW-OBJECT)"))
