(cl:in-package #:constrictor)

(declaim (inline copy-alist))

(defun copy-alist (alist)
  (loop for rest on alist
        for element = (car rest)
        if (atom element)
          do (error 'must-be-alist "Must be alist ~s" alist)
        else
          collect (cons (car element) (cdr element))
        finally (unless (listp rest)
                  (error 'must-be-alist "Must be alist ~s" alist))))

(declaim (notinline copy-alist))

         
