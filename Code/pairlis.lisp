(cl:in-package #:constrictor)

(declaim (inline pairlis))

(defun pairlis (keys data &optional (alist '()))
  (loop with result = alist
        for rest-keys = keys then (rest rest-keys)
        for rest-data = data then (rest rest-data)
        until (or (atom rest-keys) (atom rest-data))
        do (push (cons (first rest-keys) (first rest-data))
                 result)
        finally (format *trace-output*
                        "rest-keys: ~s rest-data: ~s~%"
                        rest-keys rest-data)
                (unless (listp rest-keys)
                  (error 'list-must-be-proper
                         :offending-list keys))
                (unless (listp rest-data)
                  (error 'list-must-be-proper
                         :offending-list data))
                (unless (and (null rest-keys) (null rest-data))
                  (error 'keys-and-data-must-have-the-same-length
                         :keys keys
                         :data data))
                (return result)))

(declaim (notinline pairlis))
