(cl:in-package #:constrictor)

(defun ldiff (list object)
  (check-type list list)
  (loop for tail on list
        until (eq object tail)
        when (and (atom (cdr tail))
                  (not (eq object (cdr tail))))
          nconc (cons (car tail)
                      (cdr tail))
        else
          collect (car tail)))

(setf (documentation 'ldiff 'function)
      (format nil
              "Syntax: ldiff list object~@
               ~@
               If OBJECT is EQ to some top-level CONS cell of LIST,~@
               then this function returns a list consisting of copies~@
               of the CONS cells that precede OBJECT in LIST, with OBJECT~@
               replaced by NIL.  If OBJECT is not EQ to some top-level~@
               CONS cell of LIST, and LIST is not a circular list, then~@
               a copy of LIST is returned.~@
               ~@
               LIST must be a list that might be a dotted list.~@
               If LIST is not a list, then an error of type TYPE-ERROR~@
               is signaled.  If LIST is a circular list, and no top-level~@
               CONS cell is EQ to OBJECt, then this function does not~@
               terminate."))
