(cl:in-package #:constrictor)

(defgeneric consp (object)
  (:method (object) nil)
  (:method ((object cons)) t))

(defgeneric atom (object)
  (:method (object) t)
  (:method ((object cons)) nil))

(defgeneric listp (object)
  (:method (object) nil)
  (:method ((object cons)) t)
  (:method ((object null)) t))
