(cl:in-package #:constrictor)

(defparameter *must-be-proper-list-message*
  "A proper list was exptected, but the~@
   following was found instead:~@
   ~s")

;;; This macro can be used to traverse a list that must be a proper
;;; list, when each element of the list must be examined.  Client code
;;; must supply the name of a variable that will hold each element and
;;; a form that evaluates to the list to be traversed.  The body code
;;; is evaluated for every element of the list.  An error is signaled
;;; when a dotted list is given.
(defmacro with-proper-list-elements ((element-variable list) &body body)
  (let ((list-variable (gensym))
        (rest-variable (gensym)))
    `(loop with ,list-variable = ,list
           for ,rest-variable = ,list-variable then (rest ,rest-variable)
           for ,element-variable
             = (if (atom ,rest-variable) nil (first ,rest-variable))
           until (atom ,rest-variable)
           do ,@body
           finally (unless (null ,rest-variable)
                     (error 'list-must-be-proper
                            :offending-list ,list-variable
                            :datum ,rest-variable)))))

;;; This macro can be used to traverse a list that must be a proper
;;; list, when each tail of the list must be examined.  Client code
;;; must supply the name of a variable that will hold each tail and
;;; a form that evaluates to the list to be traversed.  The body code
;;; is evaluated for every element of the list.  An error is signaled
;;; when a dotted list is given.
(defmacro with-proper-list-rests ((rest-variable list) &body body)
  (let ((list-variable (gensym)))
    `(loop with ,list-variable = ,list
           for ,rest-variable = ,list-variable then (rest ,rest-variable)
           until (atom ,rest-variable)
           do ,@body
           finally (unless (null ,rest-variable)
                     (error 'list-must-be-proper
                            :offending-list ,list-variable
                            :datum ,rest-variable)))))

(defun read-new-cons ()
  (format *query-io*
          "Enter a CONS: ")
  (finish-output *query-io*)
  (list (read *query-io*)))

(defmacro with-alist-elements ((element-variable alist) &body body)
  ;; We can use for ... on, because it uses atom to test the end
  ;; of the list
  (let ((rest-variable (gensym))
        (alist-variable (gensym))
        (position-variable (gensym))
        (new-cons-variable (gensym)))
    `(loop with ,alist-variable = ,alist
           for ,rest-variable on ,alist-variable
           for ,position-variable from 0
           do (let ((,element-variable (car ,rest-variable)))
                #+sbcl
                (declare (sb-ext:muffle-conditions sb-ext:compiler-note))
                (if (consp ,element-variable)
                    (progn ,@body)
                    (loop until (consp ,element-variable)
                          do (restart-case
                                 (error 'invalid-alist-element
                                        :datum ,element-variable
                                        :offending-list ,alist-variable
                                        :offending-element-position
                                        ,position-variable)
                               (replace (,new-cons-variable)
                                 :report "Supply a new CONS cell."
                                 :interactive read-new-cons
                                 (setf ,element-variable
                                       ,new-cons-variable))
                               (ignore ()
                                 :report "Ignore the element."
                                 (return))
                               (use ()
                                 :report "Use the element anyway."
                                 (loop-finish)))
                          finally (progn ,@body))))
           finally (unless (null ,rest-variable)
                     (restart-case
                         (error 'alist-must-not-be-a-dotted-list
                                :datum ,rest-variable
                                :offending-element ,alist-variable)
                       (treat-as-nil ()
                         :report "Treat the element as NIL."))))))

(defmacro check-test-and-test-not
    (test-supplied-p-variable test-not-supplied-p-variable)
  `(when (and ,test-supplied-p-variable ,test-not-supplied-p-variable)
     (locally
         #+sbcl (declare (sb-ext:muffle-conditions sb-ext:compiler-note))
       (loop while (and ,test-supplied-p-variable
                        ,test-not-supplied-p-variable)
             do (restart-case
                    (error 'both-test-and-test-not-supplied)
                  (unsupply-test ()
                    :report "Unsupply :TEST."
                    (setf ,test-supplied-p-variable nil))
                  (unsupply-test-not ()
                    :report "Unsupply :TEST-NOT."
                    (setf ,test-not-supplied-p-variable nil)))))))
  
(defmacro with-key ((key) &body body )
  `(if (or (null ,key)
           (eq ,key #'identity)
           (eq ,key 'identity))
       (macrolet ((apply-key (form)
                    form))
         ,@body)
       (macrolet ((apply-key (form)
                    `(funcall ,',key ,form)))
         ,@body)))

(defmacro with-test
    ((test test-supplied-p test-not test-not-supplied-p) &body body)
  `(if (null ,test-not)
       (cond ((eq ,test #'eq)
              (macrolet ((apply-test (form1 form2)
                           `(eq ,form1 ,form2)))
                ,@body))
             ((eq ,test #'eql)
              (macrolet ((apply-test (form1 form2)
                           `(eql ,form1 ,form2)))
                ,@body))
             (t
              (macrolet ((apply-test (form1 form2)
                           `(funcall ,',test ,form1 ,form2)))
                ,@body)))
       (cond ((eq ,test-not #'eq)
              (macrolet ((apply-test (form1 form2)
                           `(not (eq ,form1 ,form2))))
                ,@body))
             ((eq ,test-not #'eql)
              (macrolet ((apply-test (form1 form2)
                           `(not (eql ,form1 ,form2))))
                ,@body))
             (t
              (macrolet ((apply-test (form1 form2)
                           `(not (funcall ,',test-not ,form1 ,form2))))
                ,@body)))))

(defmacro with-canonical-key ((key-variable) &body body)
  `(if (or (null ,key-variable)
           (eq ,key-variable #'identity)
           (eq ,key-variable 'identity))
       (let ((,key-variable #'identity))
         ,@body)
       (progn ,@body)))

(defmacro with-canonical-key-test-test-not
    ((key-variable
      test-variable test-supplied-p-variable
      test-not-variable test-not-supplied-p-variable)
     &body body)
  `(progn (check-test-and-test-not
           ,test-supplied-p-variable ,test-not-supplied-p-variable)
          (if (or (null ,key-variable)
                  (eq ,key-variable #'identity)
                  (eq ,key-variable 'identity))
              (if (not ,test-not-supplied-p-variable)
                  (cond ((or (eq ,test-variable #'eq)
                             (eq ,test-variable 'eq))
                         (let ((,key-variable #'identity)
                               (,test-variable #'eq)
                               (,test-not-variable nil))
                           ,@body))
                        ((or (eq ,test-variable #'eql)
                             (eq ,test-variable 'eql))
                         (let ((,key-variable #'identity)
                               (,test-variable #'eql)
                               (,test-not-variable nil))
                           ,@body))
                        (t
                         (let ((,key-variable #'identity)
                               (,test-not-variable nil))
                           ,@body)))
                  (cond ((or (eq ,test-not-variable #'eq)
                             (eq ,test-not-variable 'eq))
                         (let ((,key-variable #'identity)
                               (,test-variable nil)
                               (,test-not-variable #'eq))
                           ,@body))
                        ((or (eq ,test-not-variable #'eql)
                             (eq ,test-not-variable 'eql))
                         (let ((,key-variable #'identity)
                               (,test-variable nil)
                               (,test-not-variable #'eql))
                           ,@body))
                        (t
                         (let ((,key-variable #'identity)
                               (,test-variable nil))
                           ,@body))))
              (if (not ,test-not-supplied-p-variable)
                  (cond ((or (eq ,test-variable #'eq)
                             (eq ,test-variable 'eq))
                         (let ((,test-variable #'eq)
                               (,test-not-variable nil))
                           ,@body))
                        ((or (eq ,test-variable #'eql)
                             (eq ,test-variable 'eql))
                         (let ((,test-variable #'eql)
                               (,test-not-variable nil))
                           ,@body))
                        (t
                         (let ((,test-not-variable nil))
                           ,@body)))
                  (cond ((or (eq ,test-not-variable #'eq)
                             (eq ,test-not-variable 'eq))
                         (let ((,test-variable nil)
                               (,test-not-variable #'eq))
                           ,@body))
                        ((or (eq ,test-not-variable #'eql)
                             (eq ,test-not-variable 'eql))
                         (let ((,test-variable nil)
                               (,test-not-variable #'eql))
                           ,@body))
                        (t
                         (let ((,test-variable nil))
                           ,@body)))))))
