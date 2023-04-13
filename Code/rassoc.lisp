(cl:in-package #:constrictor)

(declaim (inline rassoc))

(defun rassoc
    (item alist
     &key
       key
       (test #'eql test-supplied-p)
       (test-not #'eql test-not-supplied-p))
  (macrolet ((special-function (test)
               `(with-alist-elements (element alist)
                  (when ,test
                    (return element)))))
    (check-test-and-test-not test-supplied-p test-not-supplied-p)
    (if (or (null key) (eq key #'identity) (eq key 'identity))
        (if (not test-not-supplied-p)
            (cond ((or (eq test #'eq) (eq test 'eq))
                   (special-function
                    (eq item (cdr element))))
                  ((or (eq test #'eql) (eq test 'eql))
                   (special-function
                    (eql item (cdr element))))
                  (t
                   (special-function
                    (funcall test item (cdr element)))))
            (cond ((or (eq test-not #'eq) (eq test-not 'eq))
                   (special-function
                    (not (eq item (cdr element)))))
                  ((or (eq test-not #'eql) (eq test-not 'eql))
                   (special-function
                    (not (eql item (cdr element)))))
                  (t
                   (special-function
                    (not (funcall test-not item (cdr element)))))))
        (if (not test-not-supplied-p)
            (cond ((or (eq test #'eq) (eq test 'eq))
                   (special-function
                    (eq item (funcall key (cdr element)))))
                  ((or (eq test #'eql) (eq test 'eql))
                   (special-function
                    (eql item (funcall key (cdr element)))))
                  (t
                   (special-function
                    (funcall test item (funcall key (cdr element))))))
            (cond ((or (eq test-not #'eq) (eq test-not 'eq))
                   (special-function
                    (not (eq item (funcall key (cdr element))))))
                  ((or (eq test-not #'eql) (eq test-not 'eql))
                   (special-function
                    (not (eql item (funcall key (cdr element))))))
                  (t
                   (special-function
                    (not (funcall test-not item (funcall key (cdr element)))))))))))

(declaim (notinline rassoc))
