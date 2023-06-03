(cl:in-package #:constrictor)

(defmacro push (item place &environment environment)
  (multiple-value-bind (vars vals store-vars writer-form reader-form)
      (get-setf-expansion place environment)
    (let ((item-var (gensym)))
      `(let* ((,item-var ,item)
              ;; Avoid using MAPCAR and LIST here. 
              ,@(loop for var in vars
                      for val in vals
                      collect `(,var ,val))
              (,(car store-vars) (cons ,item-var ,reader-form)))
         ,writer-form))))

(setf (documentation 'push 'function)
      (format nil "Syntax: push item place~@
                   ~@
                   Modify PLACE so that it contains a CONS cell with~@
                   ITEM in the CAR slot and the old value of PLACE in~@
                   the CDR slot.  Return the new contents of PLACE.~@
                   ~@
                   (PUSH ITEM PLACE) has the same effect and the same~@
                   return value as (SETF PLACE (CONS ITEM PLACE)) except~@
                   that PUSH evaluates sub-forms of PLACE only once."))
