(cl:in-package #:constrictor)

(define-condition warn-both-test-and-test-not-supplied (warning)
  ()
  (:report (lambda (condition stream)
             (declare (ignore condition))
             (format stream
                     "At most one of the keyword arguments~@
                      :TEST and :TEST-NOT can be supplied,~@
                      but both were supplied."))))

(define-condition invalid-alist-element (type-error)
  ((%offending-list
    :initarg :offending-list
    :reader offending-list)
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
                     (offending-list condition)
                     (type-error-datum condition)
                     (offending-element-position condition)))))

(define-condition alist-must-be-list (type-error)
  ()
  (:report (lambda (condition stream)
             (format stream
                     "An association list was required, but the~@
                      following object was supplied instead:~@
                      ~s."
                     (type-error-datum condition))))
  (:default-initargs :expected-type 'cl:list))

(define-condition alist-must-not-be-a-dotted-list (type-error)
  ((%offending-list
    :initarg :offending-list
    :reader offending-list))
  (:default-initargs :expected-type 'cl:list)
  (:report (lambda (condition stream)
             (format stream
                     "A list that is not an association list was supplied~@
                      in a context where an association list is required.~@
                      The supplied list:~@
                      ~s~@
                      is not terminated by NIL, but instead by the atom:
                      ~s."
                     (offending-list condition)
                     (type-error-datum condition)))))

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

(define-condition list-must-not-be-a-circular-list (cl:error)
  ((%offending-list
    :initarg :offending-list
    :reader offending-list))
  (:report (lambda (condition stream)
             (format stream
                     "A circular list was supplied where a proper list~@
                      or a dotted list is required:~@
                      ~s"
                     (offending-list condition)))))

(define-condition both-test-and-test-not-supplied (cl:error)
  ()
  (:report (lambda (condition stream)
             (declare (ignore condition))
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
  (:default-initargs :expected-type 'cl:list))

(define-condition at-least-one-list-must-be-supplied (program-error)
  ()
  (:report (lambda (condition stream)
             (declare (ignore condition))
             (format stream
                     "At least one list must be supplied"))))

(define-condition must-be-list (type-error)
  ()
  (:report (lambda (condition stream)
             (format stream
                     "A list must be given, but the~@
                      following was found instead:~@
                      ~s"
                     (type-error-datum condition))))
  (:default-initargs :expected-type 'cl:list))

(define-condition list-must-be-proper (cl:error)
  ((%offending-list
    :initarg :offending-list
    :reader offending-list))
  (:report (lambda (condition stream)
             (format stream
                     "A proper list must be given, but the~@
                      following was found instead:~@
                      ~s"
                     (offending-list condition)))))

(define-condition list-must-not-be-dotted (list-must-be-proper type-error)
  ()
  (:report (lambda (condition stream)
             (format stream
                     "A proper list must be given, but the following~@
                      dotted list was given instead:~@
                      ~s"
                     (offending-list condition))))
  (:default-initargs :expected-type 'cl:list))

(define-condition keys-and-data-must-have-the-same-length (cl:error)
  ((%keys :initarg :keys :reader keys)
   (%data :initarg :data :reader data))
  (:report (lambda (condition stream)
             (format stream
                     "The list of keys and the list of data must~@
                      have the same length.  But the given list of~@
                      keys has length ~d, and the give list of data~@
                      has the length ~d"
                     (length (keys condition))
                     (length (data condition))))))

(define-condition list-must-be-proper-or-circular (type-error)
  ()
  (:report (lambda (condition stream)
             (format stream
                     "A proper list or a circular list must be supplied,~@
                      but the following was found instead:~@
                      ~s"
                     (type-error-datum condition))))
  (:default-initargs :expected-type 'cl:list))

(define-condition must-be-property-list (type-error)
  ((%offending-list
    :initarg :offending-list
    :reader offending-list))
  (:report (lambda (condition stream)
             (format stream
                     "A property list (i.e., a list with an even~@
                      number of elements) must be given, but the~@
                      following was found instead:~@
                      ~s"
                     (offending-list condition))))
  (:default-initargs :expected-type 'cons))
