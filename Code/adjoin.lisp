(cl:in-package #:constrictor)

(declaim (inline adjoin-core))

(defun adjoin-core
    (item list key key-supplied-p test test-supplied-p test-not test-not-supplied-p)
  (with-key (key key-supplied-p)
    (with-test (test test-supplied-p test-not test-not-supplied-p)
      (loop for remaining on list
            when (apply-test item (apply-key (car remaining)))
              return list
            finally (if (null remaining)
                        (return (cons item list))
                        (error 'type-error
                               :datum list
                               :expected-type 'proper-list))))))

(declaim (notinline adjoin-core))

(defun adjoin
    (item list
     &key
       (key nil key-supplied-p)
       (test #'eql test-supplied-p)
       (test-not #'eql test-not-supplied-p))
  (adjoin-core item list
               key key-supplied-p
               test test-supplied-p
               test-not test-not-supplied-p))

(define-compiler-macro adjoin (&whole form &rest arguments)
  (let ((lambda-list
          '((item list) ; required
            ()          ; optional
            nil         ; rest
            ((:key key key-supplied-p)
             (:test test test-supplied-p)
             (:test-not test-not test-not-supplied-p))
            nil)))
    (unless (check-call-site arguments lambda-list)
      (return-from adjoin form))
    (compute-compiler-macro-body
     arguments
     (butlast lambda-list)
     '(adjoin-core
       item list
       key key-supplied-p
       test test-supplied-p
       test-not test-not-supplied-p))))

(setf (documentation 'adjoin 'function)
      (format nil
              "Syntax adjoin item list &key key test test-not~@
               ~@
               This function tests whether ITEM is an element~@
               of LIST, as defined by KEY and either TEST or~@
               TEST-NOT.  If ITEM is an element of LIST, then~@
               LIST is returned.  Otherwise, a new list is returned~@
               consisting of a new CONS cell with ITEM in its CAR~@
               slot and with LIST in its CDR slot~@
               ~%~a~%~%~a~%~%~a~%~%~a~%~@
               If LIST is a circular list, and no element of LIST~@
               satisfies the test, then this function will not terminate."
              *key*
              *key-applied-to-elements-of-list*
              *test-and-test-not*
              *list-should-be-proper*))
