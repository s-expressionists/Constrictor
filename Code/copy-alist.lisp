(cl:in-package #:constrictor)

(declaim (inline copy-alist))

(defun copy-alist (alist)
  (let ((reversed-result '()))
    (with-alist-elements (element alist)
      (push (if (consp element)
                (cons (car element) (cdr element))
                ;; The element is an atom only if the restart USE was
                ;; chosen, so we will not accidentally copy atoms.
                ;; Only when the client has given us authorisation to
                ;; do so do we copy.
                element)
            reversed-result))
    (nreverse reversed-result)))

(declaim (notinline copy-alist))

         
