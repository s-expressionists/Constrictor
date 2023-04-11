(cl:in-package #:common-lisp-user)

(shadowing-import
 '(constrictor:last constrictor:butlast
   constrictor:subst constrictor:subst-if constrictor:subst-if-not
   constrictor:assoc constrictor:assoc-if constrictor:assoc-if-not)
 '#:cl-test)

(let ((*default-pathname-defaults*
        (asdf:system-relative-pathname '#:ansi-test-common ".")))
  (load "compile-and-load.lsp")
  (load "gclload1.lsp")
  (load "gclload2.lsp"))
