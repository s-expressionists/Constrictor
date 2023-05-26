(cl:in-package #:constrictor-test)

(defun test-nthcdr ()
  (rt:do-test 'cl-test::nthcdr.error.1)
  (rt:do-test 'cl-test::nthcdr.error.6)
  (rt:do-test 'cl-test::nthcdr.error.7)
  (rt:do-test 'cl-test::nthcdr.error.8)
  (rt:do-test 'cl-test::nthcdr.error.9)
  (rt:do-test 'cl-test::nthcdr.error.10)
  (rt:do-test 'cl-test::nthcdr.error.11)
  (rt:do-test 'cl-test::nthcdr.1)
  (rt:do-test 'cl-test::nthcdr.2)
  (rt:do-test 'cl-test::nthcdr.3)
  (rt:do-test 'cl-test::nthcdr.4)
  (rt:do-test 'cl-test::nthcdr.5)
  (rt:do-test 'cl-test::nthcdr.order.1))