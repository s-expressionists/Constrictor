(cl:in-package #:constrictor-test)

(defun test-copy-alist ()
  (rt:do-test 'cl-test::copy-alist.1)
  (rt:do-test 'cl-test::copy-alist.error.1)
  (rt:do-test 'cl-test::copy-alist.error.2)
  (rt:do-test 'cl-test::copy-alist.error.3))
