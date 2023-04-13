(cl:in-package #:constrictor)

(declaim (inline member-if-not))

(defun member-if-not (predicate list &key key)
  (macrolet ((special-function (test)
               `(with-proper-list-rests (rest list)
                  (unless ,test
                    (return rest)))))
    (if (or (null key) (eq key #'identity) (eq key 'identity))
        (special-function
         (funcall predicate (car rest)))
        (special-function
         (funcall predicate (funcall key (car rest)))))))

(declaim (notinline member-if-not))
