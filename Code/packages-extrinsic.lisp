(cl:in-package #:common-lisp-user)

(defpackage constrictor
  (:use #:common-lisp)
  (:shadow . #.constrictor-asdf:*string-designators*)
  (:export . #.constrictor-asdf:*string-designators*))
