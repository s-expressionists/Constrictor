(cl:in-package #:constrictor)

(defun get-properties (property-list indicator-list)
  (loop for remaining on property-list by #'cddr
        for indicator = (first remaining)
        for value = (second remaining)
        when (member indicator indicator-list :test #'eq)
          return (values indicator value remaining)
        finally (return nil)))
