(cl:in-package #:constrictor)

(defun get-properties (property-list indicator-list)
  (loop for remaining on property-list by #'cddr
        for indicator = (first remaining)
        for value = (second remaining)
        when (member indicator indicator-list :test #'eq)
          return (values indicator value remaining)
        finally (return nil)))

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
               function return the three values NIL, NIL, and NIL."))
