(cl:in-package #:constrictor-test)

(defun test ()
  (test-endp)
  (test-subst)
  (test-subst-if)
  (test-subst-if-not)
  (test-list-length)
  (test-assoc)
  (test-assoc-if)
  (test-assoc-if-not)
  (test-rassoc)
  (test-rassoc-if)
  (test-rassoc-if-not)
  (test-last)
  (test-butlast)
  (test-ldiff)
  (test-tailp)
  (test-member)
  (test-member-if)
  (test-member-if-not)
  (test-mapcar)
  (test-mapc)
  (test-mapl)
  (test-mapcan)
  (test-maplist)
  (test-mapcon)
  (test-acons)
  (test-nthcdr)
  (test-append)
  (values))
