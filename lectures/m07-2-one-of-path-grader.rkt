#lang racket

(require spd-grader/grader
         spd-grader/2-one-of)

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
          (weights (.05   .15   .15 .05  .30  0 *)

            (grade-signature (BinaryTree Path -> Boolean))

            (grade-tests-validity (t p) r
              (or (false? t) (node? t))
              (and (list? p)
                   (local [(define (check e)
                             (or (equal? e "R") (equal? e "L")))]
                     (andmap check p)))
              (equal? r (%%has-path? t p)))
            
            (grade-argument-thoroughness
              (per-args (t p)
                (and (empty? p) (false? t))
                (and (not (empty? p)) (false? t))
                (and (node? t) (empty? p))
                (and (node? t) (> (length p) 1))
                (and (not (empty? p)) (node? t) (member "R" p))
                (and (not (empty? p)) (node? t) (member "L" p))))
            
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

            (grade-2-one-of 1 (bt p)
              (cond [(false? bt) false]                                           ;[1]
                    [(empty? p)  true]                                            ;[2]
                    [(string=? (first p) "L") (has-path? (node-l bt) (rest p))]   ;[3]
                    [else                     (has-path? (node-r bt) (rest p))])) ;[4]
               
            (grade-submitted-tests 1)
                   
            (grade-additional-tests 1
              (check-expect (has-path? false empty) false)
              (check-expect (has-path? false P2) false)
              (check-expect (has-path? BT4 empty) true)
              (check-expect (has-path? BT4 P2)    true)
              (check-expect (has-path? BT4 P3) true)
              (check-expect (has-path? BT4 P4) true)
              (check-expect (has-path? BT4 (list "L" "R" "L")) false))))))))

