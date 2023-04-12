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
