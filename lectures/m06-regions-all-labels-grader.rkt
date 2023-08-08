#lang racket

(require spd-grader/grader)
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

      (define (%%all-labels r)
        (local [(define (fn-for--region r)
                  (cond [(single? r) (list (single-label r))]
                        [else
                         (fn-for--lor (group-subs r))]))

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
                  (single? reg)
                  (and (group? reg) (not (empty? (group-subs reg)))))

                (grade-thoroughness-by-faulty-functions 1

                  (define (,$F2 r)
                    (local [(define (all-labels--region-c r)
                              (cond [(single? r) (list (single-label r))]
                                    [(group?  r) (list (group-color r))]))
                            (define (all-labels--lor-c lor)
                              (cond [(empty? lor) empty]
                                    [else
                                     (append (all-labels--region-c (first lor))
                                             (all-labels--lor-c (rest lor)))]))]
                      (all-labels--region-c r)))

                  (define (,$F2 r)
                    (local [(define (all-labels--region-c r)
                              (cond [(single? r) empty]
                                    [(group?  r) (all-labels--lor-c (group-subs r))]))
                            (define (all-labels--lor-c lor)
                              (cond [(empty? lor) empty]
                                    [else
                                     (append (all-labels--region-c (first lor))
                                             (all-labels--lor-c (rest lor)))]))]
                      (all-labels--region-c r)))

                  (define (,$F2 r)
                    (local [(define (all-labels--region-c r)
                              (cond [(single? r) (list (single-label r))]
                                    [(group?  r) (all-labels--lor-c (group-subs r))]))
                            (define (all-labels--lor-c lor)
                              (cond [(empty? lor) empty]
                                    [else
                                     (append (all-labels--region-c (first lor)))]))]
                      (all-labels--region-c r)))

                  (define (,$F2 r)
                    (local [(define (all-labels--region-c r)
                              (cond [(single? r) (list (single-label r))]
                                    [(group?  r) (all-labels--lor-c (group-subs r))]))
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
                                                    
                  
