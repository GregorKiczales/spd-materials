#lang racket

(require spd-grader/grader
         spd-grader/check-template)

(provide grader)

(define grader
  (lambda ()
    (grade-submission

      (define (%%region? x)
        (local [(define (fn-for-region r)
                  (cond [(single? r)
                         (and (string? (single-label r))
                              (and (integer? (single-weight r)) (>= (single-weight r) 0))
                              (string? (single-color r)))]
                        [else
                         (and (string? (group-color r))
                              (fn-for-lor (group-subs r)))]))

                (define (fn-for-lor lor)
                  (cond [(empty? lor) true]
                        [else
                         (and (fn-for-region (first lor))
                              (fn-for-lor (rest lor)))]))]
          (and (or (single? x) (group? x))
               (fn-for-region x))))

      (define (%%find-region s r)
        (local [(define (fn-for--region r)
                  (cond [(single? r)
                         (if (string=? (single-label r) s)
                             r
                             false)]
                        [else 
                         (fn-for--lor (group-subs r))]))

                (define (fn-for--lor lor)
                  (cond [(empty? lor) false]
                        [else
                         (if (not (false? (fn-for--region (first lor))))
                             (fn-for--region (first lor))
                             (fn-for--lor (rest lor)))]))]
          (fn-for--region r)))
      
      (weights (*)
        (grade-problem 1
          (grade-htdf $F2
            (let ([$F2 (car (htdf-names (car (context))))])
              (weights (*)

                (grade-signature 1 (String Region       -> Region or false))
                (grade-signature 2 (String ListOfRegion -> Region or false))

                (grade-tests-validity (c reg) r
                  (string? c)
                  (%%region? reg)
                  (equal? r (%%find-region c reg)))
                
                (grade-tests-argument-thoroughness (c reg)
                  (single? reg)
                  (and (group? reg) (not (empty? (group-subs reg)))))
                
                (grade-thoroughness-by-faulty-functions 1
                  (define (,$F2 c r)
                    (local [(define (find-region--region l r)
                              (cond [(single? r) (if (string=? (single-label r) l) r false)]
                                    [(group?  r) false]))
                            (define (find-region--lor l lor)
                              (cond [(empty? lor) false]
                                    [else
                                     (if (not (false? (find-region--region l (first lor))))
                                         (find-region--region l (first lor))
                                         (find-region--lor l (rest lor)))]))]
                      (find-region--region c r)))
                  
                  (define (,$F2 c r)
                    (local [(define (find-region--region l r)
                              (cond [(single? r) r]
                                    [(group?  r) (find-region--lor l (group-subs r))]))
                            (define (find-region--lor l lor)
                              (cond [(empty? lor) false]
                                    [else
                                     (if (not (false? (find-region--region l (first lor))))
                                         (find-region--region l (first lor))
                                         (find-region--lor l (rest lor)))]))]
                      (find-region--region c r)))
                  
                  (define (,$F2 c r)
                    (local [(define (find-region--region l r)
                              (cond [(single? r) (if (string=? (single-label r) l) r false)]
                                    [(group?  r) (find-region--lor l (group-subs r))]))
                            (define (find-region--lor l lor)
                              (cond [(empty? lor) false]
                                    [else (find-region--region l (first lor))]))]
                      (find-region--region c r)))
                  
                  (define (,$F2 c r)
                    (local [(define (find-region--region l r)
                              (cond [(single? r) (if (string=? (single-label r) l) r false)]
                                    [(group?  r) (find-region--lor l (group-subs r))]))
                            (define (find-region--lor l lor)
                              (cond [(empty? lor) false]
                                    [else (find-region--lor l (rest lor))]))]
                      (find-region--region c r)))
                  
                  (define (,$F2 c r)
                    (local [(define (find-region--region l r)
                              (cond [(single? r) (if (string=? (single-label r) l) r false)]
                                    [(group?  r) (find-region--lor l (group-subs r))]))
                            (define (find-region--lor l lor)
                              (cond [(empty? lor) false]
                                    [else
                                     (if (false? (find-region--region l (first lor)))
                                         (find-region--region l (first lor))
                                         (find-region--lor l (rest lor)))]))]
                      (find-region--region c r))))
                
                (grade-template-origin 1 (Region))
                (grade-template-origin 2 (ListOfRegion try-catch))

                (grade-submitted-tests 1)
                (grade-submitted-tests 2)
                
                (grade-additional-tests 1
                  (check-expect (,$F2 "one" S1) S1)
                  (check-expect (,$F2 "one" S2) false)
                  (check-expect (,$F2 "three" G4) S3))))))))))
