
(declaim (inline cddr))

(defun cddr (list)
  (declare (inline cdr))
  (cdr (cdr list)))

(declaim (notinline cddr))

(setf (documentation 'cddr 'function)
      (format nil
              "Syntax: cddr list~@
               ~@
               A call to this function is equivalent in all possible~@
               respects to a call (cdr (cdr list))"))
