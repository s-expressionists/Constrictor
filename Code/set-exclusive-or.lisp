(cl:in-package #:constrictor)

(declaim (inline set-exclusive-or-core))

(defun set-exclusive-or-core
    (list-1 list-2 key key-supplied-p test test-supplied-p test-not test-not-supplied-p)
  (check-type list-1 proper-list)
  (check-type list-2 proper-list)
  (with-key (key key-supplied-p)
    (with-test (test test-supplied-p test-not test-not-supplied-p)
      (let ((result '()))
        (loop for element-1 in list-1
              do (loop for element-2 in list-2
                       when (apply-test (apply-key element-1)
                                        (apply-key element-2))
                         return nil
                       finally (push element-1 result)))
        (loop for element-2 in list-2
              do (loop for element-1 in list-1
                       when (apply-test (apply-key element-1)
                                        (apply-key element-2))
                         return nil
                       finally (push element-2 result)))
        result))))

(declaim (notinline set-exclusive-or-core))

(declaim (inline set-exclusive-or))

(defun set-exclusive-or
    (list-1 list-2
     &key
       (key #'identity key-supplied-p)
       (test #'eql test-supplied-p)
       (test-not #'eql test-not-supplied-p))
  (set-exclusive-or-core list-1 list-2
                         key key-supplied-p
                         test test-supplied-p
                         test-not test-not-supplied-p))

(define-compiler-macro set-exclusive-or (&whole form &rest arguments)
  (let ((lambda-list
          '((list-1 list-2) ; required
            ()           ; optional
            nil          ; rest
            ((:key key key-supplied-p)
             (:test test test-supplied-p)
             (:test-not test-not test-not-supplied-p))
            nil)))
    (unless (check-call-site arguments lambda-list)
      (return-from set-exclusive-or form))
    (compute-compiler-macro-body
     arguments
     (butlast lambda-list)
     '(set-exclusive-or-core
       list-1 list-2
       key key-supplied-p
       test test-supplied-p
       test-not test-not-supplied-p))))
