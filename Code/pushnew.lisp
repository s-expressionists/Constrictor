(cl:in-package #:constrictor)

(defmacro pushnew
    (item place
     &environment environment
     &rest rest
     &key key (test nil test-supplied-p) (test-not nil test-not-supplied-p))
  (declare (ignore key test test-not))
  (if (and test-supplied-p test-not-supplied-p)
      (progn (warn 'warn-both-test-and-test-not-given)
             `(error 'both-test-and-test-not-given))
      (let ((item-var (gensym)))
        (multiple-value-bind (vars vals store-vars writer-form reader-form)
            (get-setf-expansion place environment)
          `(let* ((,item-var ,item)
                  ,@(mapcar #'list vars vals)
                  (,(car store-vars)
                    (adjoin ,item-var ,reader-form ,@rest)))
             ,writer-form)))))

(setf (documentation 'pushnew 'function)
      (format nil
              "Syntax: pushnew item place &key key test test-not~@
               ~@
               This macro pushes ITEM to the front of the list that~@
               is the value of PLACE, and updates PLACE accordingly,~@
               if and only if ITEM is not already an element of that~@
               list, as defined by KEY and TEST or TEST-NOT.~@
               ~%~a~%~@
               The function denoted by KEY is applied to each element~@
               of the list that is the value of PLACE before the test~@
               is applied.  KEY is typically used to extract a slot~@
               from the element of the list to be used for the test,~@
               but this is not a requirement.~@
               ~%~a"
              *key* *test-and-test-not*))
