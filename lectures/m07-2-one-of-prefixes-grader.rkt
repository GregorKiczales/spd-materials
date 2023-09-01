#lang racket

(require spd-grader/grader
         spd-grader/walker)

(provide grader)

(define grader
  (lambda ()
    (grade-submission
      (define (%%prefix=? lst1 lst2)
        (cond [(empty? lst1) true]
              [(empty? lst2) false]
              [else                  
               (and (string=? (first lst1) (first lst2))
                    (%%prefix=? (rest lst1) (rest lst2)))]))
      
      (grade-problem 1
        (grade-htdf prefix=?
          (let* ([htdf  (car (context))]
                 [defn (car (htdf-defns htdf))]
                 [params (cdadr defn)]
                 [l1 (car  params)]
                 [l2 (cadr params)]
                 [body (caddr defn)]
                 [cond-expr (and (pair? body) (eqv? (car body) 'cond) body)]
                 [questions (and cond-expr (map car  (cdr cond-expr)))]
                 [answers   (and cond-expr (map cadr (cdr cond-expr)))]
                 [legal
                  `((empty? ,l1)
                    (empty? ,l2)
                    else)])

            (weights (.05   .1 .1 .05   .1 *)

              (grade-signature (LOS LOS -> Boolean))

              (grade-tests-validity (los1 los2) r
                (and (list? los1) (andmap string? los1))
                (and (list? los2) (andmap string? los2))
                (equal? r (%%prefix=? los1 los2)))
               
              (grade-tests-argument-thoroughness (los1 los2)
                (and (empty? los1) (empty? los2))
                (and (not (empty? los1)) (empty? los2))
                (and (not (empty? los2)) (empty? los1))
                (and (not (empty? los2)) (not (empty? los1))
                     (local [(define (prefix=? lst1 lst2)
                               (cond [(empty? lst1) true]
                                     [(empty? lst2) false]
                                     [else                  
                                      (and (string=? (first lst1) (first lst2))
                                           (prefix=? (rest lst1) (rest lst2)))]))]
                       (prefix=? los1 los2)))
                (and (not (empty? los2)) (not (empty? los1))
                     (local [(define (prefix=? lst1 lst2)
                               (cond [(empty? lst1) true]
                                     [(empty? lst2) false]
                                     [else                  
                                      (and (string=? (first lst1) (first lst2))
                                           (prefix=? (rest lst1) (rest lst2)))]))]
                       (not (prefix=? los1 los2)))))

              (grade-thoroughness-by-faulty-functions 1
                (define (prefix=? los1 los2)
                  (local [(define (prefix=? lst1 lst2)
                            (cond [(empty? lst1) true]
                                  [(empty? lst2) true]
                                  [else                  
                                   (and (string=? (first lst1) (first lst2))
                                        (prefix=? (rest lst1) (rest lst2)))]))]
                    (prefix=? los1 los2)))
                (define (prefix=? los1 los2)
                  (local [(define (prefix=? lst1 lst2)
                            (cond [(empty? lst1) false]
                                  [(empty? lst2) false]
                                  [else                  
                                   (and (string=? (first lst1) (first lst2))
                                        (prefix=? (rest lst1) (rest lst2)))]))]
                    (prefix=? los1 los2)))
                (define (prefix=? los1 los2)
                  (local [(define (prefix=? lst1 lst2)
                            (cond [(empty? lst1) true]
                                  [(empty? lst2) false]
                                  [else                  
                                   (or (string=? (first lst1) (first lst2))
                                       (prefix=? (rest lst1) (rest lst2)))]))]
                    (prefix=? los1 los2)))
                (define (prefix=? los1 los2)
                  (local [(define (prefix=? lst1 lst2)
                            (cond [(empty? lst1) true]
                                  [(empty? lst2) false]
                                  [else (string=? (first lst1) (first lst2))]))]
                    (prefix=? los1 los2)))
                (define (prefix=? los1 los2)
                  (local [(define (prefix=? lst1 lst2)
                            (cond [(empty? lst1) true]
                                  [(empty? lst2) false]
                                  [else (prefix=? (rest lst1) (rest lst2))]))]
                    (prefix=? los1 los2))))
               
              (grade-template-origin (2-one-of))
              
              (grade-prerequisite template
                                  "must have function body with cond expression"
                                  cond-expr
                (weights (.6 .1 *)
                  (weights (*)                
                    (rubric-item 'template (= (length questions) 3) "reduced to 3 cond question/answer pairs")                    
                    (rubric-item 'template (andmap not-and? questions) "no questions use and")
                    (rubric-item 'template (andmap (curryr member legal) questions)
                                 "each cond question must be one of ~a" legal)
                    (rubric-item 'template (andmap (compose not (curryr member legal)) answers)
                                 "cond answers must not contain any of ~a" legal))
                  
                  (grade-submitted-tests 1)
                  
                  (grade-additional-tests 1
                    (check-expect (prefix=? empty empty) true)
                    (check-expect (prefix=? empty (list "b" "c")) true)
                    (check-expect (prefix=? (list "b" "c") empty) false)
                    (check-expect (prefix=? (list "a" "b") (list "a" "b" "c")) true)
                    (check-expect (prefix=? (list "a" "b") (list "b" "c")) false)
                    (check-expect (prefix=? (list "a" "b") (list "a" "b")) true)
                    (check-expect (prefix=? (list "a" "b") (list "a")) false)))))))))))

(define (and?     q) (and (pair? q) (eqv? (car q) 'and)))
(define (not-and? q) (not (and? q)))
