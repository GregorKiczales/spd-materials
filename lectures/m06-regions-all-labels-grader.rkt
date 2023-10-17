#lang racket

(require spd-grader/grader)
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

      (define (%%all-labels r)
        (local [(define (fn-for--region r)
                  (cond [(leaf? r) (list (leaf-label r))]
                        [else
                         (fn-for--lor (inner-subs r))]))

                (define (fn-for--lor lor)
                  (cond [(empty? lor) empty]
                        [else
                         (append (fn-for--region (first lor))
                                 (fn-for--lor (rest lor)))]))]
          (fn-for--region r)))

      (weights (*)
        (grade-problem 1
          (grade-htdf $F2
            (let ([$F2 (car (htdf-names (car (context))))])
              (weights (*)

                (grade-signature 1 (Region -> ListOfString))
                (grade-signature 2 (ListOfRegion -> ListOfString))

                (grade-tests-validity (reg) r
                  (%%region? reg)
                  (equal? r (%%all-labels reg)))

                (grade-tests-argument-thoroughness (reg)
                  (leaf? reg)
                  (and (inner? reg) (not (empty? (inner-subs reg)))))

                (grade-thoroughness-by-faulty-functions 1

                  (define (,$F2 r)
                    (local [(define (all-labels--region-c r)
                              (cond [(leaf? r) (list (leaf-label r))]
                                    [(inner?  r) (list (inner-color r))]))
                            (define (all-labels--lor-c lor)
                              (cond [(empty? lor) empty]
                                    [else
                                     (append (all-labels--region-c (first lor))
                                             (all-labels--lor-c (rest lor)))]))]
                      (all-labels--region-c r)))

                  (define (,$F2 r)
                    (local [(define (all-labels--region-c r)
                              (cond [(leaf? r) empty]
                                    [(inner?  r) (all-labels--lor-c (inner-subs r))]))
                            (define (all-labels--lor-c lor)
                              (cond [(empty? lor) empty]
                                    [else
                                     (append (all-labels--region-c (first lor))
                                             (all-labels--lor-c (rest lor)))]))]
                      (all-labels--region-c r)))

                  (define (,$F2 r)
                    (local [(define (all-labels--region-c r)
                              (cond [(leaf? r) (list (leaf-label r))]
                                    [(inner?  r) (all-labels--lor-c (inner-subs r))]))
                            (define (all-labels--lor-c lor)
                              (cond [(empty? lor) empty]
                                    [else
                                     (append (all-labels--region-c (first lor)))]))]
                      (all-labels--region-c r)))

                  (define (,$F2 r)
                    (local [(define (all-labels--region-c r)
                              (cond [(leaf? r) (list (leaf-label r))]
                                    [(inner?  r) (all-labels--lor-c (inner-subs r))]))
                            (define (all-labels--lor-c lor)
                              empty)]
                      (all-labels--region-c r))))

                (grade-template-origin 1 (Region))
                (grade-template-origin 2 (ListOfRegion))
                
                (grade-submitted-tests 1)
                (grade-submitted-tests 2)

                (grade-additional-tests 1
                  (check-expect (,$F2 S1) (list "one"))
                  (check-expect (,$F2 G4)
                                (list "one" "two" "three"
                                      "four" "five" "six")))))))))))
                                                    
                  
