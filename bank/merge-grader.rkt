#lang racket

(require spd-grader/grader
         spd-grader/2-one-of)

(provide grader)

(define grader
  (lambda ()
    (grade-submission
     (define (%%merge l1 l2)
       (cond [(empty? l1) l2] 
             [(empty? l2) l1] 
             [else            
              (if (< (first l1) (first l2))
                  (cons (first l1)
                        (%%merge (rest l1) l2))
                  (cons (first l2)
                        (%%merge l1 (rest l2))))]))

      (grade-problem 1
        (grade-htdf merge            
          (weights (.05   .15   .15 .05  .30  0 *)
                     
            (grade-signature (LON LON -> LON))

            (grade-tests-validity (lon1 lon2) r
              (and (list? lon1) (andmap number? lon1))
              (and (list? lon2) (andmap number? lon2))
              (equal? r (%%merge lon1 lon2)))
            (grade-argument-thoroughness
              (per-args (lon1 lon2)
                (and (empty? lon1) (empty? lon2))
                (and (not (empty? lon1)) (empty? lon2))
                (and (not (empty? lon2)) (empty? lon1))
                (and (not (empty? lon2)) (not (empty? lon1)))
                (>= (length lon1) 2)
                (>= (length lon2) 2)))
            (grade-thoroughness-by-faulty-functions 1
              (define (merge lon1 lon2)
                (local [(define (merge l1 l2)
                          (cond [(empty? l1) l2]
                                [(empty? l2) l1] 
                                [else            
                                 (if (= (first l1) (first l2))
                                     (cons (first l1)
                                           (merge (rest l1) l2))
                                     (cons (first l2)
                                           (merge l1 (rest l2))))]))]
                  (merge lon1 lon2)))
              (define (merge lon1 lon2)
                (local [(define (merge l1 l2)
                          (cond [(empty? l1) l2]
                                [(empty? l2) l1] 
                                [else            
                                 (if (> (first l1) (first l2))
                                     (cons (first l1)
                                           (merge (rest l1) l2))
                                     (cons (first l2)
                                           (merge l1 (rest l2))))]))]
                  (merge lon1 lon2)))
              (define (merge lon1 lon2)
                (local [(define (merge l1 l2)
                          (cond [(empty? l1) l2]
                                [(empty? l2) l1] 
                                [else            
                                 (cons (first l1)
                                       (merge (rest l1) l2))]))]
                  (merge lon1 lon2)))
              (define (merge lon1 lon2)
                (local [(define (merge l1 l2)
                          (cond [(empty? l1) l2]
                                [(empty? l2) l1] 
                                [else 
                                 (cons (first l2)
                                       (merge l1 (rest l2)))]))]
                  (merge lon1 lon2)))
              (define (merge lon1 lon2)
                (local [(define (merge l1 l2)
                          (cond [(empty? l1) empty]
                                [(empty? l2) empty] 
                                [else            
                                 (if (< (first l1) (first l2))
                                     (cons (first l1)
                                           (merge (rest l1) l2))
                                     (cons (first l2)
                                           (merge l1 (rest l2))))]))]
                  (merge lon1 lon2))))
            
            (grade-2-one-of 1 (l1 l2)
              (cond [(empty? l1) l2]               ;[1]
                    [(empty? l2) l1]               ;[2]
                    [else                          ;[3]
                     (if (< (first l1) (first l2))
                         (cons (first l1)
                               (merge (rest l1) l2))
                         (cons (first l2)        
                               (merge l1 (rest l2))))]))              
            
            (grade-submitted-tests 1)
            (grade-additional-tests 1
              (check-expect (merge empty empty) empty)
              (check-expect (merge empty (list 2 3 5)) (list 2 3 5))
              (check-expect (merge (list 1 4 6) empty) (list 1 4 6))
              (check-expect (merge (list 1 4 6) (list 2 3 5)) (list 1 2 3 4 5 6))
              (check-expect (merge (list 2 3 5) (list 1 4 6)) (list 1 2 3 4 5 6))
              (check-expect (merge (list 1 2 3) (list 4 5 6)) (list 1 2 3 4 5 6))
              (check-expect (merge (list 1 2 3) (list 1 2 3)) (list 1 1 2 2 3 3)))))))))
