(cl:in-package #:constrictor)

(defun copy-front (list object)
  (loop for tail on list
        until (eq object tail)
        collect (car tail)))

(defun ldiff (list object)
  (loop for tail on list
        when (eq object tail)
          return (copy-front list object)
        finally (return (copy-list list))))
