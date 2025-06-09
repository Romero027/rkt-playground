#lang racket

(require "syscall-runtime.rkt")

(define policy
  (syscall-policy
    (allow 'write '(fd buf size)
      '(and (or (= fd 1) (= fd 2))
            (or (< size 4) (= buf 0))))
    (allow 'read '(fd buf size))
    (default kill)))

(module+ main
  (displayln "Compiled syscall policy:")
  (displayln policy))
