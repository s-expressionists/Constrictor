(cl:in-package #:constrictor)

(defmacro pushnew
    (item place
     &environment environment
     &rest args)
  (multiple-value-bind (vars vals store-vars writer-form reader-form)
      (get-setf-expansion place environment)
    `(let (,@(mapcar #'list vars vals))
       (let ((,(car store-vars)
               (adjoin ,item ,reader-form ,@args)))
         ,writer-form))))
