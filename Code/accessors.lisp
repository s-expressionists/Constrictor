(cl:in-package #:constrictor)

(declaim (inline first))

(defun first (list)
  (declare (inline car))
  (car list))

(declaim (notinline first))

(declaim (inline second))

(defun second (list)
  (declare (inline cadr))
  (cadr list))

(declaim (notinline second))

(declaim (inline third))

(defun third (list)
  (declare (inline caddr))
  (caddr list))

(declaim (notinline third))

(declaim (inline fourth))

(defun fourth (list)
  (declare (inline cadddr))
  (cadddr list))

(declaim (notinline fourth))

(declaim (inline fifth))

(defun fifth (list)
  (declare (inline car cddddr))
  (car (cddddr list)))

(declaim (notinline fifth))

(declaim (inline sixth))

(defun sixth (list)
  (declare (inline cadr cddddr))
  (cadr (cddddr list)))

(declaim (notinline sixth))

(declaim (inline seventh))

(defun seventh (list)
  (declare (inline caddr cddddr))
  (caddr (cddddr list)))

(declaim (notinline seventh))

(declaim (inline eighth))

(defun eighth (list)
  (declare (inline cadddr cddddr))
  (cadddr (cddddr list)))

(declaim (notinline eighth))

(declaim (inline ninth))

(defun ninth (list)
  (declare (inline car cddddr))
  (car (cddddr (cddddr list))))

(declaim (notinline ninth))

(declaim (inline tenth))

(defun tenth (list)
  (declare (inline cadr cddddr))
  (cadr (cddddr (cddddr list))))

(declaim (notinline tenth))

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

(declaim (inline (setf cadr)))

(defun (setf cadr) (new-value cons)
  (declare (inline rplaca cdr))
  (rplaca (cdr cons) new-value)
  new-value)

(declaim (notinline (setf cadr)))

(declaim (inline (setf cdar)))

(defun (setf cdar) (new-value cons)
  (declare (inline rplacd car))
  (rplacd (car cons) new-value)
  new-value)

(declaim (notinline (setf cdar)))

(declaim (inline (setf cddr)))

(defun (setf cddr) (new-value cons)
  (declare (inline rplacd cdr))
  (rplacd (cdr cons) new-value)
  new-value)

(declaim (notinline (setf cddr)))

(declaim (inline (setf caaar)))

(defun (setf caaar) (new-value cons)
  (declare (inline rplaca caar))
  (rplaca (caar cons) new-value)
  new-value)

(declaim (notinline (setf caaar)))

(declaim (inline (setf caadr)))

(defun (setf caadr) (new-value cons)
  (declare (inline rplaca cadr))
  (rplaca (cadr cons) new-value)
  new-value)

(declaim (notinline (setf caadr)))

(declaim (inline (setf cadar)))

(defun (setf cadar) (new-value cons)
  (declare (inline rplaca cdar))
  (rplaca (cdar cons) new-value)
  new-value)

(declaim (notinline (setf cadar)))

(declaim (inline (setf caddr)))

(defun (setf caddr) (new-value cons)
  (declare (inline rplaca cddr))
  (rplaca (cddr cons) new-value)
  new-value)

(declaim (notinline (setf caddr)))

(declaim (inline (setf cdaar)))

(defun (setf cdaar) (new-value cons)
  (declare (inline rplacd caar))
  (rplacd (caar cons) new-value)
  new-value)

(declaim (notinline (setf cdaar)))

(declaim (inline (setf cdadr)))

(defun (setf cdadr) (new-value cons)
  (declare (inline rplacd cadr))
  (rplacd (cadr cons) new-value)
  new-value)

(declaim (notinline (setf cdadr)))

(declaim (inline (setf cddar)))

(defun (setf cddar) (new-value cons)
  (declare (inline rplacd cdar))
  (rplacd (cdar cons) new-value)
  new-value)

(declaim (notinline (setf cddar)))

(declaim (inline (setf cdddr)))

(defun (setf cdddr) (new-value cons)
  (declare (inline rplacd cddr))
  (rplacd (cddr cons) new-value)
  new-value)

(declaim (notinline (setf cdddr)))

(declaim (inline (setf caaaar)))

(defun (setf caaaar) (new-value cons)
  (declare (inline rplaca caaar))
  (rplaca (caaar cons) new-value)
  new-value)

(declaim (notinline (setf caaaar)))

(declaim (inline (setf caaadr)))

(defun (setf caaadr) (new-value cons)
  (declare (inline rplaca caadr))
  (rplaca (caadr cons) new-value)
  new-value)

(declaim (notinline (setf caaadr)))

(declaim (inline (setf caadar)))

(defun (setf caadar) (new-value cons)
  (declare (inline rplaca cadar))
  (rplaca (cadar cons) new-value)
  new-value)

(declaim (notinline (setf caadar)))

(declaim (inline (setf caaddr)))

(defun (setf caaddr) (new-value cons)
  (declare (inline rplaca caddr))
  (rplaca (caddr cons) new-value)
  new-value)

(declaim (notinline (setf caaddr)))

(declaim (inline (setf cadaar)))

(defun (setf cadaar) (new-value cons)
  (declare (inline rplaca cdaar))
  (rplaca (cdaar cons) new-value)
  new-value)

(declaim (notinline (setf cadaar)))

(declaim (inline (setf cadadr)))

(defun (setf cadadr) (new-value cons)
  (declare (inline rplaca cdadr))
  (rplaca (cdadr cons) new-value)
  new-value)

(declaim (notinline (setf cadadr)))

(declaim (inline (setf caddar)))

(defun (setf caddar) (new-value cons)
  (declare (inline rplaca cddar))
  (rplaca (cddar cons) new-value)
  new-value)

(declaim (notinline (setf caddar)))

(declaim (inline (setf cadddr)))

(defun (setf cadddr) (new-value cons)
  (declare (inline rplaca cdddr))
  (rplaca (cdddr cons) new-value)
  new-value)

(declaim (notinline (setf cadddr)))

(declaim (inline (setf cdaaar)))

(defun (setf cdaaar) (new-value cons)
  (declare (inline rplacd caaar))
  (rplacd (caaar cons) new-value)
  new-value)

(declaim (notinline (setf cdaaar)))

(declaim (inline (setf cdaadr)))

(defun (setf cdaadr) (new-value cons)
  (declare (inline rplacd caadr))
  (rplacd (caadr cons) new-value)
  new-value)

(declaim (notinline (setf cdaadr)))

(declaim (inline (setf cdadar)))

(defun (setf cdadar) (new-value cons)
  (declare (inline rplacd cadar))
  (rplacd (cadar cons) new-value)
  new-value)

(declaim (notinline (setf cdadar)))

(declaim (inline (setf cdaddr)))

(defun (setf cdaddr) (new-value cons)
  (declare (inline rplacd caddr))
  (rplacd (caddr cons) new-value)
  new-value)

(declaim (notinline (setf cdaddr)))

(declaim (inline (setf cddaar)))

(defun (setf cddaar) (new-value cons)
  (declare (inline rplacd cdaar))
  (rplacd (cdaar cons) new-value)
  new-value)

(declaim (notinline (setf cddaar)))

(declaim (inline (setf cddadr)))

(defun (setf cddadr) (new-value cons)
  (declare (inline rplacd cdadr))
  (rplacd (cdadr cons) new-value)
  new-value)

(declaim (notinline (setf cddadr)))

(declaim (inline (setf cdddar)))

(defun (setf cdddar) (new-value cons)
  (declare (inline rplacd cddar))
  (rplacd (cddar cons) new-value)
  new-value)

(declaim (notinline (setf cdddar)))

(declaim (inline (setf cddddr)))

(defun (setf cddddr) (new-value cons)
  (declare (inline rplacd cdddr))
  (rplacd (cdddr cons) new-value)
  new-value)

(declaim (notinline (setf cddddr)))

(declaim (inline (setf first)))

(defun (setf first) (new-value cons)
  (declare (inline rplaca cdr))
  (rplaca cons new-value)
  new-value)

(declaim (notinline (setf first)))

(declaim (inline (setf second)))

(defun (setf second) (new-value cons)
  (declare (inline rplaca cdr))
  (rplaca (cdr cons) new-value)
  new-value)

(declaim (notinline (setf second)))

(declaim (inline (setf third)))

(defun (setf third) (new-value cons)
  (declare (inline rplaca cddr))
  (rplaca (cddr cons) new-value)
  new-value)

(declaim (notinline (setf third)))

(declaim (inline (setf fourth)))

(defun (setf fourth) (new-value cons)
  (declare (inline rplaca cdddr))
  (rplaca (cdddr cons) new-value)
  new-value)

(declaim (notinline (setf fourth)))

(declaim (inline (setf fifth)))

(defun (setf fifth) (new-value cons)
  (declare (inline rplaca cddddr))
  (rplaca (cddddr cons) new-value)
  new-value)

(declaim (notinline (setf fifth)))

(declaim (inline (setf sixth)))

(defun (setf sixth) (new-value cons)
  (declare (inline rplaca cdr cddddr))
  (rplaca (cdr (cddddr cons)) new-value)
  new-value)

(declaim (notinline (setf sixth)))

(declaim (inline (setf seventh)))

(defun (setf seventh) (new-value cons)
  (declare (inline rplaca cddr cddddr))
  (rplaca (cddr (cddddr cons)) new-value)
  new-value)

(declaim (notinline (setf seventh)))

(declaim (inline (setf eighth)))

(defun (setf eighth) (new-value cons)
  (declare (inline rplaca cdddr cddddr))
  (rplaca (cdddr (cddddr cons)) new-value)
  new-value)

(declaim (notinline (setf eighth)))

(declaim (inline (setf ninth)))

(defun (setf ninth) (new-value cons)
  (declare (inline rplaca cddddr))
  (rplaca (cddddr (cddddr cons)) new-value)
  new-value)

(declaim (notinline (setf ninth)))

(declaim (inline (setf tenth)))

(defun (setf tenth) (new-value cons)
  (declare (inline rplaca cdr cddddr))
  (rplaca (cdr (cddddr (cddddr cons))) new-value)
  new-value)

(declaim (notinline (setf tenth)))

(defun split (string start)
  (cond ((eq start (length string))
         'list)
        ((eql (char string start) #\A)
         `(car ,(split string (1+ start))))
        (t
         `(cdr ,(split string (1+ start))))))

(defun car-or-cdr (string)
  (let ((position1 (position #\A string))
        (position2 (position #\D string)))
    (cond ((null position1)
           "CDR")
          ((null position2)
           "CAR")
          (t
           "CAR or CDR"))))

(defun c*r-documentation (symbol)
  (let* ((name (symbol-name symbol))
         (string (subseq name 1 (1- (length name)))))
    (setf (documentation symbol 'function)
          (format nil
                  "Syntax: c~ar list~@
                   ~@
                   (C~aR LIST) is equivalent to ~s."
                  (string-downcase string)
                  string
                  (split string 0)))))

(defun setf-c*r-documentation (symbol)
  (let* ((name (symbol-name symbol))
         (string (subseq name 1 (1- (length name)))))
    (setf (documentation `(setf ,symbol) 'function)
          (format nil
                  "Syntax: (setf (c~ar list) object)~@
                   ~@
                   (SETF (C~aR LIST) OBJECT) is equivalent to~@
                   (SETF ~s OBJECT)."
                  (string-downcase string)
                  string
                  (split string 0)))))

(loop for symbol in
      '(caar cadr cdar cddr
        caaar caadr cadar caddr cdaar cdadr cddar cdddr
        caaaar caaadr caadar caaddr cadaar cadadr caddar cadddr
        cdaaar cdaadr cdadar cdaddr cddaar cddadr cdddar cddddr)
      do (c*r-documentation symbol)
         (setf-c*r-documentation symbol))

(defun integer-to-cl-symbol (integer)
  (find-symbol (string-upcase (format nil "~:R" integer))
               (find-package "CONSTRICTOR")))

(defun set-first-to-tenth-documentation (n)
  (setf (documentation (integer-to-cl-symbol n) 'function)
        (format nil
                "Syntax: ~a list~@
                 ~@
                 This function returns the same value as:~@
                 (NTH ~a LIST)"
                (format nil "~:R" n)
                (1- n)))
  (setf (documentation `(setf ,(integer-to-cl-symbol n)) 'function)
        (format nil
                "Syntax: (setf (~a list) new-object)~@
                 ~@
                 This function has the same effect and returns~@
                 the same value as:~@
                 (SETF (NTH ~a LIST) NEW-OBJECT)"
                (format nil "~:R" n)
                (1- n))))

(loop for i from 1 to 10
      do (set-first-to-tenth-documentation i))
