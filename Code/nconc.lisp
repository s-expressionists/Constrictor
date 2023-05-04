(cl:in-package #:constrictor)

(declaim (inline nconc))

(defun nconc (&rest lists)
  (if (null lists)
      nil
      (loop for (l1 l2) on lists
            until (null l2)
            do (rplacd (last l1) l2)
            finally (return (first lists)))))

(declaim (notinline nconc))
