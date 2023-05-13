(cl:in-package #:constrictor)

(defun proper-list-p (list)
  (cond ((null list)
         0)
        ((atom list)
         (error 'list-must-be-proper-or-circular
                :datum list))
        (t
         (let ((fast list)
               (slow list)
               (count 0))
           (loop do (pop fast)
                    (incf count)
                 until (atom fast)
                 do (pop fast)
                    (incf count)
                    (pop slow)
                 until (or (atom fast) (eq fast slow))
                 finally (return (null fast)))))))

(defun assert-proper-list (list)
  (unless (proper-list-p list)
    (error 'list-must-be-proper
           :offending-list list)))
