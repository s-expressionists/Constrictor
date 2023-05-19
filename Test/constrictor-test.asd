(cl:in-package #:asdf-user)

(defsystem #:constrictor-test
  :depends-on (#:constrictor-extrinsic
               #:ansi-test-common)
  :serial t
  :components
  ((:file "packages")
   (:file "prepare")
   (:file "subst")
   (:file "subst-if")
   (:file "subst-if-not")
   (:file "assoc")
   (:file "last")
   (:file "mapcar")
   (:file "mapc")
   (:file "mapl")
   (:file "mapcan")
   (:file "maplist")
   (:file "mapcon")
   (:file "acons")
   (:file "test")))
