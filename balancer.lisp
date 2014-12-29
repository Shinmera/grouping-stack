#|
 This file is a part of grouping-stack
 (c) 2014 Shirakumo http://tymoon.eu (shinmera@tymoon.eu)
 Author: Nicolas Hafner <shinmera@tymoon.eu>
|#

(in-package #:org.shirakumo.grouping-stack)

(defclass balancer ()
  ())

(defgeneric balance (stack balancer))

(defclass inactive-balancer (balancer)
  ())

(defmethod balance ((stack grouping-stack) (balancer inactive-balancer))
  (declare (ignore balancer))
  stack)

(defclass sink-balancer (balancer)
  ((buffer-size :initarg :buffer-size :initform 2 :accessor buffer-size)))

(defmethod balance ((stack grouping-stack) (balancer sink-balancer))
  (let ((items (nthcdr (buffer-size balancer) (stack-items stack))))
    (unless (null (cdr items))
      (setf (car items) (make-instance 'item :content (apply #'group (mapcar #'content items)))
            (cdr items) NIL))))
