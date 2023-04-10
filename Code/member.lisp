(cl:in-package #:constrictor)

(defun member
    (item list
     &key
       key
       (test #'eql test-supplied-p)
       (test-not #'eql test-not-supplied-p))
  (macrolet ((special-function (test)
               `(with-proper-list-rests (rest list)
                  (when ,test
                    (return rest)))))
    (when (and test-supplied-p test-not-supplied-p)
      (error 'both-test-and-test-not-supplied
             "Both :TEST and :TEST-NOT supplied."))
    (if (or (null key) (eq key #'identity) (eq key 'identity))
        (if (not test-not-supplied-p)
            (cond ((or (eq test #'eq) (eq test 'eq))
                   (special-function
                    (eq item (car rest))))
                  ((or (eq test #'eql) (eq test 'eql))
                   (special-function
                    (eql item (car rest))))
                  (t
                   (special-function
                    (funcall test item (car rest)))))
            (cond ((or (eq test-not #'eq) (eq test-not 'eq))
                   (special-function
                    (not (eq item (car rest)))))
                  ((or (eq test-not #'eql) (eq test-not 'eql))
                   (special-function
                    (not (eql item (car rest)))))
                  (t
                   (special-function
                    (not (funcall test-not item (car rest)))))))
        (if (not test-not-supplied-p)
            (cond ((or (eq test #'eq) (eq test 'eq))
                   (special-function
                    (eq item (funcall key (car rest)))))
                  ((or (eq test #'eql) (eq test 'eql))
                   (special-function
                    (eql item (funcall key (car rest)))))
                  (t
                   (special-function
                    (funcall test item (funcall key (car rest))))))
            (cond ((or (eq test-not #'eq) (eq test-not 'eq))
                   (special-function
                    (not (eq item (funcall key (car rest))))))
                  ((or (eq test-not #'eql) (eq test-not 'eql))
                   (special-function
                    (not (eql item (funcall key (car rest))))))
                  (t
                   (special-function
                    (not (funcall test-not item (funcall key (car rest)))))))))))

(defun member-if (predicate list &key key)
  (macrolet ((special-function (test)
               `(with-proper-list-rests (rest list)
                  (when ,test
                    (return rest)))))
    (if (or (null key) (eq key #'identity) (eq key 'identity))
        (special-function
         (funcall predicate (car rest)))
        (special-function
         (funcall predicate (funcall key (car rest)))))))

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
