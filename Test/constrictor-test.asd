(cl:in-package #:asdf-user)

(defsystem #:constrictor-test
  :depends-on (#:constrictor-extrinsic
               #:ansi-test-common)
  :serial t
  :components
  ((:file "packages")
   (:file "prepare")
   (:file "subst")
   (:file "assoc")
   (:file "last")
   (:file "mapcar")
   (:file "mapc")
   (:file "mapl")
   (:file "mapcan")
   (:file "test")))
