(cl:in-package #:constrictor)

(declaim (inline nth))

(defun nth (n list)
  (car (nthcdr n list)))

(declaim (notinline nth))

(setf (documentation 'nth 'function)
      (format nil
              "Syntax: nth n list~@
               ~@
               Return the Nth element of LIST, where N=0~@
               means the first element of LIST.  LIST may be~@
               a dotted list or a circular list, but if LIST~@
               has at most N CONS cells, then an error is~@
               signaled.  If N is not a non-negative integer,~@
               then an error is signaled."))
