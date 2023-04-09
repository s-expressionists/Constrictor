(cl:in-package #:constrictor)

(declaim (inline list))

(defun list (&rest objects)
  (copy-list objects))

(declaim (notinline list))

(declaim (inline list*))

(defun list* (object &rest objects)
  (cons object (reverse objects)))
  ;; (if (null objects)
  ;;     object
  ;;     (loop with head = (cons object nil)
  ;;           for tail = head then (cdr tail)
  ;;           for rest = objects then first
  ;;           for first = (cdr objects) then (cdr first)
  ;;           until (null first)
  ;;           do (setf (cdr tail)
  ;;                    (cons (car rest) nil))
  ;;           finally (setf (cdr tail) (car rest))
  ;;                   (return head))))


(declaim (notinline list*))

(define-compiler-macro list*
    (&whole form object-form &rest object-forms)
  (cond ((null object-forms)
         object-form)
        ((> (length object-forms) 10)
         form)
        (t
         (labels ((nest (forms)
                    (if (null (cdr forms))
                        (car forms)
                        `(cons ,(car forms)
                               ,(nest (cdr forms))))))
           `(cons ,object-form
                  ,(nest object-forms))))))
    
  
