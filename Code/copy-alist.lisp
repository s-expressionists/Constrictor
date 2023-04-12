(cl:in-package #:constrictor)

(declaim (inline copy-alist))

(defun copy-alist (alist)
  (let ((reversed-result '()))
    (with-alist-elements (element alist)
      (push (if (consp element)
                (cons (car element) (cdr element))
                element)
            reversed-result))
    (nreverse reversed-result)))

(declaim (notinline copy-alist))

         
