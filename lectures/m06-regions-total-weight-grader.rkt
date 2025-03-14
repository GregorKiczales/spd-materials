#lang racket
(require spd-grader/grader
         spd-grader/check-template)

(provide grader)

(define grader
  (lambda ()
    (grade-submission

      (define (%%region? x)
        (local [(define (fn-for-region r)
                  (cond [(leaf? r)
                         (and (string? (leaf-label r))
                              (and (integer? (leaf-weight r)) (>= (leaf-weight r) 0))
                              (string? (leaf-color r)))]
                        [else
                         (and (string? (inner-color r))
                              (fn-for-lor (inner-subs r)))]))

                (define (fn-for-lor lor)
                  (cond [(empty? lor) true]
                        [else
                         (and (fn-for-region (first lor))
                              (fn-for-lor (rest lor)))]))]
          (and (or (leaf? x) (inner? x))
               (fn-for-region x))))

      (define (%%total-weight r)
        (local [(define (fn-for--region r)
                  (cond [(leaf? r) (leaf-weight r)]
                        [else (fn-for--lor (inner-subs r))]))
                (define (fn-for--lor lor)
                  (cond [(empty? lor) 0]
                        [else
                         (+ (fn-for--region (first lor))
                            (fn-for--lor (rest lor)))]))]
          (fn-for--region r)))
      
      (weights (*)
        (grade-problem 1
          (grade-htdf $F2
            (let ([$F2 (car (htdf-names (car (context))))])
              (weights (*)

                (grade-signature 1 (Region -> Natural))
                (grade-signature 2 (ListOfRegion -> Natural))

                (grade-tests-validity (reg) r
                  (%%region? reg)
                  (equal? r (%%total-weight reg)))

                (grade-argument-thoroughness ()
                  (per-args (reg)
                    (leaf? reg)
                    (and (inner? reg) (not (empty? (inner-subs reg))))))

                (grade-thoroughness-by-faulty-functions 1
                  (define (,$F2 r)
                    (local [(define (total-weight--region r)
                              (cond [(leaf? r) (leaf-weight r)]
                                    [(inner?  r) (total-weight--lor (inner-subs r))]))
                            (define (total-weight--lor lor)
                              (cond [(empty? lor) 1]
                                    [else
                                     (+ (total-weight--region (first lor))
                                        (total-weight--lor (rest lor)))]))]
                      (total-weight--region r)))
                  (define (,$F2 r)
                    (local [(define (total-weight--region r)
                              (cond [(leaf? r) (leaf-weight r)]
                                    [(inner?  r) (total-weight--lor (inner-subs r))]))
                            (define (total-weight--lor lor)
                              (cond [(empty? lor) 0]
                                    [else (total-weight--region (first lor))]))]
                      (total-weight--region r)))
                  (define (,$F2 r)
                    (local [(define (total-weight--region r)
                              (cond [(leaf? r) (leaf-weight r)]
                                    [(inner?  r) 0]))]
                      (total-weight--region r)))
                  (define (,$F2 r)
                    (local [(define (total-weight--region r)
                              (cond [(leaf? r) (leaf-weight r)]
                                    [(inner?  r) (total-weight--lor (inner-subs r))]))
                            (define (total-weight--lor lor)
                              (cond [(empty? lor) 0]
                                    [else
                                     (* (total-weight--region (first lor))
                                        (total-weight--lor (rest lor)))]))]
                      (total-weight--region r))))

                (grade-template-origin 1 (Region))
                (grade-template-origin 2 (ListOfRegion))
                
                (grade-submitted-tests)
                (grade-submitted-tests)
                (grade-additional-tests 1
                  (check-expect (,$F2 L1) 20)
                  (check-expect (,$F2 L2) 40)
                  (check-expect (total-weight--region (make-inner "red" empty)) 0)
                  (check-expect (,$F2 I1) (+ 20 40 60))
                  (check-expect (,$F2 I4) (+ 20 40 60 30 50 80)))))))))))
