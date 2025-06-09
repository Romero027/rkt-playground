#lang racket

;; Export all the functions that make up our DSL's syntax
(provide chain match default action iptables-program)

;; Define a chain with a name and a list of rules
;; Example: (chain INPUT (match (ip-src "10.0.0.1") (action DROP)))
(define (chain name . rules)
  `(chain ,name ,@rules))

;; Define a matching rule with a condition and an action
;; Example: (match (ip-src "10.0.0.1") (action DROP))
(define (match condition action)
  `(match ,condition ,action))

;; Define a default action for a chain when no rules match
;; Example: (default (action DROP))
(define (default action)
  `(default ,action))

;; Define an action to take (ACCEPT, DROP, etc.)
;; Example: (action DROP)
(define (action a)
  `(action ,a))

;; Define the top-level program structure containing all chains
;; Example: (iptables-program (chain INPUT ...) (chain OUTPUT ...))
(define (iptables-program . chains)
  `(iptables ,@chains))
