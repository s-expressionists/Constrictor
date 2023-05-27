(cl:in-package #:constrictor-test)

(defun test-rassoc-if-not ()
  (rt:do-test 'cl-test::rassoc-if-not.1)
  (rt:do-test 'cl-test::rassoc-if-not.2)
  (rt:do-test 'cl-test::rassoc-if-not.3)
  (rt:do-test 'cl-test::rassoc-if-not.4)
  (rt:do-test 'cl-test::rassoc-if-not.order.1)
  (rt:do-test 'cl-test::rassoc-if-not.order.2)
  (rt:do-test 'cl-test::rassoc-if-not.allow-other-keys.1)
  (rt:do-test 'cl-test::rassoc-if-not.allow-other-keys.2)
  (rt:do-test 'cl-test::rassoc-if-not.allow-other-keys.3)
  (rt:do-test 'cl-test::rassoc-if-not.allow-other-keys.4)
  (rt:do-test 'cl-test::rassoc-if-not.allow-other-keys.5)
  (rt:do-test 'cl-test::rassoc-if-not.allow-other-keys.6)
  (rt:do-test 'cl-test::rassoc-if-not.keywords.7)
  (rt:do-test 'cl-test::rassoc-if-not.error.1)
  (rt:do-test 'cl-test::rassoc-if-not.error.2)
  (rt:do-test 'cl-test::rassoc-if-not.error.3)
  (rt:do-test 'cl-test::rassoc-if-not.error.4)
  (rt:do-test 'cl-test::rassoc-if-not.error.5)
  (rt:do-test 'cl-test::rassoc-if-not.error.6)
  (rt:do-test 'cl-test::rassoc-if-not.error.7)
  (rt:do-test 'cl-test::rassoc-if-not.error.8)
  (rt:do-test 'cl-test::rassoc-if-not.error.9)
  (rt:do-test 'cl-test::rassoc-if-not.error.10)
  (rt:do-test 'cl-test::rassoc-if-not.error.11)
  (rt:do-test 'cl-test::rassoc-if-not.error.12))