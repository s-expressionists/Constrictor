(cl:in-package #:constrictor)

(declaim (inline nset-exclusive-or-core))

(defun nset-exclusive-or-core
    (list-1 list-2 key key-supplied-p test test-supplied-p test-not test-not-supplied-p)
  (assert-proper-list list-1)
  (assert-proper-list list-2)
  (cond ((null list-1)
         list-2)
        ((null list-2)
         list-1)
        (t
         (with-key (key key-supplied-p)
           (with-test (test test-supplied-p test-not test-not-supplied-p)
             (loop with remaining-1 = list-1
                   until (null (cdr remaining-1))
                   do (loop for element-2 in list-2
                            when (apply-test (apply-key (car remaining-1))
                                             (apply-key element-2))
                              do (setf (cdr remaining-1)
                                       (cddr remaining-1))
                                 (return)
                              finally (pop remaining-1)))
             (loop with remaining-2 = list-2
                   until (null (cdr remaining-2))
                   do (loop for element-1 in list-1
                            when (apply-test (apply-key element-1)
                                             (apply-key (car remaining-2)))
                              do (setf (cdr remaining-2)
                                       (cddr remaining-2))
                                 (return)
                            finally (pop remaining-2)))
             (if (apply-test (apply-key (car list-1))
                             (apply-key (car list-2)))
                 (nconc (cdr list-1) (cdr list-2))
                 (nconc list-1 list-2)))))))

(declaim (notinline nset-exclusive-or-core))

(declaim (inline nset-exclusive-or))

(defun nset-exclusive-or
    (list-1 list-2
     &key
       (key #'identity key-supplied-p)
       (test #'eql test-supplied-p)
       (test-not #'eql test-not-supplied-p))
  (nset-exclusive-or-core list-1 list-2
                          key key-supplied-p
                          test test-supplied-p
                          test-not test-not-supplied-p))
