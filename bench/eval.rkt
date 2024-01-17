#lang racket ;<------------
;;                         \
;; We are working in full Racket to create Tiny Student Language (TSL).
;; TSL is a simple subset of BSL.
;;
;; There are a few extra things we need to know about full Racket:
;;
;;   - car means first, cdr means rest. cadr, or car of cdr means
;;     second and so on.  Racket has first and second, but I'm using
;;     car/cdr on purpose to remind us that we are programming in Racket
;;
;;   - this is a "string"
;;     this is a symbol
;;
;;   - putting ' in front of program text tells Racket not to evaluate
;;     it, so:
;;       'foo     evaluates to foo
;;       '(a b c) evaluates to (a b c)
;;


;; Here are the "data definition" for TSL:
;;
;; value is  number
;;           #t
;;           #f
;;
;;
;; defn is   (define symbol value)                      ;value not expression!
;;           (define (symbol symbol ...) expr)           ;
;;
;; expr is   <number>
;;           #t
;;           #f
;;           <symbol>
;;           (if <expr> <expr> <expr>)
;;           (symbol <expr> ...)
;;

(define (run defns expr)
  (local [;; First separate the definitions
          (define cdefns (filter (compose not list? cadr) defns))
          (define fdefns (filter (compose     list? cadr) defns))
          ;; Now 'de-sugar' into name and value. (lambda values are internal)
          ;;  constants is (list (<symbol> <value>) ...)
          ;;  functions is (list (<symbol> (lambda (<symbol>...) <expr>)) ...)
          (define constants (map cdr cdefns))
          (define functions
            (map (lambda (defn)
                   (list (caadr defn)                      ;fn name
                         (cons 'lambda
                               (cons (cdadr defn)          ;fn params
                                     (cddr defn)))))       ;(<body>)
                 fdefns))
                 
          ;; trampoline calls here
          ;; Expr -> Value
          ;; (@template Expr)
          (define (eval expr)
            (cond [(number?  expr) expr]
                  [(boolean? expr) expr]
                  [(symbol?  expr) (cadr (assoc expr constants))]
                  [(if?      expr) (eval-if expr)]
                  [(call?    expr)
                   (if (member (car expr) '(+ - * / =))
                       (apply-prim (car expr) (map eval (rest expr)))
                       (apply-fn   (car expr) (map eval (rest expr))))]))
          
          ;; Symbol (listof Value) -> Value
          (define (apply-prim name args)
            (case name
              [(+)     (+ (car  args) (cadr args))] ;TSL + uses Racket +
              [(-)     (- (car  args) (cadr args))] ;
              [(*)     (* (car  args) (cadr args))] ;
              [(/)     (/ (car  args) (cadr args))] ;
              [(=)     (= (car  args) (cadr args))] ;
              [(zero?) (zero? (car args))]))        ;

          ;; Symbol (listof Value) -> Value
          (define (apply-fn name args)
            (local [(define lmbda (cadr (assoc name functions)))]
              (eval (subst-args (cadr lmbda) args (caddr lmbda)))))

          ;; Expr -> Value
          (define (eval-if expr)
            (cond [(eval (cadr expr)) (eval (caddr expr))]
                  [else (eval (cadddr expr))]))
                   

          ;; (listof Symbol) (listof Value) Expr -> Expr
          ;; (@template Expr)
          (define (subst-args params args expr)
            (cond [(number?  expr) expr]
                  [(boolean? expr) expr]
                  [(symbol? expr)
                   (cadr (assoc expr (map list params args)))]
                  [(if? expr)
                   (list 'if 
                         (subst-args params args (cadr expr))
                         (subst-args params args (caddr expr))
                         (subst-args params args (cadddr expr)))]
                  [(call? expr)
                   (cons (first expr)
                         (map (lambda (operand)
                                (subst-args params args operand))
                              (rest expr)))]))
          ;; Any -> Boolean
          (define (if?   x) (and (list? x) (eqv? (car x) 'if)))
          (define (call? x) (and (list? x) (not (if? x))))]

    (eval expr)))


(require rackunit)

(check-equal? (run '() 1) 1)
(check-equal? (run '() #t) #t)
(check-equal? (run '() #f) #f)


(check-equal? (run '((define FOO 2)) 'FOO) 2)
(check-equal? (run '() '(+ 1 (- 4 3))) 2)

(check-equal? (run '() '(if #t 1 2)) 1)
(check-equal? (run '() '(if #f 1 2)) 2)

(check-equal? (run '((define (foo x) (+ x 1)))
                   '(foo 2))
              3)

(check-equal? (run '((define (foo x y z) (if x y z)))
                   '(foo #t 1 2))
              1)

(check-equal? (run '((define (foo x y z)  (if x y z)))
                   '(foo #f 1 2))
              2)

(check-equal? (run '((define (fact x)
                       (if (= x 0)
                           1
                           (* x (fact (- x 1))))))
                   '(fact 3))
              6)

              


