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
                        (error 'list-must-be-proper
                               :datum remaining
                               :offending-list list))))))

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
       item alist
       key key-supplied-p
       test test-supplied-p
       test-not test-not-supplied-p))))
