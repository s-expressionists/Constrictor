(cl:in-package #:constrictor)

(defparameter *must-be-proper-list-message*
  "A proper list was exptected, but the~@
   following was found instead:~@
   ~s")

;;; This macro can be used to traverse a list that must be a proper
;;; list, when each element of the list must be examined.  Client code
;;; must supply the name of a variable that will hold each element and
;;; a form that evaluates to the list to be traversed.  The body code
;;; is evaluated for every element of the list.  An error is signaled
;;; when a dotted list is given.
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

;;; This macro can be used to traverse a list that must be a proper
;;; list, when each tail of the list must be examined.  Client code
;;; must supply the name of a variable that will hold each tail and
;;; a form that evaluates to the list to be traversed.  The body code
;;; is evaluated for every element of the list.  An error is signaled
;;; when a dotted list is given.
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

(defmacro with-alist-elements ((element-variable alist) &body body)
  ;; We can use for ... on, because it uses atom to test the end
  ;; of the list
  (let ((rest-variable (gensym))
        (alist-variable (gensym)))
    `(loop with ,alist-variable = ,alist
           for ,rest-variable on ,alist-variable
           do (let ((,element-variable (car ,rest-variable)))
                (cond ((consp ,element-variable)
                       ,@body)
                      (t
                       (error 'must-be-alist
                              "" ,element-variable))))
           finally (unless (null ,rest-variable)
                     (error 'must-be-proper-list
                            *must-be-proper-list-message*
                            ,alist-variable)))))
