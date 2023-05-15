(cl:in-package #:constrictor)

(defun null (object)
  (eq object nil))

(setf (documentation 'null 'function)
      (format nil
              "Syntax: null object~@
               ~@
               Return true if an only if OBJECT is the object NIL.~@
               Rerutn NIL otherwise."))
