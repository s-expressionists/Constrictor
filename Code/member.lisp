(cl:in-package #:constrictor)

(declaim (inline member))

(cl:in-package #:constrictor)

(declaim (inline member-core))

(defun member-core
    (item list key test test-supplied-p test-not test-not-supplied-p)
  (with-key (key)
    (with-test (test test-supplied-p test-not test-not-supplied-p)
      (with-proper-list-rests (rest list)
        (when (apply-test item (apply-key (car rest)))
          (return-from member-core rest))))))

(declaim (notinline member-core))

(declaim (inline member))

(defun member
    (item list
     &key
       key
       (test #'eql test-supplied-p)
       (test-not #'eql test-not-supplied-p))
  (with-canonical-key-test-test-not
      (key test test-supplied-p test-not test-not-supplied-p)
    (member-core item list
                 key
                 test test-supplied-p
                 test-not test-not-supplied-p)))

(declaim (notinline member))
