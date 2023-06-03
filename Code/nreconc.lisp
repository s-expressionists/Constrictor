(cl:in-package #:constrictor)

(declaim (inline nreconc))

(defun nreconc (list tail)
  (let ((remaining list)
        (result tail))
    (loop until (atom remaining)
          do (let ((temp (cdr remaining)))
               (rplacd remaining result)
               (setf result remaining)
               (setf remaining temp))
          finally (if (null remaining)
                      (return result)
                      (error 'type-error
                             :datum remaining
                             :expected-type 'list)))))

(declaim (notinline nreconc))

(setf (documentation 'nreconc 'function)
      (format nil
              "Syntax: nreconc list tail~@
               ~@
               Destructively modify LIST by prepending the~@
               CONS cells of LIST to TAIL in reverse order.~@
               If LIST is not a list, an error of type TYPE-ERROR~@
               is signaled.  If LIST is a dotted list, also signal~@
               an error of type TYPE-ERROR, but LIST will be~@
               destructively modified anyway.  If LIST is a circulat~@
               list, then this function will not terminate."))
