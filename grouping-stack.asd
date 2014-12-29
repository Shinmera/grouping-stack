#|
 This file is a part of grouping-stack
 (c) 2014 Shirakumo http://tymoon.eu (shinmera@tymoon.eu)
 Author: Nicolas Hafner <shinmera@tymoon.eu>
|#

(in-package #:cl-user)
(asdf:defsystem grouping-stack
  :name "grouping-stack"
  :version "0.0.1"
  :license "Artistic"
  :author "Nicolas Hafner <shinmera@tymoon.eu>"
  :maintainer "Nicolas Hafner <shinmera@tymoon.eu>"
  :description "A stack that groups past elements together."
  :homepage "https://github.com/Shinmera/SKEL"
  :serial T
  :components ((:file "package")
               (:file "item")
               (:file "balancer")
               (:file "stack"))
  :depends-on ())
