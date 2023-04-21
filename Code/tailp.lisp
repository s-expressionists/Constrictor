(cl:in-package #:constrictor)

(defun tailp (object list)
  (loop for tail on list
        when (eq object tail)
          return t
        finally (return (eq object tail))))
