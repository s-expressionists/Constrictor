(cl:in-package #:constrictor)

(defun tree-equal-core
    (tree-1 tree-2 test test-supplied-p test-not test-not-supplied-p)
  (with-test (test test-supplied-p test-not test-not-supplied-p)
    (labels ((tree-equal-local (tree-1 tree-2)
               (if (atom tree-1)
                   (if (atom tree-2)
                       (apply-test tree-1 tree-2)
                       nil)
                   (if (atom tree-2)
                       nil
                       (and (tree-equal-local (car tree-1) (car tree-2))
                            (tree-equal-local (cdr tree-1) (cdr tree-2)))))))
      (tree-equal-local tree-1 tree-2))))

(defun tree-equal (tree-1 tree-2
                   &key
                     (test nil test-supplied-p)
                     (test-not nil test-not-supplied-p))
  (tree-equal-core tree-1 tree-2
                   test test-supplied-p
                   test-not test-not-supplied-p))
