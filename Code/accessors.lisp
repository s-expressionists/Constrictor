(cl:in-package #:constrictor)

(eval-when (:compile-toplevel :load-toplevel :execute)
  (defun make-c*r-type-descriptor (string index)
    (if (zerop index)
        '(or null cons)
        (let ((subtype (make-c*r-type-descriptor string (1- index))))
          (ecase (char string index)
            (#\a `(or null (cons ,subtype)))
            (#\d `(or null (cons t ,subtype))))))))

(defmacro check-c*r-type-for (parameter string)
  `(check-type ,parameter
               ,(make-c*r-type-descriptor string (1- (length string)))))

(declaim (inline caar))

(defun caar (list)
  (declare (inline car))
  (check-c*r-type-for list "aa")
  (car (car list)))

(declaim (notinline caar))

(declaim (inline cadr))

(defun cadr (list)
  (declare (inline car cdr))
  (check-c*r-type-for list "ad")
  (car (cdr list)))

(declaim (notinline cadr))

(declaim (inline cdar))

(defun cdar (list)
  (declare (inline car cdr))
  (check-c*r-type-for list "da")
  (cdr (car list)))

(declaim (notinline cdar))

(declaim (inline cddr))

(defun cddr (list)
  (declare (inline cdr))
  (check-c*r-type-for list "dd")
  (cdr (cdr list)))

(declaim (notinline cddr))

(declaim (inline caaar))

(defun caaar (list)
  (declare (inline car caar))
  (check-c*r-type-for list "aaa")
  (car (caar list)))

(declaim (notinline caaar))

(declaim (inline caadr))

(defun caadr (list)
  (declare (inline car cadr))
  (check-c*r-type-for list "aad")
  (car (cadr list)))

(declaim (notinline caadr))

(declaim (inline cadar))

(defun cadar (list)
  (declare (inline car cdar))
  (check-c*r-type-for list "ada")
  (car (cdar list)))

(declaim (notinline cadar))

(declaim (inline caddr))

(defun caddr (list)
  (declare (inline car cddr))
  (check-c*r-type-for list "add")
  (car (cddr list)))

(declaim (notinline caddr))

(declaim (inline cdaar))

(defun cdaar (list)
  (declare (inline cdr caar))
  (check-c*r-type-for list "daa")
  (cdr (caar list)))

(declaim (notinline cdaar))

(declaim (inline cdadr))

(defun cdadr (list)
  (declare (inline cdr cadr))
  (check-c*r-type-for list "dad")
  (cdr (cadr list)))

(declaim (notinline cdadr))

(declaim (inline cddar))

(defun cddar (list)
  (declare (inline cdr cdar))
  (check-c*r-type-for list "dda")
  (cdr (cdar list)))

(declaim (notinline cddar))

(declaim (inline cdddr))

(defun cdddr (list)
  (declare (inline cdr cddr))
  (check-c*r-type-for list "ddd")
  (cdr (cddr list)))

(declaim (notinline cdddr))

(declaim (inline caaaar))

(defun caaaar (list)
  (declare (inline car caaar))
  (check-c*r-type-for list "aaaa")
  (car (caaar list)))

(declaim (notinline caaaar))

(declaim (inline caaadr))

(defun caaadr (list)
  (declare (inline car caadr))
  (check-c*r-type-for list "aaad")
  (car (caadr list)))

(declaim (notinline caaadr))

(declaim (inline caadar))

(defun caadar (list)
  (declare (inline car cadar))
  (check-c*r-type-for list "aada")
  (car (cadar list)))

(declaim (notinline caadar))

(declaim (inline caaddr))

(defun caaddr (list)
  (declare (inline car caddr))
  (check-c*r-type-for list "aadd")
  (car (caddr list)))

(declaim (notinline caaddr))

(declaim (inline cadaar))

(defun cadaar (list)
  (declare (inline car cdaar))
  (check-c*r-type-for list "adaa")
  (car (cdaar list)))

(declaim (notinline cadaar))

(declaim (inline cadadr))

(defun cadadr (list)
  (declare (inline car cdadr))
  (check-c*r-type-for list "adad")
  (car (cdadr list)))

(declaim (notinline cadadr))

(declaim (inline caddar))

(defun caddar (list)
  (declare (inline car cddar))
  (check-c*r-type-for list "adda")
  (car (cddar list)))

(declaim (notinline caddar))

(declaim (inline cadddr))

(defun cadddr (list)
  (declare (inline car cdddr))
  (check-c*r-type-for list "addd")
  (car (cdddr list)))

(declaim (notinline cadddr))

(declaim (inline cdaaar))

(defun cdaaar (list)
  (declare (inline cdr caaar))
  (check-c*r-type-for list "daaa")
  (cdr (caaar list)))

(declaim (notinline cdaaar))

(declaim (inline cdaadr))

(defun cdaadr (list)
  (declare (inline cdr caadr))
  (check-c*r-type-for list "daad")
  (cdr (caadr list)))

(declaim (notinline cdaadr))

(declaim (inline cdadar))

(defun cdadar (list)
  (declare (inline cdr cadar))
  (check-c*r-type-for list "dada")
  (cdr (cadar list)))

(declaim (notinline cdadar))

(declaim (inline cdaddr))

(defun cdaddr (list)
  (declare (inline cdr caddr))
  (check-c*r-type-for list "dadd")
  (cdr (caddr list)))

(declaim (notinline cdaddr))

(declaim (inline cddaar))

(defun cddaar (list)
  (declare (inline cdr cdaar))
  (check-c*r-type-for list "ddaa")
  (cdr (cdaar list)))

(declaim (notinline cddaar))

(declaim (inline cddadr))

(defun cddadr (list)
  (declare (inline cdr cdadr))
  (check-c*r-type-for list "ddad")
  (cdr (cdadr list)))

(declaim (notinline cddadr))

(declaim (inline cdddar))

(defun cdddar (list)
  (declare (inline cdr cddar))
  (check-c*r-type-for list "ddda")
  (cdr (cddar list)))

(declaim (notinline cdddar))

(declaim (inline cddddr))

(defun cddddr (list)
  (declare (inline cdr cdddr))
  (check-c*r-type-for list "dddd")
  (cdr (cdddr list)))

(declaim (notinline cddddr))

(declaim (inline first))

(defun first (list)
  (declare (inline car))
  (check-c*r-type-for list "a")
  (car list))

(declaim (notinline first))

(declaim (inline second))

(defun second (list)
  (declare (inline cadr))
  (check-c*r-type-for list "ad")
  (cadr list))

(declaim (notinline second))

(declaim (inline third))

(defun third (list)
  (declare (inline caddr))
  (check-c*r-type-for list "add")
  (caddr list))

(declaim (notinline third))

(declaim (inline fourth))

(defun fourth (list)
  (declare (inline cadddr))
  (check-c*r-type-for list "addd")
  (cadddr list))

(declaim (notinline fourth))

(declaim (inline fifth))

(defun fifth (list)
  (declare (inline car cddddr))
  (check-c*r-type-for list "adddd")
  (car (cddddr list)))

(declaim (notinline fifth))

(declaim (inline sixth))

(defun sixth (list)
  (declare (inline cadr cddddr))
  (check-c*r-type-for list "addddd")
  (cadr (cddddr list)))

(declaim (notinline sixth))

(declaim (inline seventh))

(defun seventh (list)
  (declare (inline caddr cddddr))
  (check-c*r-type-for list "adddddd")
  (caddr (cddddr list)))

(declaim (notinline seventh))

(declaim (inline eighth))

(defun eighth (list)
  (declare (inline cadddr cddddr))
  (check-c*r-type-for list "addddddd")
  (cadddr (cddddr list)))

(declaim (notinline eighth))

(declaim (inline ninth))

(defun ninth (list)
  (declare (inline car cddddr))
  (check-c*r-type-for list "adddddddd")
  (car (cddddr (cddddr list))))

(declaim (notinline ninth))

(declaim (inline tenth))

(defun tenth (list)
  (declare (inline cadr cddddr))
  (check-c*r-type-for list "addddddddd")
  (cadr (cddddr (cddddr list))))

(declaim (notinline tenth))

(eval-when (:compile-toplevel :load-toplevel :execute)
  (defun make-setf-c*r-type-descriptor (string index)
    (if (zerop index)
        'cons
        (let ((subtype (make-setf-c*r-type-descriptor string (1- index))))
          (ecase (char string index)
            (#\a `(cons ,subtype))
            (#\d `(cons t ,subtype)))))))

(defmacro check-setf-c*r-type-for (parameter string)
  `(check-type ,parameter
               ,(make-setf-c*r-type-descriptor string (1- (length string)))))

;; (defun (setf car) (new-value cons)
;;   (declare (inline rplaca))
;;   (check-setf-c*r-type-for cons "a")
;;   (rplaca cons new-value)
;;   new-value)

;; (defun (setf cdr) (new-value cons)
;;   (declare (inline rplaca))
;;   (check-setf-c*r-type-for cons "d")
;;   (rplacd cons new-value)
;;   new-value)

(defun (setf caar) (new-value cons)
  (declare (inline rplaca car ))
  (check-setf-c*r-type-for cons "aa")
  (rplaca (car cons) new-value)
  new-value)

(defun (setf cadr) (new-value cons)
  (declare (inline rplaca cdr))
  (check-setf-c*r-type-for cons "ad")
  (rplaca (cdr cons) new-value)
  new-value)

(defun (setf cdar) (new-value cons)
  (declare (inline rplacd car))
  (check-setf-c*r-type-for cons "da")
  (rplacd (car cons) new-value)
  new-value)

(defun (setf cddr) (new-value cons)
  (declare (inline rplacd cdr))
  (check-setf-c*r-type-for cons "dd")
  (rplacd (cdr cons) new-value)
  new-value)

(defun (setf caaar) (new-value cons)
  (declare (inline rplaca caar))
  (check-setf-c*r-type-for cons "aaa")
  (rplaca (caar cons) new-value)
  new-value)

(defun (setf caadr) (new-value cons)
  (declare (inline rplaca cadr))
  (check-setf-c*r-type-for cons "aad")
  (rplaca (cadr cons) new-value)
  new-value)

(defun (setf cadar) (new-value cons)
  (declare (inline rplaca cdar))
  (check-setf-c*r-type-for cons "ada")
  (rplaca (cdar cons) new-value)
  new-value)

(defun (setf caddr) (new-value cons)
  (declare (inline rplaca cddr))
  (check-setf-c*r-type-for cons "add")
  (rplaca (cddr cons) new-value)
  new-value)

(defun (setf cdaar) (new-value cons)
  (declare (inline rplacd caar))
  (check-setf-c*r-type-for cons "daa")
  (rplacd (caar cons) new-value)
  new-value)

(defun (setf cdadr) (new-value cons)
  (declare (inline rplacd cadr))
  (check-setf-c*r-type-for cons "dad")
  (rplacd (cadr cons) new-value)
  new-value)

(defun (setf cddar) (new-value cons)
  (declare (inline rplacd cdar))
  (check-setf-c*r-type-for cons "dda")
  (rplacd (cdar cons) new-value)
  new-value)

(defun (setf cdddr) (new-value cons)
  (declare (inline rplacd cddr))
  (check-setf-c*r-type-for cons "ddd")
  (rplacd (cddr cons) new-value)
  new-value)

(defun (setf caaaar) (new-value cons)
  (declare (inline rplaca caaar))
  (check-setf-c*r-type-for cons "aaaa")
  (rplaca (caaar cons) new-value)
  new-value)

(defun (setf caaadr) (new-value cons)
  (declare (inline rplaca caadr))
  (check-setf-c*r-type-for cons "aaad")
  (rplaca (caadr cons) new-value)
  new-value)

(defun (setf caadar) (new-value cons)
  (declare (inline rplaca cadar))
  (check-setf-c*r-type-for cons "aada")
  (rplaca (cadar cons) new-value)
  new-value)

(defun (setf caaddr) (new-value cons)
  (declare (inline rplaca caddr))
  (check-setf-c*r-type-for cons "aadd")
  (rplaca (caddr cons) new-value)
  new-value)

(defun (setf cadaar) (new-value cons)
  (declare (inline rplaca cdaar))
  (check-setf-c*r-type-for cons "adaa")
  (rplaca (cdaar cons) new-value)
  new-value)

(defun (setf cadadr) (new-value cons)
  (declare (inline rplaca cdadr))
  (check-setf-c*r-type-for cons "adad")
  (rplaca (cdadr cons) new-value)
  new-value)

(defun (setf caddar) (new-value cons)
  (declare (inline rplaca cddar))
  (check-setf-c*r-type-for cons "adda")
  (rplaca (cddar cons) new-value)
  new-value)

(defun (setf cadddr) (new-value cons)
  (declare (inline rplaca cdddr))
  (check-setf-c*r-type-for cons "addd")
  (rplaca (cdddr cons) new-value)
  new-value)

(defun (setf cdaaar) (new-value cons)
  (declare (inline rplacd caaar))
  (check-setf-c*r-type-for cons "daaa")
  (rplacd (caaar cons) new-value)
  new-value)

(defun (setf cdaadr) (new-value cons)
  (declare (inline rplacd caadr))
  (check-setf-c*r-type-for cons "daad")
  (rplacd (caadr cons) new-value)
  new-value)

(defun (setf cdadar) (new-value cons)
  (declare (inline rplacd cadar))
  (check-setf-c*r-type-for cons "dada")
  (rplacd (cadar cons) new-value)
  new-value)

(defun (setf cdaddr) (new-value cons)
  (declare (inline rplacd caddr))
  (check-setf-c*r-type-for cons "dadd")
  (rplacd (caddr cons) new-value)
  new-value)

(defun (setf cddaar) (new-value cons)
  (declare (inline rplacd cdaar))
  (check-setf-c*r-type-for cons "ddaa")
  (rplacd (cdaar cons) new-value)
  new-value)

(defun (setf cddadr) (new-value cons)
  (declare (inline rplacd cdadr))
  (check-setf-c*r-type-for cons "ddad")
  (rplacd (cdadr cons) new-value)
  new-value)

(defun (setf cdddar) (new-value cons)
  (declare (inline rplacd cddar))
  (check-setf-c*r-type-for cons "ddda")
  (rplacd (cddar cons) new-value)
  new-value)

(defun (setf cddddr) (new-value cons)
  (declare (inline rplacd cdddr))
  (check-setf-c*r-type-for cons "dddd")
  (rplacd (cdddr cons) new-value)
  new-value)

(defun (setf first) (new-value cons)
  (declare (inline rplaca cdr))
  (check-setf-c*r-type-for cons "a")
  (rplaca (cdr cons) new-value)
  new-value)

(defun (setf second) (new-value cons)
  (declare (inline rplaca cdr))
  (check-setf-c*r-type-for cons "ad")
  (rplaca (cdr cons) new-value)
  new-value)

(defun (setf third) (new-value cons)
  (declare (inline rplaca cddr))
  (check-setf-c*r-type-for cons "add")
  (rplaca (cddr cons) new-value)
  new-value)

(defun (setf fourth) (new-value cons)
  (declare (inline rplaca cdddr))
  (check-setf-c*r-type-for cons "addd")
  (rplaca (cdddr cons) new-value)
  new-value)

(defun (setf fifth) (new-value cons)
  (declare (inline rplaca cddddr))
  (check-setf-c*r-type-for cons "adddd")
  (rplaca (cddddr cons) new-value)
  new-value)

(defun (setf sixth) (new-value cons)
  (declare (inline rplaca cdr cddddr))
  (check-setf-c*r-type-for cons "addddd")
  (rplaca (cdr (cddddr cons)) new-value)
  new-value)

(defun (setf seventh) (new-value cons)
  (declare (inline rplaca cddr cddddr))
  (check-setf-c*r-type-for cons "adddddd")
  (rplaca (cddr (cddddr cons)) new-value)
  new-value)

(defun (setf eighth) (new-value cons)
  (declare (inline rplaca cdddr cddddr))
  (check-setf-c*r-type-for cons "addddddd")
  (rplaca (cdddr (cddddr cons)) new-value)
  new-value)

(defun (setf ninth) (new-value cons)
  (declare (inline rplaca cddddr))
  (check-setf-c*r-type-for cons "adddddddd")
  (rplaca (cddddr (cddddr cons)) new-value)
  new-value)

(defun (setf tenth) (new-value cons)
  (declare (inline rplaca cdr cddddr))
  (check-setf-c*r-type-for cons "addddddddd")
  (rplaca (cdr (cddddr (cddddr cons))) new-value)
  new-value)
