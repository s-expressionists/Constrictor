(cl:in-package #:constrictor-test)

(defun test-copy-tree ()
  (rt:do-test 'cl-test::copy-tree.1)
  (rt:do-test 'cl-test::copy-tree.2)
  (rt:do-test 'cl-test::copy-tree.order.1)
  (rt:do-test 'cl-test::copy-tree.error.1)
  (rt:do-test 'cl-test::copy-tree.error.2))
