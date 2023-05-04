(cl:in-package #:constrictor)

(define-setf-expander getf
    (place indicator &optional default &environment env)
  (let ((indicator-var (gensym))
        (default-var (gensym))
        (value-var (gensym)))
    (multiple-value-bind (vars vals store-vars writer-form reader-form)
        (get-setf-expansion place env)
      (values (append vars (list indicator-var default-var))
              (append vals (list indicator default))
              (list value-var)
              `(let ((,default-var ,default-var))
                 (declare (ignore ,default-var))
                 (loop for rest on ,reader-form by #'cddr
                       when (eq (car rest) ,indicator-var)
                         do (setf (cadr rest) ,value-var)
                            (return nil)
                       finally (let ((,(car store-vars)
                                      (list* ,indicator-var ,value-var ,reader-form)))
                                 ,writer-form))
                 ,value-var)
              `(getf ,reader-form ,indicator-var ,default)))))