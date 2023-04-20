(cl:in-package #:constrictor)

(declaim (inline assoc-core))

(defun assoc-core
    (item alist key key-supplied-p test test-supplied-p test-not test-not-supplied-p)
  (with-key (key key-supplied-p)
    (with-test (test test-supplied-p test-not test-not-supplied-p)
      (with-alist-elements (element alist)
        (when (apply-test item (apply-key (car element)))
          (return-from assoc-core element))))))

(declaim (notinline assoc-core))

(declaim (inline assoc))

(defun assoc
    (item alist
     &key
       (key #'identity key-supplied-p)
       (test #'eql test-supplied-p)
       (test-not #'eql test-not-supplied-p))
  (assoc-core item alist
              key key-supplied-p
              test test-supplied-p
              test-not test-not-supplied-p))

(declaim (notinline assoc))

(define-compiler-macro assoc (&whole form &rest arguments)
  (let ((lambda-list
          '((item alist) ; required
            ()           ; optional
            nil          ; rest
            ((:key key key-supplied-p)
             (:test test test-supplied-p)
             (:test-not test-not test-not-supplied-p))
            nil)))
    (unless (check-call-site arguments lambda-list)
      (return-from assoc form))
    (compute-compiler-macro-body
     arguments
     (butlast lambda-list)
     '(assoc-core
       item alist
       key key-supplied-p
       test test-supplied-p
       test-not test-not-supplied-p))))
