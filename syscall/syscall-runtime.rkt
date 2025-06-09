#lang racket

;; Export the main functions that make up our syscall policy DSL
(provide syscall-policy allow default kill)

;; Define the top-level policy structure containing all rules
;; Example: (syscall-policy (allow "read" '()) (default kill))
(define (syscall-policy . rules)
  `(policy ,@rules))

;; Define an allow rule for a specific syscall with optional arguments and condition
;; Examples:
;;   (allow "read" '())                    ; Allow read syscall with no args
;;   (allow "write" '(fd) (fd > 2))        ; Allow write syscall with fd arg and condition
(define (allow syscall args [condition #f])
  (if condition
      `(allow ,syscall ,args ,condition)
      `(allow ,syscall ,args)))

;; Define a default action when no rules match
;; Example: (default kill)
(define (default action)
  `(default ,action))

;; Define the kill action for terminating processes
;; Used as: (default kill)
(define kill 'kill)
