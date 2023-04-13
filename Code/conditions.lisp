(cl:in-package #:constrictor)

(define-condition invalid-alist-element (type-error)
  ((%offending-element
    :initarg :offending-element
    :reader offending-element)
   (%offending-element-position
    :initarg :offending-element-position
    :reader offending-element-position))
  (:default-initargs :expected-type 'cl:list)
  (:report (lambda (condition stream)
             (format stream
                     "A list that is not an association list was supplied~@
                      in a context where an association list is required.~@
                      The supplied list:~@
                      ~s~@
                      contains an invalid element:~@
                      ~s~@
                      in position ~d."
                     (type-error-datum condition)
                     (offending-element condition)
                     (offending-element-position condition)))))

(define-condition alist-must-not-be-a-dotted-list (type-error)
  ((%offending-element
    :initarg :offending-element
    :reader offending-element))
  (:default-initargs :expected-type 'cl:list)
  (:report (lambda (condition stream)
             (format stream
                     "A list that is not an association list was supplied~@
                      in a context where an association list is required.~@
                      The supplied list:~@
                      ~s~@
                      is not terminated by NIL, but instead by the atom:
                      ~s."
                     (type-error-datum condition)
                     (offending-element condition)))))

(define-condition alist-must-not-be-a-circular-list (type-error)
  ()
  (:default-initargs :expected-type 'cl:list)
  (:report (lambda (condition stream)
             (format stream
                     "A list that is not an association list was supplied~@
                      in a context where an association list is required.~@
                      The supplied list:~@
                      ~s~@
                      is a circular list."
                     (type-error-datum condition)))))

(define-condition both-test-and-test-not-supplied (cl:error)
  ()
  (:report (lambda (condition stream)
             (format stream
                     "At most one of the keyword arguments~@
                      :TEST and :TEST-NOT can be supplied,~@
                      but both were supplied."))))

(define-condition list-expected (type-error)
  ()
  (:report (lambda (condition stream)
             (format stream
                     "An object of type LIST was expcected~@
                      but the following was found instead:~@
                      ~s"
                     (type-error-datum condition))))
  (:default-initargs :expected-type 'list))

(define-condition at-least-one-list-must-be-supplied (cl:error)
  ()
  (:report (lambda (condition stream)
             (format stream
                     "At least one list must be supplied"))))

(define-condition list-must-be-proper (type-error)
  ()
  (:report (lambda (condition stream)
             (format stream
                     "A proper list must be given, but the~@
                      following was found instead:~@
                      ~s"
                     (type-error-datum condition))))
  (:default-initargs :expected-type 'list))
