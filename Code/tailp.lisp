(cl:in-package #:constrictor)

(defun tailp (object list)
  (loop for tail on list
        when (eql object tail)
          return t
        finally (return (eql object tail))))

(setf (documentation 'tailp 'function)
      (format nil
              "Syntax: tailp object list~@
               ~@
               If OBJECT is EQ to some top-level CONS cell of LIST,~@
               then this function returns T.  If OBJECT is not EQ to~@
               some top-level CONS cell of LIST, and LIST is not a~@
               circular list, then this function returns NIL.~@
               ~@
               LIST must be a list that might be a dotted list.~@
               If LIST is not a list, then an error of type TYPE-ERROR~@
               is signaled.  If LIST is a circular list, and no top-level~@
               CONS cell is EQ to OBJECt, then this function does not~@
               terminate."))

