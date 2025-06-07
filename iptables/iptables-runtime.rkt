#lang racket
(provide chain match default action iptables-program)

(define (chain name . rules)
  `(chain ,name ,@rules))

(define (match condition action)
  `(match ,condition ,action))

(define (default action)
  `(default ,action))

(define (action a)
  `(action ,a))

(define (iptables-program . chains)
  `(iptables ,@chains))
