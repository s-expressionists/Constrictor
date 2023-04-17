(cl:in-package #:constrictor)

(declaim (inline assoc-core))

(defun assoc-core (item alist key test test-not)
  (with-key (key)
    (with-test (test test-not)
      (with-alist-elements (element alist)
        (when (apply-test item (apply-key (car element)))
          (return-from assoc-core element))))))

(declaim (notinline assoc-core))

(declaim (inline assoc))

(defun assoc
    (item alist
     &key
       (key #'identity)
       (test #'eql test-supplied-p)
       (test-not #'eql test-not-supplied-p))
  (with-canonical-key-test-test-not
      (key test test-supplied-p test-not test-not-supplied-p)
    (assoc-core item alist key test test-not)))

(declaim (notinline assoc))

(define-compiler-macro assoc
    (&whole form item-form alist-form &rest arguments)
  (let ((triples (process-keyword-arguments
                  arguments '(:key :test :test-not))))
    (when (eq triples :unacceptable)
      (return-from assoc form))
    (when (and (find-triple :test triples)
               (find-triple :test-not triples))
      (return-from assoc form))
    (multiple-value-bind (let-bindings ignorable-declaration)
        (compute-let-bindings-and-declarations triples)
      `(let ,let-bindings
         ,ignorable-declaration
         (assoc-core
          ,item-form
          ,alist-form
          ,(let ((triple (find-triple :key triples)))
             (if (or (null triple)
                     (member (second triple) '(nil 'identity #'identity)
                             :test #'equal))
                 #'identity
                 (third triple)))
          ,(let ((triple (find-triple :test triples)))
             (cond ((find-triple :test-not triples)
                    'nil)
                   ((or (null triple)
                        (member (second triple) '(#'eql 'eql)
                                :test #'equal))
                    #'eql)
                   ((member (second triple) '(#'eq 'eq)
                            :test #'equal)
                    #'eq)
                   (t
                    (third triple))))
          ,(let ((triple (find-triple :test-not triples)))
             (cond ((or (find-triple :test triples)
                        (null triple))
                    'nil)
                   ((member (second triple) '(#'eq 'eq)
                            :test #'equal)
                    #'eq)
                   ((member (second triple) '(#'eql 'eql)
                            :test #'equal)
                    #'eql)
                   (t
                    (third triple)))))))))
