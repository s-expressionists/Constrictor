(cl:in-package #:constrictor)

;;; We define a version of ERROR that is specific to this library.  It
;;; differs from the standard function in that it has two required
;;; parameters, a symbol naming a condition and a FORMAT control.  The
;;; default method on this generic function ignores the name and uses
;;; the format control and the remaining arguments to call CL:ERROR
;;; which then signals a condition of type SIMPLE-ERROR.  Clients that
;;; want more specific conditions to be signaled can define methods on
;;; this generic function.  Such methods would then have an EQL
;;; specializer for the name parameter.

(defgeneric error (condition-name format-control &rest arguments))

(defmethod error (condition-name format-control &rest arguments)
  (apply #'cl:error format-control arguments))
