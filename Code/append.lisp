(cl:in-package #:constrictor)

(declaim (inline append))

(defun append (&rest lists)
  (if (null lists)
      '()
      (let* ((reverse (reverse lists))
             (result (first reverse))
             (remaining (cdr reverse)))
        (loop for object in remaining
              do (cond ((null object)
                        nil)
                       ((atom object)
                        (error 'type-error
                               :datum object
                               :expected-type 'cl:list))
                       (t
                        ;; At least we have a non-empty list.  But it
                        ;; could be dotted. It could also be circular,
                        ;; but we don't check for that.
                        (let* ((copy (copy-list object))
                               (last (last copy)))
                          (if (null (cdr last))
                              (progn (rplacd last result)
                                     (setq result copy))
                              (error 'list-must-be-proper
                                     :offending-list object))))))
        result)))

(declaim (notinline append))

(define-compiler-macro append (&whole form &rest list-forms)
  (case (length list-forms)
    (0
     '())
    (1
     (first list-forms))
    (2 
     (let ((first-form-variable (gensym))
           (second-form-variable (gensym))
           (copy-variable (gensym))
           (last-variable (gensym)))
       `(let ((,first-form-variable ,(first list-forms))
              (,second-form-variable ,(second list-forms)))
          (cond ((null ,first-form-variable)
                 ,second-form-variable)
                ((atom ,first-form-variable)
                 (error 'type-error
                        :datum ,first-form-variable
                        :expected-type 'cl:list))
                (t
                 (let* ((,copy-variable (copy-list ,first-form-variable))
                        (,last-variable (last ,copy-variable)))
                   (if (null (cdr ,last-variable))
                       (progn (rplacd ,last-variable ,second-form-variable)
                              ,copy-variable)
                       (error 'list-must-be-proper
                              :offending-list ,first-form-variable))))))))
    (otherwise form)))
