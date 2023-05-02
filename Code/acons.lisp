(cl:in-package #:constrictor)

(defun acons (key datum alist)
  (cons (cons key datum) alist))
