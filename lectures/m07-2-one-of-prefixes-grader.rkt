#lang racket

(require spd-grader/grader
         spd-grader/2-one-of)

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
          
          (weights (.05   .15   .15 .05  .30  0 *)

            (grade-signature (LOS LOS -> Boolean))

            (grade-tests-validity (los1 los2) r
              (and (list? los1) (andmap string? los1))
              (and (list? los2) (andmap string? los2))
              (equal? r (%%prefix=? los1 los2)))
            
            (grade-argument-thoroughness
              (per-args (los1 los2)
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
                       (not (prefix=? los1 los2))))))

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

              (grade-2-one-of 1 (lst1 lst2)
                (cond [(empty? lst1) true]   ;[1]    
                      [(empty? lst2) false]  ;[2]      
                      [else                  ;[3]  
                       (and (string=? (first lst1) (first lst2))
                            (prefix=? (rest lst1) (rest lst2)))]))
                  
              (grade-submitted-tests 1)
              
              (grade-additional-tests 1
                (check-expect (prefix=? empty empty) true)
                (check-expect (prefix=? empty (list "b" "c")) true)
                (check-expect (prefix=? (list "b" "c") empty) false)
                (check-expect (prefix=? (list "a" "b") (list "a" "b" "c")) true)
                (check-expect (prefix=? (list "a" "b") (list "b" "c")) false)
                (check-expect (prefix=? (list "a" "b") (list "a" "b")) true)
                (check-expect (prefix=? (list "a" "b") (list "a")) false))))))))
