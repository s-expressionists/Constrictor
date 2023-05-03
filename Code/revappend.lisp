(cl:in-package #:constrictor)

(declaim (inline revappend))

(defun revappend (list tail)
  (let ((result tail))
    (with-proper-list-elements (element list)
      (push element result))
    result))

(declaim (notinline revappend))
