(cl:in-package #:constrictor)

(declaim (inline butlast))

;;; The HyperSpec doesn't specify what happens if n is 0.  There is a
;;; note that says:
;;;
;;;     (butlast list n) ==  (ldiff list (last list n))
;;;
;;; but notes are not normative.  If you do believe this note, then
;;; (butlast '(1 2 3 . 4) 0) should return (1 2 3), i.e., it doesn't
;;; return the unmodified list.
;;;
;;; This implementation works according to the HyperSpec note when n
;;; is 0.

(defun butlast (list &optional (n 1))
  (check-type list cl:list)
  (check-type n (integer 0))
  (let ((tail list))
    (loop repeat n
          until (atom tail)
          do (pop tail))
    (loop with head = list
          for slow on tail
          until (atom tail)
          do (pop tail)
          collect (prog1 (car head) (pop head))
          until (atom tail)
          do (pop tail)
          collect (prog1 (car head) (pop head))
          do (when (eq slow tail)
               ;; we have a circular list
               (error 'must-be-proper-or-dotted-list
                      :datum list)))))

(declaim (notinline butlast))
