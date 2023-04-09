(cl:in-package #:asdf-user)

(defsystem constrictor-common
  :serial t
  :components
  ((:file "error")
   (:file "accessors")
   (:file "consp")
   (:file "copy-tree")
   (:file "subst")))
