(cl:in-package #:constrictor-test)

(defun test-nconc ()
  (rt:do-test 'cl-test::nconc.1)
  (rt:do-test 'cl-test::nconc.2)
;;; (deftest nconc.3
  (rt:do-test 'cl-test::nconc.4)
  (rt:do-test 'cl-test::nconc.5)
  (rt:do-test 'cl-test::nconc.6)
  (rt:do-test 'cl-test::nconc.7)
  (rt:do-test 'cl-test::nconc.order.1)
  (rt:do-test 'cl-test::nconc.order.2))
