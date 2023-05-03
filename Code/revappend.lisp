(cl:in-package #:constrictor)

(defun revappend (list tail)
  (let ((remaining list)
        (result tail))
    (loop until (atom remaining)
          do (push (pop remaining) result)
          finally (if (null remaining)
                      (return result)
                      (error 'list-must-be-proper
                             :datum remaining
                             :expected-type 'list
                             :offending-list list)))))
