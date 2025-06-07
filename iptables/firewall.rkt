#lang racket

(require "iptables-runtime.rkt")

(define iptables
  (iptables-program
   (chain 'INPUT
     (match '(ip-src "10.0.0.1") (action 'DROP))
     (match '(tcp-dst 80)        (action 'ACCEPT))
     (default (action 'DROP)))
   (chain 'OUTPUT
     (match '(ip-dst "8.8.8.8") (action 'ACCEPT))
     (default (action 'DROP)))))

(module+ main
  (displayln "Compiled IR:")
  (displayln iptables))
