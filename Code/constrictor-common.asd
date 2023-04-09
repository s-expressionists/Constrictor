(cl:in-package #:asdf-user)

(defsystem constrictor-common
  :serial t
  :components
  ((:file "accessors")
   (:file "consp")))
