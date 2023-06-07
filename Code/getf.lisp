(cl:in-package #:constrictor)

(declaim (inline getf))

(defun getf (plist indicator &optional default)
  (loop for rest on plist by #'cddr
        until (atom rest)
        when (atom (rest rest))
          do (error 'must-be-property-list
                    :datum (rest rest)
                    :offending-list plist)
        when (eq indicator (first rest))
          return (second rest)
        finally (unless (null rest)
                  (error 'type-error
                         :datum rest
                         :expected-type 'cl:null))
                (return default)))

(declaim (notinline getf))

(setf (documentation 'getf 'function)
      (format nil
              "Syntax: getf plist indicator &optional default~@
                       (setf (getf place indicator &optional default) new-value~@
                ~@
                The function GETF finds the first indicator on PLIST that~@
                is identical to INDICATOR, and then returns the associated~@
                value of that indicator.  If there is no indicator on~@
                PLIST that is identical to INDICATOR, then DEFAULT is~@
                returned.~@
               ~@
               If PLIST is a dotted list, or contains an odd number~@
               of elements, and no relevant indicator is found preceding~@
               the last element of PLIST, then an error of type TYPE-ERROR~@
               is signaled.~@
               ~@
               SETF with GETF is used to associate NEW-VALUE with the first~@
               indicator identical to INDICATOR on the property list that~@
               is the value of PLACE.  If there is no indicator on the~@
               property list that is the value of PLACE, then the two~@
               objects INDICATOR and NEW-VALUE are added to the front of~@
               the property list that is the value of PLACE, and PLACE is~@
               updated accordingly.~@
               ~@
               As with the function GETF, if the value of PLACE is a~@
               dotted list, or contains an odd number of elements, and~@
               no relevant indicator is found preceding the last element~@
               of the list, then an error of type TYPE-ERROR is signaled.~@
               ~@
               In the case of SETF with GETF, DEFAULT is evaluated as~@
               usual, but the value is not used."))
