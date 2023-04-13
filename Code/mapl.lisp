(cl:in-package #:constrictor)

(declaim (inline mapl1))

(defun mapl1 (function list)
  (loop for rest on list
        until (atom rest)
        do (funcall function rest)
        finally (unless (listp rest)
                  (error 'list-must-be-proper
                         :datum list)))
  list)

(declaim (notinline mapl1))

(declaim (inline mapl2))

(defun mapl2 (function list1 list2)
  (loop for rest1 on list1
        for rest2 on list2
        until (or (atom rest1) (atom rest2))
        do (funcall function rest1 rest2)
        finally (unless (listp rest1)
                  (error 'list-must-be-proper
                         :datum list1))
                (unless (listp rest2)
                  (error 'list-must-be-proper
                         :datum list2)))
  list1)

(declaim (notinline mapl2))

(declaim (inline mapl))

(defun mapl (function &rest lists)
  (cond ((null lists)
         (error 'at-least-one-list-must-be-supplied))
        ((null (rest lists))
         (mapl1 function (first lists)))
        ((null (rest (rest lists)))
         (mapl2 function (first lists) (second lists)))
        (t
         (let ((local-lists lists))
           (loop until (some #'atom local-lists)
                 collect (apply function local-lists)
                 do (setf local-lists (mapl #'rest local-lists))
                 finally
                    (let ((position (position-if-not #'listp local-lists)))
                      (unless (null position)
                        (error 'list-must-be-proper
                               :datum (elt lists position))))))
         (first lists))))

(declaim (notinline mapl))

(define-compiler-macro mapl (&whole form function &rest lists)
  (case (length lists)
    (1 `(mapl1 ,function ,(first lists)))
    (2 `(mapl2 ,function ,(first lists) ,(second lists)))
    (otherwise form)))
