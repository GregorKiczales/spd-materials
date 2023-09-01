#lang racket

(require spd-grader/grader
         spd-grader/walker)

(provide grader)

(define grader
  (lambda ()
    (grade-submission

      (define (%%has-path? bt p)
        (cond [(false? bt) false]
              [(empty? p)  true]  
              [(string=? (first p) "L") (%%has-path? (node-l bt) (rest p))]
              [else                     (%%has-path? (node-r bt) (rest p))]))

      (grade-problem 1
        (grade-htdf has-path?
          (let* ([htdf  (car (context))]
                 [defn (car (htdf-defns htdf))]
                 [params (cdadr defn)]
                 [bt (car params)]
                 [p  (cadr params)]
                 [body (caddr defn)]
                 [cond-expr (and (pair? body) (eqv? (car body) 'cond) body)]
                 [questions (and cond-expr (map car  (cdr cond-expr)))]
                 [answers   (and cond-expr (map cadr (cdr cond-expr)))]
                 [legal
                  `((false? ,bt)
                    (empty? ,p)
                    (string=? (first ,p) "L") (string=? "L" (first ,p))
                    (string=? (first ,p) "R") (string=? "R" (first ,p))
                    else)])

            (weights (.05   .1 .1 .05   .1 *)
               (grade-signature (BinaryTree Path -> Boolean))

               (grade-tests-validity (t p) r
                (or (false? t) (node? t))
                (and (list? p)
                     (local [(define (check e)
                               (or (equal? e "R") (equal? e "L")))]
                       (andmap check p)))
                (equal? r (%%has-path? t p)))
               (grade-tests-argument-thoroughness (t p)
                (and (empty? p) (false? t))
                (and (not (empty? p)) (false? t))
                (and (node? t) (empty? p))
                (and (node? t) (> (length p) 1))
                (and (not (empty? p)) (node? t) (member "R" p))
                (and (not (empty? p)) (node? t) (member "L" p)))
               (grade-thoroughness-by-faulty-functions 1
                (define (has-path? t p)
                  (local [(define (has-path? bt p)
                            (cond [(false? bt) true]
                                  [(empty? p)  true]  
                                  [(string=? (first p) "L") (has-path? (node-l bt) (rest p))]
                                  [else                     (has-path? (node-r bt) (rest p))]))]
                    (has-path? t p)))
                (define (has-path? t p)
                  (local [(define (has-path? bt p)
                            (cond [(false? bt) false]
                                  [(empty? p)  false]  
                                  [(string=? (first p) "L") (has-path? (node-l bt) (rest p))]
                                  [else                     (has-path? (node-r bt) (rest p))]))]
                    (has-path? t p)))
                (define (has-path? t p)
                  (local [(define (has-path? bt p)
                            (cond [(false? bt) false]
                                  [(empty? p)  true]  
                                  [(string=? (first p) "L") (has-path? (node-r bt) (rest p))]
                                  [else                     (has-path? (node-l bt) (rest p))]))]
                    (has-path? t p))))
               
               (grade-template-origin (2-one-of))

               (grade-prerequisite template
                                   "must have function body with cond expression"
                                   cond-expr
                 (weights (.6 .1 *)
                   (weights (*)
                     (rubric-item 'template (= (length questions) 4) "reduced to 4 cond question/answer pairs")
                     (rubric-item 'template (andmap not-and? questions) "no questions use and")
                     (rubric-item 'template (andmap (curryr member legal) questions)
                                  "each cond question must be one of ~a" legal)
                     (rubric-item 'template (andmap (compose not (curryr member legal)) answers)
                                  "cond answers must not contain any of ~a" legal))
                   
                   (grade-submitted-tests 1)
                   
                   (grade-additional-tests 1
                     (check-expect (has-path? false empty) false)
                     (check-expect (has-path? false P2) false)
                     (check-expect (has-path? BT4 empty) true)
                     (check-expect (has-path? BT4 P2)    true)
                     (check-expect (has-path? BT4 P3) true)
                     (check-expect (has-path? BT4 P4) true)
                     (check-expect (has-path? BT4 (list "L" "R" "L")) false)))))))))))


(define (and?     q) (and (pair? q) (eqv? (car q) 'and)))
(define (not-and? q) (not (and? q)))

