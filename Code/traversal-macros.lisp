(cl:in-package #:constrictor)

(defparameter *must-be-proper-list-message*
  "A proper list was exptected, but the~@
   following was found instead:~@")

(defmacro with-proper-list-elements ((element-variable list) &body body)
  (let ((list-variable (gensym))
        (rest-variable (gensym)))
    `(loop with ,list-variable = ,list
           for ,rest-variable = ,list-variable then (rest ,rest-variable)
           for ,element-variable
             = (if (atom ,rest-variable) nil (first ,rest-variable))
           until (atom ,rest-variable)
           do ,@body
           finally (unless (null ,rest-variable)
                     (error 'must-be-proper-list
                            *must-be-proper-list-message*
                            ,list-variable)))))

(defmacro with-proper-list-rests ((rest-variable list) &body body)
  (let ((list-variable (gensym)))
    `(loop with ,list-variable = ,list
           for ,rest-variable = ,list-variable then (rest ,rest-variable)
           until (atom ,rest-variable)
           do ,@body
           finally (unless (null ,rest-variable)
                     (error 'must-be-proper-list
                            *must-be-proper-list-message*
                            ,list-variable)))))
