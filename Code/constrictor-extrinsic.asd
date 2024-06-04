(asdf:defsystem #:constrictor-extrinsic
  :serial t
  :description "Implementation of the Conses dictionary, extrinsic system."
  :depends-on (#:constrictor-packages-extrinsic
               #:constrictor-common))

(asdf:defsystem "constrictor-extrinsic/ansi-test"
  :description "ANSI Test system for Constrictor"
  :license "BSD"
  :author ("Robert Strandh"
           "Tarn W. Burton")
  :depends-on ("constrictor-extrinsic"
               "ansi-test-harness")
  :perform (asdf:test-op (op c)
             (uiop:symbol-call :constrictor-extrinsic/ansi-test :test))
  :components ((:module code
                :pathname "ansi-test/"
                :serial t
                :components ((:file "packages")
                             (:file "test")
                             (:static-file "expected-failures.sexp")))))
