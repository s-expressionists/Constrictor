(cl:in-package #:constrictor)

(defun get-properties (property-list indicator-list)
  (loop for remaining on property-list by #'cddr
        do (when (atom (cdr remaining))
             (error 'type-error
                    :datum (cdr remaining)
                    :expected-type 'cons))
           (destructuring-bind (indicator value &rest rest)
               remaining
             (declare (ignore rest))
             (when (member indicator indicator-list :test #'eq)
               (return (values indicator value remaining))))
        finally (unless (null remaining)
                  (error 'type-error
                         :datum remaining
                         :expected-type 'cl:null))
                (return (values nil nil nil))))

(setf (documentation 'get-properties 'function)
      (format nil
              "Syntax: get-properties plist indicator-list~@
               ~@
               This function searches the property list PLIST for~@
               an indicator that is identical to one of the elements~@
               of INDICATOR-LIST.  If there is such an indicator,~@
               then this function returns three values which is the~@
               first such indicator in PLIST, the first associated~@
               value, and the remainder of PLIST starting at the~@
               CONS cell immediately following the first value~@
               ~@
               If there is no indicator in PLIST that is identical~@
               to one of the elements of INDICATOR-LIST, then this~@
               function return the three values NIL, NIL, and NIL.~@
               ~@
               If PLIST is a dotted list, or contains an odd number~@
               of elements, and no relevant indicator is found preceding~@
               the last element of PLIST, then an error of type TYPE-ERROR~@
               is signaled."))
