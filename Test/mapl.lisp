(cl:in-package #:constrictor-test)

(defun test-mapl ()
  (rt:do-test 'cl-test::mapl.1)
  (rt:do-test 'cl-test::mapl.2)
  (rt:do-test 'cl-test::mapl.3)
  (rt:do-test 'cl-test::mapl.4)
  (rt:do-test 'cl-test::mapl.5)
  (rt:do-test 'cl-test::mapl.order.1)
  (rt:do-test 'cl-test::mapl.error.1)
  (rt:do-test 'cl-test::mapl.error.2)
  (rt:do-test 'cl-test::mapl.error.3)
  (rt:do-test 'cl-test::mapl.error.4)
  (rt:do-test 'cl-test::mapl.error.5)
  (rt:do-test 'cl-test::mapl.error.6)
  (rt:do-test 'cl-test::mapl.error.7)
  (rt:do-test 'cl-test::mapl.error.8))
