#|
 This file is a part of grouping-stack
 (c) 2014 Shirakumo http://tymoon.eu (shinmera@tymoon.eu)
 Author: Nicolas Hafner <shinmera@tymoon.eu>
|#

(in-package #:cl-user)
(defpackage #:grouping-stack
  (:nicknames #:org.shirakumo.grouping-stack)
  (:use #:cl)
  ;; balancer.lisp
  (:export
   #:balancer
   #:balance
   #:inactive-balancer
   #:sink-balancer
   #:buffer-size)
  ;; item.lisp
  (:export
   #:combinable-p
   #:combine
   #:item
   #:content
   #:make-item
   #:group
   #:items)
  ;; stack.lisp
  (:export
   #:grouping-stack
   #:stack-items
   #:stack-count
   #:stack-balancer
   #:make-grouping-stack
   #:stack-push
   #:stack-push-many
   #:stack-pop
   #:stack-size
   #:stack-clear
   #:map-stack))
