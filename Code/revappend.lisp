(cl:in-package #:constrictor)

(declaim (inline revappend))

(defun revappend (list tail)
  (let ((result tail))
    (with-proper-list-elements (element list)
      (push element result))
    result))

(declaim (notinline revappend))

(setf (documentation 'revappend 'function)
      (format nil
              "Syntax: revappend list tail~@
               ~@
               Prepend the elements of LIST to TAIL in reverse~@
               order and return the result.  If LIST is not a list~@
               or if LIST is a dotted list, then an error of type~@
               TYPE-ERROR is signaled.  If LIST is a circular list~@
               then this function does not terminate."))
