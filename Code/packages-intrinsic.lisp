(cl:in-package #:common-lisp-user)

(defpackage constrictor
  (:use #:common-lisp)
  (:shadow #:error)
  (:export . #.constrictor-asdf:*string-designators*)
  (:export #:error))
