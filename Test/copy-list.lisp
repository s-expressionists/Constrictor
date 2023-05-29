(cl:in-package #:constrictor-test)

(defun test-copy-list ()
  (rt:do-test 'cl-test::copy-list.1)
  (rt:do-test 'cl-test::copy-list.2)
  (rt:do-test 'cl-test::copy-list.3)
  (rt:do-test 'cl-test::copy-list.4)
  (rt:do-test 'cl-test::copy-list.error.1)
  (rt:do-test 'cl-test::copy-list.error.2))
