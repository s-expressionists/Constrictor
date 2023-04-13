(cl:in-package #:constrictor)

(declaim (inline assoc-if))

(defun assoc-if (predicate alist &key key)
  (macrolet ((special-function (test)
               `(with-alist-elements (element alist)
                  (when ,test
                    (return-from assoc-if element)))))
    (if (or (null key) (eq key #'identity) (eq key 'identity))
        (special-function
         (funcall predicate (car element)))
        (special-function
         (funcall predicate (funcall key (car element)))))))

(declaim (notinline assoc-if))
