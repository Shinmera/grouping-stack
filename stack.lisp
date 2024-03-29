(in-package #:org.shirakumo.grouping-stack)

(defclass grouping-stack ()
  ((items :initform () :accessor stack-items)
   (count :initform 0 :accessor stack-count)
   (balancer :initarg :balancer :initform (error "BALANCER required.") :accessor stack-balancer)))

(defmethod initialize-instance :after ((stack grouping-stack) &key)
  (etypecase (stack-items stack) (list))
  (when (symbolp (stack-balancer stack))
    (setf (stack-balancer stack) (make-instance (stack-balancer stack))))
  (etypecase (stack-balancer stack) (balancer)))

(defmethod print-object ((stack grouping-stack) stream)
  (print-unreadable-object (stack stream :type T :identity T)
    (format stream "(~d:~d) ~a"
            (stack-size stack) (stack-count stack)
            (class-name (class-of (stack-balancer stack)))))
  stack)

(defgeneric balance (stack balancer)
  (:method ((stack grouping-stack) (balancer (eql T)))
    (balance stack (stack-balancer stack))))

(defun make-grouping-stack (balancer &key initial-contents)
  (let ((stack (make-instance 'grouping-stack :balancer balancer)))
    (setf (stack-items stack) (mapcar #'make-item initial-contents))
    (setf (stack-count stack) (length (stack-items stack)))
    (balance stack T)
    stack))

(defgeneric stack-push (content stack)
  (:method (content (stack grouping-stack))
    (push (make-instance 'item :content content)
          (stack-items stack))
    (incf (stack-count stack))
    (balance stack T)
    stack))

(defgeneric stack-push-many (contents stack)
  (:method ((contents list) (stack grouping-stack))
    (dolist (content contents)
      (push (make-instance 'item :content content)
            (stack-items stack))
      (incf (stack-count stack)))
    (balance stack T)
    stack))

(defgeneric stack-pop (stack)
  (:method ((stack grouping-stack))
    (prog1 (content (pop (stack-items stack)))
      (decf (stack-count stack))
      (balance stack T))))

(defgeneric stack-size (stack)
  (:method ((stack grouping-stack))
    (length (stack-items stack))))

(defgeneric stack-clear (stack)
  (:method ((stack grouping-stack))
    (setf (stack-items stack) ())
    (setf (stack-count stack) 0)
    stack))

(defgeneric map-stack (function stack)
  (:method ((function function) (stack grouping-stack))
    (loop for item in (stack-items stack)
          do (funcall function (content item)))
    stack))
