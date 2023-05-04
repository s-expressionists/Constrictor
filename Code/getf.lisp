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
        finally (return default)))

(declaim (notinline getf))
