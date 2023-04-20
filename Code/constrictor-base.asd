(cl:in-package #:asdf-user)

(defsystem #:constrictor-base
  :serial t
  :description "Implementation of the Conses dictionary, base system.")

(cl:defpackage #:constrictor-asdf
  (:use #:common-lisp)
  (:export #:*string-designators*))

(cl:in-package #:constrictor-asdf)

(defparameter *string-designators*
  '(#:caar #:cadr #:cdar #:cddr
    #:caaar #:caadr #:cadar #:caddr
    #:cdaar #:cdadr #:cddar #:cdddr
    #:caaaar #:caaadr #:caadar #:caaddr
    #:cadaar #:cadadr #:caddar #:cadddr
    #:cdaaar #:cdaadr #:cdadar #:cdaddr
    #:cddaar #:cddadr #:cdddar #:cddddr
    #:first #:second #:third #:fourth #:fifth
    #:sixth #:seventh #:eighth #:ninth #:tenth
    #:consp #:atom #:listp
    #:nth #:nthcdr
    #:endp
    #:make-list
    #:copy-list
    #:list-length
    #:tree-equal
    #:copy-tree
    #:append
    #:copy-alist
    #:list #:list*
    #:subst #:subst-if #:subst-if-not
    #:nsubst #:nsubst-if #:nsubst-if-not
    #:member #:member-if #:member-if-not
    #:assoc #:assoc-if #:assoc-if-not
    #:rassoc #:rassoc-if #:rassoc-if-not
    #:pairlis
    #:last #:butlast #:nbutlast
    #:mapcar #:mapc #:mapcan #:maplist #:mapl #:mapcon))
