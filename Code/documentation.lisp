(cl:in-package #:constrictor)

;;; This file contains snippets of documentation strings that are
;;; common between several functions.

(defparameter *list-should-be-proper*
  (format nil
          "LIST should be a proper list.  If LIST is not a list~@
           or LIST is a dotted list, and no element of LIST~@
           satisfies the test, then an error of type TYPE-ERROR~@
           is signaled."))

(defparameter *list-1-and-list-2-must-be-proper*
  (format nil
          "LIST-1 and LIST-2 must be proper lists.  If either LIST-1~@
           or LIST-2 is not a proper list, then an error is signaled."))

(defparameter *key*
  (format nil
          "KEY is either NIL or a designator for a function of one~@
           argument.  If KEY is NIL or not provided, it defaults to~@
           the function named IDENTITY."))

(defparameter *key-applied-to-elements-of-list-1-and-list-1*
  (format nil
          "The function denoted by KEY is applied to each element~@
           of LIST-1 and LIST-2 before the test is applied.  KEY~@
           is typically used to extract a slot from an element of~@
           either LIST-1 or LIST-2 to be used for the test, but~@
           this is not a requirement."))

(defparameter *key-applied-to-elements-of-list*
  (format nil
          "The function denoted by KEY is applied to each element~@
           of LIST before the test is applied.  KEY is typically used~@
           to extract a slot from an element of LIST to be used for~@
           the test, but this is not a requirement."))

(defparameter *test-and-test-not*
  (format nil
          "TEST and TEST-NOT are designators for functions of two~@
           arguments.  The return value is used by this function~@
           as a generalized Boolean to determine whether the test~@
           is satisfied.  TEST and TEST-NOT can not both be provided.~@
           If both TEST and TEST-NOT are provided, an error is signaled.~@
           If neither TEST nor TEST-NOT is provided, then the default~@
           is the function named EQL for TEST."))
