(cl:in-package #:constrictor)

(defun revappend (list tail)
  (let ((result tail))
    (with-proper-list-elements (element list)
      (push element result))
    result))
