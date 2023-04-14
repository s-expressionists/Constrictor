(cl:in-package #:constrictor)

(declaim (inline assoc-core))

(defun assoc-core (item alist key test test-not)
  (macrolet ((assoc-local (test)
               `(with-alist-elements (element alist)
                  (when ,test
                    (return-from assoc-core element)))))
    (if (eq key #'identity)
        (if (null test-not)
            (cond ((eq test #'eq)
                   (assoc-local
                    (eq item (car element))))
                  ((eq test #'eql)
                   (assoc-local
                    (eql item (car element))))
                  (t
                   (assoc-local
                    (funcall test item (car element)))))
            (cond ((eq test-not #'eq)
                   (assoc-local
                    (not (eq item (car element)))))
                  ((eq test-not #'eql)
                   (assoc-local
                    (not (eql item (car element)))))
                  (t
                   (assoc-local
                    (not (funcall test-not item (car element)))))))
        (if (null test-not)
            (cond ((eq test #'eq)
                   (assoc-local
                    (eq item (funcall key (car element)))))
                  ((eq test #'eql)
                   (assoc-local
                    (eql item (funcall key (car element)))))
                  (t
                   (assoc-local
                    (funcall test item (funcall key (car element))))))
            (cond ((eq test-not #'eq)
                   (assoc-local
                    (not (eq item (funcall key (car element))))))
                  ((eq test-not #'eql)
                   (assoc-local
                    (not (eql item (funcall key (car element))))))
                  (t
                   (assoc-local
                    (not (funcall test-not item (funcall key (car element)))))))))))

(declaim (notinline assoc-core))

(declaim (inline assoc))

(defun assoc
    (item alist
     &key
       key
       (test #'eql test-supplied-p)
       (test-not #'eql test-not-supplied-p))
  (macrolet ((special-function (test)
               `(with-alist-elements (element alist)
                  (when ,test
                    (return-from assoc element)))))
    (check-test-and-test-not test-supplied-p test-not-supplied-p)
    (if (or (null key) (eq key #'identity) (eq key 'identity))
        (if (not test-not-supplied-p)
            (cond ((or (eq test #'eq) (eq test 'eq))
                   (special-function
                    (eq item (car element))))
                  ((or (eq test #'eql) (eq test 'eql))
                   (special-function
                    (eql item (car element))))
                  (t
                   (special-function
                    (funcall test item (car element)))))
            (cond ((or (eq test-not #'eq) (eq test-not 'eq))
                   (special-function
                    (not (eq item (car element)))))
                  ((or (eq test-not #'eql) (eq test-not 'eql))
                   (special-function
                    (not (eql item (car element)))))
                  (t
                   (special-function
                    (not (funcall test-not item (car element)))))))
        (if (not test-not-supplied-p)
            (cond ((or (eq test #'eq) (eq test 'eq))
                   (special-function
                    (eq item (funcall key (car element)))))
                  ((or (eq test #'eql) (eq test 'eql))
                   (special-function
                    (eql item (funcall key (car element)))))
                  (t
                   (special-function
                    (funcall test item (funcall key (car element))))))
            (cond ((or (eq test-not #'eq) (eq test-not 'eq))
                   (special-function
                    (not (eq item (funcall key (car element))))))
                  ((or (eq test-not #'eql) (eq test-not 'eql))
                   (special-function
                    (not (eql item (funcall key (car element))))))
                  (t
                   (special-function
                    (not (funcall test-not item (funcall key (car element)))))))))))

(declaim (notinline assoc))
