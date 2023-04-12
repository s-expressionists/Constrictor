(cl:in-package #:constrictor)

;;; We define a version of ERROR that is specific to this library.  It
;;; differs from the standard function in that it is generic.  It has
;;; a single required parameter which is a symbol naming a condition
;;; type.  In most cases, that symbol is specific to this library, and
;;; it names a condition defined in this library.  The default method
;;; of ERROR calls CL:ERROR with the same arguments as it received, so
;;; a reasonable error report is issued.
;;;
;;; However, some clients may prefer that a condition of their own
;;; type is signaled, instead of a condition of a type defined here.
;;; Such a client can then define a method on ERROR with an EQL
;;; specializer for the first parameter.  This method can then signal
;;; its own error, selecting the additional arguments that it needs.

(defgeneric error (condition-name &rest arguments))

(defmethod error (condition-name &rest arguments)
  (apply #'cl:error condition-name arguments))
