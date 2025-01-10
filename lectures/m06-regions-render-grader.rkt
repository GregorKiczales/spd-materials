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

      (define (%%render r)
        (local [(define (fn-for--region r)
                  (cond [(leaf? r)
                         (text (leaf-label r)
                               (leaf-weight r)
                               (leaf-color r))]
                        [else 
                         (border (inner-color r)
                                 (fn-for--lor (inner-subs r)))]))
                (define (fn-for--lor lor)
                  (cond [(empty? lor) empty-image]
                        [else
                         (beside (fn-for--region (first lor))
                                 (fn-for--lor (rest lor)))]))]
          (fn-for--region r)))
      
      (weights (*)
        (grade-problem 1
          (grade-htdf $F2
            (let ([$F2 (car (htdf-names (car (context))))])
              (weights (*)

                (grade-signature 1 (Region -> Image))
                (grade-signature 2 (ListOfRegion -> Image))

                (grade-tests-validity (reg) r
                  (%%region? reg)
                  (equal? r (%%render reg)))

                (grade-argument-thoroughness ()
                  (per-args (reg)
                    (leaf? reg)
                    (and (inner? reg) (not (empty? (inner-subs reg))))))
                
                (grade-thoroughness-by-faulty-functions 1
                  (define (,$F2 r)
                    (local [(define (render--region r)
                              (cond [(leaf? r)
                                     (text (leaf-label r)
                                           (leaf-weight r)
                                           (leaf-color r))]
                                    [else
                                     (border (inner-color r)
                                             empty-image)]))
                            (define (render--lor lor)
                              (cond [(empty? lor) empty-image]
                                    [else
                                     (beside (render--region (first lor))
                                             (render--lor (rest lor)))]))]
                      (render--region r)))
                  (define (,$F2 r)
                    (local [(define (render--region r)
                              (cond [(leaf? r)
                                     (text (leaf-label r)
                                           (leaf-weight r)
                                           (leaf-color r))]
                                    [else
                                     (border (inner-color r)
                                             (render--lor (inner-subs r)))]))
                            (define (render--lor lor)
                              (cond [(empty? lor) empty-image]
                                    [else (render--region (first lor))]))]
                      (render--region r)))
                  (define (,$F2 r)
                    (local [(define (render--region r)
                              (cond [(leaf? r)
                                     (text (leaf-label r)
                                           (leaf-weight r)
                                           (leaf-color r))]
                                    [else
                                     (border (inner-color r)
                                             (render--lor (inner-subs r)))]))
                            (define (render--lor lor)
                              (cond [(empty? lor) empty-image]
                                    [else (render--lor (rest lor))]))]
                      (render--region r))))

                (grade-template-origin 1 (Region))
                (grade-template-origin 2 (ListOfRegion))

                (grade-submitted-tests 1)
                (grade-submitted-tests 2)

                (grade-additional-tests 1
                  (check-expect (,$F2 L1) (text "one" 20 "red"))
                  (check-expect (,$F2 I1)
                                (local [(define (render--region r)
                                          (cond [(leaf? r)
                                                 (text (leaf-label r)
                                                       (leaf-weight r)
                                                       (leaf-color r))]
                                                [else
                                                 (border (inner-color r)
                                                         (render--lor (inner-subs r)))]))
                                        (define (render--lor lor)
                                          (cond [(empty? lor) empty-image]
                                                [else
                                                 (beside (render--region (first lor))
                                                         (render--lor (rest lor)))]))]
                                  (render--region I1))))))))))))
