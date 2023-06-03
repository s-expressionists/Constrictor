(cl:in-package #:constrictor)

;;; It is probably not worthwhile to define a compiler macro for
;;; MAPCON.  One could perhaps avoid the allocation of a &REST list
;;; that way, but by definition MAPCON allocates memory anyway, so it
;;; might not be worth the effort.  However, it is probably worthwhile
;;; to handle the cases of one and two lists specially.  This is
;;; because the general case allocates a new list in each iteration.

(declaim (inline mapcon))

(defun mapcon (function &rest lists)
  (apply #'nconc (apply #'maplist function lists)))

(declaim (notinline mapcon))

(setf (documentation 'maplist 'function)
      (format nil
              "Syntax: maplist function &rest lists~@
               ~@
               Apply FUNCTION to first to each list in LISTS~@
               then to the REST of each list in LISTS, and so on.~@
               Return a list that is constructed by applying~@
               NCONC to the results of the function application.~@
               Iteration stops when the shortest LIST is exhausted.~@
               Each LIST must be a proper list.  If one of the ~@
               shortest lists is a dotted list, then an error~@
               of type TYPE-ERROR is signaled.  If every list in~@
               LISTS is a circular list, then this function will~@
               not terminate.  If LISTS is empty then an error~@
               is signaled."))
