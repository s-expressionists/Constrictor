(cl:in-package #:constrictor)

(defun append (&rest lists)
  (let ((remaining lists))
    (loop until (or (null remaining)
                    (consp (car remaining))
                    (not (listp (car remaining))))
          do (pop remaining))
    (cond ((null remaining)
           nil)
          ((not (listp (car remaining)))
           (error 'list-must-be-proper
                  :offending-list (car remaining)))
          (t
           (let* ((list-to-copy (car remaining))
                  (result (cons (car list-to-copy) nil))
                  (tail result))
             (pop list-to-copy)
             (pop remaining)
             (tagbody
              copy-element
                (cond ((consp list-to-copy)
                       (rplacd tail (cons (car list-to-copy) nil))
                       (pop tail)
                       (pop list-to-copy))
                      ((null list-to-copy)
                       (if (null (cdr remaining))
                           (progn (rplacd tail (car remaining))
                                  (go done))
                           (progn (setf list-to-copy (pop remaining))
                                  (go copy-element))))
                      (t
                       (error 'list-must-be-proper
                              :offending-list list-to-copy)))
              done)
             result)))))
