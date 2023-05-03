(cl:in-package #:constrictor)

(declaim (inline nreconc))

(defun nreconc (list tail)
  (let ((remaining list)
        (result tail))
    (loop until (atom remaining)
          do (let ((temp (cdr remaining)))
               (rplacd remaining result)
               (setf result remaining)
               (setf remaining temp))
          finally (if (null remaining)
                      (return result)
                      (error 'type-error
                             :datum remaining
                             :expected-type 'list)))))

(declaim (notinline nreconc))
