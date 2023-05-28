(cl:in-package #:constrictor)

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
