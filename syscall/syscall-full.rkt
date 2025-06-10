#lang racket

;; === Syntax Definitions ===

(struct allow% (name args cond) #:transparent)
(struct default% (action) #:transparent)
(struct syscall-policy% (rules default) #:transparent)

(define-syntax-rule (syscall-policy . rules)
  (syscall-policy%
   (filter allow%? (list . rules))
   (for/or ([r (in-list (list . rules))])
     (if (default%? r) (default%-action r) #f))))

;; Modified to properly handle variable bindings in conditions
(define-syntax (allow stx)
  (syntax-case stx ()
    [(_ name (args ...) condition)
     #'(allow% 'name '(args ...) (lambda (args ...) condition))]))

(define-syntax-rule (default action)
  (default% 'action))

;; === Semantics (Evaluator) ===

;; A fake environment to bind argument names to values
(define (bind-args args vals)
  (for/hash ([a args] [v vals])
    (values a v)))

;; Modified to properly evaluate conditions with bound variables
(define (eval-cond cond-fn args)
  (apply cond-fn args))

(define (eval-policy policy syscall-name syscall-args)
  (define matching-rule
    (for/first ([r (in-list (syscall-policy%-rules policy))]
                #:when (eq? (allow%-name r) syscall-name))
      r))
  (cond
    [matching-rule
     (if (eval-cond (allow%-cond matching-rule) syscall-args)
         'allow
         (syscall-policy%-default policy))]
    [else (syscall-policy%-default policy)]))

;; === Example Usage ===

(define policy
  (syscall-policy
    (allow write (fd buf size)
      (and (or (= fd 1) (= fd 2))
           (or (< size 4) (= buf 0))))
    (allow read (fd buf size)
      #t)
    (default kill)))

;; Try a few test cases
(displayln (eval-policy policy 'write '(1 0 2))) ; allow
(displayln (eval-policy policy 'write '(3 0 2))) ; kill
(displayln (eval-policy policy 'read '(0 1 10))) ; allow
(displayln (eval-policy policy 'open '(0 1 10))) ; kill
