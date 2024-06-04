(cl:in-package #:constrictor-extrinsic/ansi-test)

(defvar *tests*
  '("ACONS."
    "ADJOIN."
    "APPEND."
    "ASSOC-IF-NOT."
    "ASSOC-IF."
    "ASSOC."
    "ATOM."
    "BUTLAST."
    "CAAAAR."
    "CAAADR."
    "CAAAR."
    "CAADAR."
    "CAADDR."
    "CAADR."
    "CAAR."
    "CADAAR."
    "CADADR."
    "CADAR."
    "CADDAR."
    "CADDDR."
    "CADDR."
    "CADR."
    "CAR-"
    "CAR."
    "CDAAAR."
    "CDAADR."
    "CDAAR."
    "CDADAR."
    "CDADDR."
    "CDADR."
    "CDAR."
    "CDDAAR."
    "CDDADR."
    "CDDAR."
    "CDDDAR."
    "CDDDDR."
    "CDDDR."
    "CDDR."
    "CDR."
    "CONS-OF"
    "CONS-WITH"
    "CONS-EQ"
    "CONS."
    "CONSP."
    "COPY-ALIST."
    "COPY-LIST."
    "COPY-TREE."
    "ENDP-"
    "ENDP."
    "FIRST-ETC"
    "GET-PROPERTIES."
    "GETF."
    "INCF-GETF."
    "INTERSECTION."
    "INTERSECTIONALLOW-OTHER-KEYS."
    "LAST."
    "LDIFF-"
    "LDIFF."
    "LIST*"
    "LIST-LIST"
    "LIST-LENGTH-"
    "LIST-LENGTH."
    "LIST."
    "LISTP-"
    "LISTP."
    "MAKE-LIST-"
    "MAKE-LIST."
    "MAPC."
    "MAPCAN."
    "MAPCAR."
    "MAPCON."
    "MAPL."
    "MAPLIST."
    "MEMBER-IF-NOT."
    "MEMBER-IF."
    "MEMBER."
    "NBUTLAST."
    "NCONC."
    "NINTERSECTION."
    "NRECONC."
    "NSET-DIFFERENCE."
    "NSET-EXCLUSIVE-OR."
    "NSET-EXCLUSIVE."
    "NSUBLIS."
    "NSUBST-IF-NOT."
    "NSUBST-IF."
    "NSUBST."
    "NTH."
    "NTHCDR."
    "NUNION."
    "PAIRLIS."
    "POP."
    "PUSH-GETF."
    "PUSH."
    "PUSHNEW."
    "RANDOM-NSET-EXCLUSIVE-OR"
    "RANDOM-SET-EXCLUSIVE-OR"
    "RASSOC-IF-NOT."
    "RASSOC-IF."
    "RASSOC."
    "RASSOCI."
    "REMF."
    "REST."
    "REVAPPEND."
    "RPLACA."
    "RPLACD."
    "SET-DIFFERENCE."
    "SET-EXCLUSIVE-OR."
    "SET-EXCLUSIVE."
    "SETF-GETF."
    "SUBLIS."
    "SUBSETP."
    "SUBST-IF-NOT."
    "SUBST-IF."
    "SUBST."
    "TAILP."
    "TREE-EQUAL."
    "UNION-"
    "UNION."))

(deftype constrictor:null
    ()
  'null)

(deftype constrictor:list
    ()
  'list)

(deftype constrictor:member
    (&rest items)
  `(member ,@items))

(defvar *extrinsic-symbols*
  '(constrictor:caar constrictor:cadr constrictor:cdar constrictor:cddr
    constrictor:caaar constrictor:caadr constrictor:cadar constrictor:caddr
    constrictor:cdaar constrictor:cdadr constrictor:cddar constrictor:cdddr
    constrictor:caaaar constrictor:caaadr constrictor:caadar constrictor:caaddr
    constrictor:cadaar constrictor:cadadr constrictor:caddar constrictor:cadddr
    constrictor:cdaaar constrictor:cdaadr constrictor:cdadar constrictor:cdaddr
    constrictor:cddaar constrictor:cddadr constrictor:cdddar constrictor:cddddr
    constrictor:first constrictor:second constrictor:third constrictor:fourth constrictor:fifth
    constrictor:sixth constrictor:seventh constrictor:eighth constrictor:ninth constrictor:tenth
    constrictor:nth constrictor:nthcdr
    constrictor:null
    constrictor:endp
    constrictor:make-list
    constrictor:copy-list
    constrictor:list-length
    constrictor:tree-equal
    constrictor:copy-tree
    constrictor:append
    constrictor:nconc
    constrictor:revappend
    constrictor:nreconc
    constrictor:copy-alist
    constrictor:list constrictor:list*
    constrictor:subst constrictor:subst-if constrictor:subst-if-not
    constrictor:sublis constrictor:nsublis
    constrictor:nsubst constrictor:nsubst-if constrictor:nsubst-if-not
    constrictor:member constrictor:member-if constrictor:member-if-not
    constrictor:assoc constrictor:assoc-if constrictor:assoc-if-not
    constrictor:rassoc constrictor:rassoc-if constrictor:rassoc-if-not
    constrictor:get-properties
    constrictor:pairlis
    constrictor:last constrictor:butlast constrictor:nbutlast
    constrictor:acons
    constrictor:mapcar constrictor:mapc constrictor:mapcan constrictor:maplist constrictor:mapl constrictor:mapcon
    constrictor:tailp constrictor:ldiff
    constrictor:push constrictor:pop
    constrictor:getf
    constrictor:remf
    constrictor:adjoin
    constrictor:pushnew
    constrictor:intersection constrictor:nintersection
    constrictor:set-difference constrictor:nset-difference
    constrictor:union constrictor:nunion
    constrictor:set-exclusive-or constrictor:nset-exclusive-or
    constrictor:subsetp))

(defun test (&rest args)
  (let ((system (asdf:find-system :constrictor-extrinsic/ansi-test)))
    (apply #'ansi-test-harness:ansi-test
           :directory (merge-pathnames
                       (make-pathname :directory '(:relative
                                                   "dependencies"
                                                   "ansi-test"))
                       (asdf:component-pathname system))
           :expected-failures (asdf:component-pathname
                               (asdf:find-component system
                                                    '("code"
                                                      "expected-failures.sexp")))
           :extrinsic-symbols *extrinsic-symbols*
           :tests *tests*
           args)))
