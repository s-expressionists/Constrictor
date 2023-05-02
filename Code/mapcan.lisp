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
                                  :offending-list list
                                  :datum rest)))))
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
                                  :offending-lits list1
                                  :datum rest1))
                         (unless (listp rest2)
                           (error 'list-must-be-proper
                                  :offending-list list2
                                  :datum rest2)))))
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
                                 :offending-list (elt lists position)
                                 :datum (elt local-lists position))))))))))

(declaim (notinline mapcan))

(setf (documentation 'mapcan 'function)
      (format nil
              "mapcan function &rest lists~@
               Apply FUNCTION to the FIRST of each LIST~@
               then to the SECOND of each LIST, and so on.~@
               Return a list that is constructed by applying~@
               NCONC to the results of the function application.~@
               Iteration stops when the shortest LIST is exhausted.~@
               Each LIST must be a proper list.  If one of the ~@
               shortest lists is a dotted list, then an error~@
               of type TYPE-ERROR is signaled.  If every list in~@
               LISTS is a circular list, then this function will~@
               not terminate.  If LISTS is empty then an error~@
               is signaled."))
