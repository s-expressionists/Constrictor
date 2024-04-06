(cl:in-package #:constrictor)

(declaim (inline nthcdr))

(defun nthcdr (n list)
  (unless (listp list)
    (error 'list-expected :datum list))
  (loop for result = list then (cdr result)
        repeat n
        until (null result) finally (return result)))

(declaim (notinline nthcdr))

(setf (documentation 'nthcdr 'function)
      (format nil
              "Syntax: nthcdr n list~@
               ~@
               This function returns the tail of LIST resulting from~@
               applying the function CDR, N times to LIST.~@
               ~@
               N is a non-negative integer.  If N is not a non-negative~@
               integer, then an error of type TYPE-ERROR is signaled.~@
               LIST is a list that can be proper, dotted, or circular.~@
               If LIST is not a list, an error of type TYPE-ERROR is~@
               signaled.
               ~@
               If LIST has fewer than N CONS cells, then an error is~@
               signaled."))
