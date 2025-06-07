#lang racket

(require "iptables-runtime.rkt")

(provide (all-from-out "iptables-runtime.rkt")
         (rename-out [iptables-dsl #%module-begin]))

(define-syntax-rule (iptables-dsl . body)
  (module iptables-dsl racket
    (require "iptables-runtime.rkt")
    (iptables-program . body)))
