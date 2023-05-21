(cl:in-package #:constrictor)

(declaim (inline pairlis))

(defun pairlis (keys data &optional (alist '()))
  (loop with result = alist
        for rest-keys = keys then (rest rest-keys)
        for rest-data = data then (rest rest-data)
        until (or (atom rest-keys) (atom rest-data))
        do (push (cons (first rest-keys) (first rest-data))
                 result)
        finally (unless (listp rest-keys)
                  (error 'list-must-be-proper
                         :offending-list keys))
                (unless (listp rest-data)
                  (error 'list-must-be-proper
                         :offending-list data))
                (unless (and (null rest-keys) (null rest-data))
                  (error 'keys-and-data-must-have-the-same-length
                         :keys keys
                         :data data))
                (return result)))

(declaim (notinline pairlis))

(setf (documentation 'pailis 'function)
      (format nil
              "Syntax: pairlis keys data &optional alist~@
               ~@
               KEYS and DATA must be proper lists of equal length.~@
               ALIST can be any object, but is typically an association~@
               list.  This function adds entries to the front of ALIST.~@
               An entry is created as a CONS cell where the CAR is an~@
               element of KEYS and the CDR is the corresponding element~@
               of DATA.  If ALIST is a valid association list, then this~@
               function returns a valid association list with containing~@
               the additional entries.  The order of the additional entries~@
               should not be relied upon.  The default value for ALIST~@
               is the empty list.~@
               ~@
               If KEYS and DATA are both circular lists, then this function~@
               will not terminate.  Otherwise, if either KEYS or DATA is~@
               a dotted list or an atom, then an error of type TYPE-ERROR~@
               is signaled.  If  KEYS and DATA are both proper lists, but~@
               with different lengths, then an error is signaled."))
