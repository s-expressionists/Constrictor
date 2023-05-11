(cl:in-package #:constrictor)

;;; This file contains snippets of documentation strings that are
;;; common between several functions.

(defparameter *list-1-and-list-2-must-be-proper*
  (format nil
          "LIST-1 and LIST-2 must be proper lists.  If either LIST-1~@
           or LIST-2 is not a proper list, then an error of type~@
           TYPE-ERROR is signaled."))

(defparameter *key*
  (format nil
          "KEY is either NIL or a designator for a function of one~@
           argument.  If KEY is NIL or not provided, it defaults to~@
           the function named IDENTITY."))

(defparameter *test-and-test-not*
  (format nil
          "TEST and TEST-NOT are designators for functions of two~@
           arguments.  The return value is used by this function~@
           as a generalized Boolean to determine whether the test~@
           is satisfied.  TEST and TEST-NOT can not both be provided.~@
           If both TEST and TEST-NOT are provided, an error is signaled.~@
           If neither TEST nor TEST-NOT is provided, then the default~@
           is the function named EQL for TEST."))
