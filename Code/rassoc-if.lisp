(cl:in-package #:constrictor)

(declaim (inline rassoc-if))

(defun rassoc-if (predicate alist &key key)
  (macrolet ((special-function (test)
               `(with-alist-elements (element alist)
                  (when ,test
                    (return element)))))
    (if (or (null key) (eq key #'identity) (eq key 'identity))
        (special-function
         (funcall predicate (cdr element)))
        (special-function
         (funcall predicate (funcall key (cdr element)))))))

(declaim (notinline rassoc-if))
