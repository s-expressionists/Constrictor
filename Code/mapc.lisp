(cl:in-package #:constrictor)

(define-compiler-macro mapc (&whole form function &rest lists)
  (case (length lists)
    (1 `(mapc1 ,function ,(first lists)))
    (2 `(mapc2 ,function ,(first lists) ,(second lists)))
    (otherwise form)))

(declaim (inline mapc1))

(defun mapc1 (function list)
  (loop for rest on list
        until (atom rest)
        do (funcall function (first rest))
        finally (unless (listp rest)
                  (error 'list-must-be-proper
                         :datum list)))
  list)

(declaim (notinline mapc1))

(declaim (inline mapc2))

(defun mapc2 (function list1 list2)
  (loop for rest1 on list1
        for rest2 on list2
        until (or (atom rest1) (atom rest2))
        do (funcall function (first rest1) (first rest2))
        finally (unless (listp rest1)
                  (error 'list-must-be-proper
                         :datum list1))
                (unless (listp rest2)
                  (error 'list-must-be-proper
                         :datum list2)))
  list1)

(declaim (notinline mapc2))

(declaim (inline mapc))

(defun mapc (function &rest lists)
  (cond ((null lists)
         (error 'at-least-one-list-must-be-supplied))
        ((null (rest lists))
         (mapc1 function (first lists)))
        ((null (rest (rest lists)))
         (mapc2 function (first lists) (second lists)))
        (t
         (let ((local-lists lists))
           (loop until (some #'atom local-lists)
                 collect (apply function (mapc #'first local-lists))
                 do (setf local-lists (mapc #'rest local-lists))
                 finally
                    (let ((position (position-if-not #'listp local-lists)))
                      (unless (null position)
                        (error 'list-must-be-proper
                               :datum (elt lists position))))))
         (first lists))))

(declaim (notinline mapc))
