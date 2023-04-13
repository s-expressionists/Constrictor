(cl:in-package #:constrictor)

;;; It is probably not worthwhile to define a compiler macro for
;;; MAPCAN.  One could perhaps avoid the allocation of a &REST list
;;; that way, but by definition MAPCAN allocates memory anyway, so it
;;; might not be worth the effort.  However, it is probably worthwhile
;;; to handle the cases of one and two lists specially.  This is
;;; because the general case allocates a new list in each iteration.

(declaim (inline mapcan))

(defun mapcan (function &rest lists)
  (cond ((null lists)
         (error 'at-least-one-list-must-be-supplied))
        ((null (rest lists))
         ;; We have exactly one list.  This is of couse a very
         ;; common special case.
         (let ((list (first lists)))
           (loop for rest on list
                 until (atom rest)
                 nconc (funcall function (first rest))
                 finally (unless (listp rest)
                           (error 'list-must-be-proper
                                  :datum list)))))
        ((null (rest (rest lists)))
         ;; We have exactly two lists.  Another common special case.
         (let ((list1 (first lists))
               (list2 (second lists)))
           (loop for rest1 on list1
                 for rest2 on list2
                 until (or (atom rest1) (atom rest2))
                 nconc (funcall function (first rest1) (first rest2))
                 finally (unless (listp rest1)
                           (error 'list-must-be-proper
                                  :datum list1))
                         (unless (listp rest2)
                           (error 'list-must-be-proper
                                  :datum list2)))))
        (t
         (let ((local-lists lists))
           (locally (declare (notinline mapcan))
             (loop until (some #'atom local-lists)
                   nconc (apply function (mapcan #'first local-lists))
                   do (setf local-lists (mapcan #'rest local-lists))
                   finally
                      (let ((position (position-if-not #'listp local-lists)))
                        (unless (null position)
                          (error 'list-must-be-proper
                                 :datum (elt lists position))))))))))

(declaim (notinline mapcan))
