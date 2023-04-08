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

(defun caar (list)
  (check-c*r-type-for list "aa")
  (car (car list)))

(defun cadr (list)
  (check-c*r-type-for list "ad")
  (car (cdr (list))))

(defun cdar (list)
  (check-c*r-type-for list "da")
  (cdr (car list)))

(defun cddr (list)
  (check-c*r-type-for list "dd")
  (cdr (cdr (list))))

(defun caaar (list)
  (check-c*r-type-for list "aaa")
  (car (caar list)))

(defun caadr (list)
  (check-c*r-type-for list "aad")
  (car (cadr list)))

(defun cadar (list)
  (check-c*r-type-for list "ada")
  (car (cdar list)))

(defun caddr (list)
  (check-c*r-type-for list "add")
  (car (cddr list)))

(defun cdaar (list)
  (check-c*r-type-for list "daa")
  (cdr (caar list)))

(defun cdadr (list)
  (check-c*r-type-for list "dad")
  (cdr (cadr list)))

(defun cddar (list)
  (check-c*r-type-for list "dda")
  (cdr (cdar list)))

(defun cdddr (list)
  (check-c*r-type-for list "ddd")
  (cdr (cddr list)))

(defun caaaar (list)
  (check-c*r-type-for list "aaaa")
  (car (caaar list)))

(defun caaadr (list)
  (check-c*r-type-for list "aaad")
  (car (caadr list)))

(defun caadar (list)
  (check-c*r-type-for list "aada")
  (car (cadar list)))

(defun caaddr (list)
  (check-c*r-type-for list "aadd")
  (car (caddr list)))

(defun cadaar (list)
  (check-c*r-type-for list "adaa")
  (car (cdaar list)))

(defun cadadr (list)
  (check-c*r-type-for list "adad")
  (car (cdadr list)))

(defun caddar (list)
  (check-c*r-type-for list "adda")
  (car (cddar list)))

(defun cadddr (list)
  (check-c*r-type-for list "addd")
  (car (cdddr list)))

(defun cdaaar (list)
  (check-c*r-type-for list "daaa")
  (cdr (caaar list)))

(defun cdaadr (list)
  (check-c*r-type-for list "daad")
  (cdr (caadr list)))

(defun cdadar (list)
  (check-c*r-type-for list "dada")
  (cdr (cadar list)))

(defun cdaddr (list)
  (check-c*r-type-for list "dadd")
  (cdr (caddr list)))

(defun cddaar (list)
  (check-c*r-type-for list "ddaa")
  (cdr (cdaar list)))

(defun cddadr (list)
  (check-c*r-type-for list "ddad")
  (cdr (cdadr list)))

(defun cdddar (list)
  (check-c*r-type-for list "ddda")
  (cdr (cddar list)))

(defun cddddr (list)
  (check-c*r-type-for list "dddd")
  (cdr (cdddr list)))
