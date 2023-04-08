(cl:in-package #:common-lisp-user)

(defpackage constrictor
  (:use #:common-lisp)
  (:export . #.constrictor-asdf:*string-designators*))
