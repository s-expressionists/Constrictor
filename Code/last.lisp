(cl:in-package #:constrictor)

(declaim (inline last))

(defun last (list &optional (n 1))
  (check-type list cl:list)
  (check-type n (integer 0))
  ;; We make an explicit test for the empty list, because the form (EQ
  ;; SLOW TAIL) would otherwise return true, and we would incorrectly
  ;; report the list as being circular.
  (if (null list)
      nil
      ;; The CONS cells starting at HEAD will be returned.  TAIL is
      ;; used to detect the end of the list.
      (let ((tail list))
        (loop repeat n
              until (atom tail)
              do (pop tail))
        (loop with head = list
              with slow = list
              until (atom tail)
              do (pop tail)
                 (pop head)
              until (atom tail)
              do (pop tail)
                 (pop head)
                 (pop slow)
              until (eq slow tail)
              finally (if (eq slow tail)
                          (error 'circular-list
                                 "Circular list ~s" list)
                          (return head))))))

(declaim (notinline last))
