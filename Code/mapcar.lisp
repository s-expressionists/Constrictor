(cl:in-package #:constrictor)

(declaim (inline mapcar))

(defun mapcar (function &rest lists)
  (let ((local-lists lists))
    (cond ((null local-lists)
           (error 'at-least-one-list-must-be-supplied))
          ((null (rest local-lists))
           (let ((list (first local-lists)))
             (loop for rest on list
                   until (atom rest)
                   collect (funcall function (first rest))
                   finally (unless (listp rest)
                             (error 'list-must-be-proper
                                    :datum list)))))
          (t
           (locally (declare (notinline mapcar))
             (loop until (some #'atom local-lists)
                   collect (apply function (mapcar #'first local-lists))
                   do (setf local-lists (mapcar #'rest local-lists))
                   finally
                      (let ((position (position-if-not #'listp local-lists)))
                        (unless (null position)
                          (error 'list-must-be-proper
                                 :datum (elt lists position))))))))))

(declaim (notinline mapcar))

           
           
