(cl:in-package #:constrictor)

(defun acons (key datum alist)
  (cons (cons key datum) alist))

(setf (documentation 'acons 'function)
      (format nil
              "Syntax: acons key datum alist~@
               ~@
               This function adds a new entry to the front of~@
               the association list ALIST.  The entry is itself~@
               a CONS cell cell where KEY is the CAR and DATUM~@
               is the CDR.~@
               ~@
               No checks are made as to the structure of ALIST~@
               so it can be any object.  Therefore, this function~@
               is equivalent to (CONS (CONS KEY DATUM) ALIST)."))
