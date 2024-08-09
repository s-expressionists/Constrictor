(cl:in-package #:constrictor)

(declaim (inline nset-exclusive-or-core))

;;; This is seriously broken. Until it is fixed we'll just use
;;; set-exclusive-or-core.
(defun nset-exclusive-or-core
    (list-1 list-2 key key-supplied-p test test-supplied-p test-not test-not-supplied-p)
  (check-type list-1 proper-list)
  (check-type list-2 proper-list)
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
  (set-exclusive-or-core list-1 list-2
                         key key-supplied-p
                         test test-supplied-p
                         test-not test-not-supplied-p))

(define-compiler-macro nset-exclusive-or (&whole form &rest arguments)
  (let ((lambda-list
          '((list-1 list-2) ; required
            ()           ; optional
            nil          ; rest
            ((:key key key-supplied-p)
             (:test test test-supplied-p)
             (:test-not test-not test-not-supplied-p))
            nil)))
    (unless (check-call-site arguments lambda-list)
      (return-from nset-exclusive-or form))
    (compute-compiler-macro-body
     arguments
     (butlast lambda-list)
     '(set-exclusive-or-core
       list-1 list-2
       key key-supplied-p
       test test-supplied-p
       test-not test-not-supplied-p))))

(setf (documentation 'nset-exclusive-or 'function)
      (format nil
              "Syntax: nset-exclusive-or list-1 list-2 &key key test test-not~@
               ~%~a~%~%~a~%~%~a~%~%~a~%~@
               Either TEST or TEST-NOT is applied to the result of~@
               applying KEY to an element of LIST-1 and and the result~@
               of applying KEY to an element of LIST-2 in that order.~@
               If for some elements E1 of LIST-1 and E2 of LIST-2, the~@
               test is satisfied, neither E1 nor E2 is included in the~@
               return value of this function.  All other elements of~@
               LIST-1 and LIST-2 are included in the return value of~@
               this function.~@
               ~@
               This function may modify either LIST-1 or LIST-1 or both~@
               in that elements may be removed or added.  The original~@
               values of the lists should not be used after a call to this~@
               function.
               ~@
               The order of the elements in teh return value of this~@
               function should not be relied upon.  If there are duplicate~@
               elements E1 and E2 in LIST-1 for which there is no element~@
               in LIST-2 that satisfies the test, then both E1 and E2 might~@
               be included in the result.  If there are duplicate elements~@
               E1 and E2 of LIST-2 for which there is no element in LIST-1~@
               that satisfies the test, then both E1 and #2 might be~@
               included in the result."
              *list-1-and-list-2-must-be-proper*
              *key*
              *key-applied-to-elements-of-list-1-and-list-1*
              *test-and-test-not*))
