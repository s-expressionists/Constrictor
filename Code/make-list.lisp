(cl:in-package #:constrictor)

(declaim (inline make-list))

(defun make-list (length &key (initial-element nil))
  (check-type length (integer 0))
  (loop repeat length
        collect initial-element))

(setf (documentation 'make-list 'function)
      (format nil
              "Syntax: make-list length &optional iniital-element~@
               ~@
               Create and return a proper list with LENGTH CONS~@
               cells in it.  Each element of the list is the~@
               object INITIAL-ELEMENT.  If INITIAL-ELEMENT is not~@
               given, it defaults to NIL."))
