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

(setf (documentation 'copy-alist 'function)
      (format nil
              "Syntax: copy-alist alist~@
               Copy an association list.~@
               ~@
               The argument LIST much be an association list.~@
               If LIST is an atom other than NIL, an error of~@
               (a subtype of) type TYPE-ERROR is signaled.~@
               ~@
               If an element of LIST is not a CONS, then an error~@
               of (a subtype of) type TYPE-ERROR is signaled.~@
               ~@
               Several restarts are then available:~@
               REPLACE -- to supply a CONS cell~@
               IGNORE -- to ignore the element~@
               USE -- to use the element anyway."))
