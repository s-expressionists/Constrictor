(cl:in-package #:constrictor-test)

(defun test-subst ()
  (rt:do-test 'cl-test::subst.1)
  (rt:do-test 'cl-test::subst.2)
  (rt:do-test 'cl-test::subst.3)
  (rt:do-test 'cl-test::subst.4)
  (rt:do-test 'cl-test::subst.5)
  (rt:do-test 'cl-test::subst.6)
  (rt:do-test 'cl-test::subst.7)
  (rt:do-test 'cl-test::subst.8)
  (rt:do-test 'cl-test::subst.9)
  (rt:do-test 'cl-test::subst.10)
  (rt:do-test 'cl-test::subst.11)

  (rt:do-test 'cl-test::subst.order.1)
  (rt:do-test 'cl-test::subst.order.2)

  (rt:do-test 'cl-test::subst.allow-other-keys.1)
  (rt:do-test 'cl-test::subst.allow-other-keys.2)
  (rt:do-test 'cl-test::subst.allow-other-keys.3)
  (rt:do-test 'cl-test::subst.allow-other-keys.4)
  (rt:do-test 'cl-test::subst.allow-other-keys.5)
  (rt:do-test 'cl-test::subst.keywords.6)

  (rt:do-test 'cl-test::subst.error.1)
  (rt:do-test 'cl-test::subst.error.2)
  (rt:do-test 'cl-test::subst.error.3)
  (rt:do-test 'cl-test::subst.error.4)
  (rt:do-test 'cl-test::subst.error.5)
  (rt:do-test 'cl-test::subst.error.6)
  (rt:do-test 'cl-test::subst.error.7)
  (rt:do-test 'cl-test::subst.error.8)
  (rt:do-test 'cl-test::subst.error.9)
  (rt:do-test 'cl-test::subst.error.10))