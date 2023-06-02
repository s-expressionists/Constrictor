(cl:in-package #:constrictor-test)

(defun test-list* ()
  (rt:do-test 'cl-test::list*.1)
  (rt:do-test 'cl-test::list*.2)
  (rt:do-test 'cl-test::list-list*.1)
  (rt:do-test 'cl-test::list*.3)
  (rt:do-test 'cl-test::list*.order.1)
  (rt:do-test 'cl-test::list*.order.2))
