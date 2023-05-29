(cl:in-package #:constrictor-test)

(defun test-nsubst ()
  (rt:do-test 'cl-test::nsubst.1)
  (rt:do-test 'cl-test::nsubst.2)
  (rt:do-test 'cl-test::nsubst.3)
  (rt:do-test 'cl-test::nsubst.4)
  (rt:do-test 'cl-test::nsubst.5)
  (rt:do-test 'cl-test::nsubst.6)
  (rt:do-test 'cl-test::nsubst.7)
  (rt:do-test 'cl-test::nsubst.8)
  (rt:do-test 'cl-test::nsubst.9)
  (rt:do-test 'cl-test::nsubst.10)
  (rt:do-test 'cl-test::nsubst.11)
  (rt:do-test 'cl-test::nsubst.order.1)
  (rt:do-test 'cl-test::nsubst.order.2)
  (rt:do-test 'cl-test::nsubst.allow-other-keys.1)
  (rt:do-test 'cl-test::nsubst.allow-other-keys.2)
  (rt:do-test 'cl-test::nsubst.allow-other-keys.3)
  (rt:do-test 'cl-test::nsubst.allow-other-keys.4)
  (rt:do-test 'cl-test::nsubst.allow-other-keys.5)
  (rt:do-test 'cl-test::nsubst.keywords.6)
  (rt:do-test 'cl-test::nsubst.error.1)
  (rt:do-test 'cl-test::nsubst.error.2)
  (rt:do-test 'cl-test::nsubst.error.3)
  (rt:do-test 'cl-test::nsubst.error.4)
  (rt:do-test 'cl-test::nsubst.error.5)
  (rt:do-test 'cl-test::nsubst.error.6)
  (rt:do-test 'cl-test::nsubst.error.7)
  (rt:do-test 'cl-test::nsubst.error.8)
  (rt:do-test 'cl-test::nsubst.error.9)
  (rt:do-test 'cl-test::nsubst.error.10))
