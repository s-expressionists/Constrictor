(cl:in-package #:constrictor-test)

(defun test-pop ()
  (rt:do-test 'cl-test::pop.1)
  (rt:do-test 'cl-test::pop.2)
  (rt:do-test 'cl-test::pop.3)
  (rt:do-test 'cl-test::pop.order.1)
  (rt:do-test 'cl-test::push-and-pop))
