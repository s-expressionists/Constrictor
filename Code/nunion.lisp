(cl:in-package #:constrictor)

(declaim (inline nunion-core))

(defun nunion-core
    (list-1 list-2 key key-supplied-p test test-supplied-p test-not test-not-supplied-p)
  (check-type list-1 proper-list)
  (check-type list-2 proper-list)
  (with-key (key key-supplied-p)
    (with-test (test test-supplied-p test-not test-not-supplied-p)
      (loop with result = list-2
            with remaining = list-1
            until (null remaining)
            do (loop for element-2 in list-2
                     when (apply-test (apply-key (car remaining))
                                      (apply-key element-2))
                       do (pop remaining)
                          (return nil)
                       finally (rotatef (cdr remaining) result remaining))
            finally (return result)))))

(declaim (notinline nunion-core))

(declaim (inline nunion))

(defun nunion
    (list-1 list-2
     &key
       (key #'identity key-supplied-p)
       (test #'eql test-supplied-p)
       (test-not #'eql test-not-supplied-p))
  (nunion-core list-1 list-2
               key key-supplied-p
               test test-supplied-p
               test-not test-not-supplied-p))

(define-compiler-macro nunion (&whole form &rest arguments)
  (let ((lambda-list
          '((list-1 list-2) ; required
            ()           ; optional
            nil          ; rest
            ((:key key key-supplied-p)
             (:test test test-supplied-p)
             (:test-not test-not test-not-supplied-p))
            nil)))
    (unless (check-call-site arguments lambda-list)
      (return-from nunion form))
    (compute-compiler-macro-body
     arguments
     (butlast lambda-list)
     '(nunion-core
       list-1 list-2
       key key-supplied-p
       test test-supplied-p
       test-not test-not-supplied-p))))
