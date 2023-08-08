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

      (define (%%all-with-color c r)
        (local [(define (fn-for--region r)
                  (cond [(single? r)
                         (if (string=? (single-color r) c)
                             (list r)
                             empty)]
                        [else
                         (if (string=? (group-color r) c)
                             (cons r (fn-for--lor (group-subs r)))
                             (fn-for--lor (group-subs r)))]))

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

                (grade-signature 1 (Color Region -> ListOfRegion))
                (grade-signature 2 (Color ListOfRegion -> ListOfRegion))

                (grade-tests-validity (c reg) r
                  (string? c)
                  (%%region? reg)
                  (equal? r (%%all-with-color c reg)))

                (grade-tests-argument-thoroughness (c reg)
                  (single? reg)
                  (and (group? reg)
                       (not (empty? (group-subs reg)))
                       (not (empty? (all-with-color--region c reg)))))
                
                (grade-thoroughness-by-faulty-functions 1

                  (define (,$F2 c reg)
                    (local [(define (all-with-color--region r)
                              (cond [(single? r) (list r)]
                                    [(group?  r) (if (string=? (group-color r) c)
                                                     (cons r (all-with-color--lor (group-subs r)))
                                                     (all-with-color--lor (group-subs r)))]))
                            (define (all-with-color--lor lor)
                              (cond [(empty? lor) empty]
                                    [else
                                     (append (all-with-color--region (first lor))
                                             (all-with-color--lor (rest lor)))]))]
                      (all-with-color--region reg)))

                  (define (,$F2 c reg)
                    (local [(define (all-with-color--region r)
                              (cond [(single? r) (if (string=? (single-color r) c) (list r) '())]
                                    [(group?  r) (cons r (all-with-color--lor (group-subs r)))]))
                            (define (all-with-color--lor lor)
                              (cond [(empty? lor) empty]
                                    [else
                                     (append (all-with-color--region (first lor))
                                             (all-with-color--lor (rest lor)))]))]
                      (all-with-color--region reg)))

                  (define (,$F2 c reg)
                    (local [(define (all-with-color--region r)
                              (cond [(single? r) (if (string=? (single-color r) c) (list r) '())]
                                    [(group?  r) (all-with-color--lor (group-subs r))]))
                            (define (all-with-color--lor lor)
                              (cond [(empty? lor) empty]
                                    [else
                                     (append (all-with-color--region (first lor))
                                             (all-with-color--lor (rest lor)))]))]
                      (all-with-color--region reg)))

                  (define (,$F2 c reg)
                    (local [(define (all-with-color--region r)
                              (cond [(single? r) (if (string=? (single-color r) c) (list r) '())]
                                    [(group?  r) (if (string=? (group-color r) c)
                                                     (cons r (all-with-color--lor (group-subs r)))
                                                     (all-with-color--lor (group-subs r)))]))
                            (define (all-with-color--lor lor)
                              (cond [(empty? lor) empty]
                                    [else
                                     (append (all-with-color--region (first lor))
                                             empty)]))]
                      (all-with-color--region reg))))
                
                (grade-template-origin 1 (Region))
                (grade-template-origin 2 (ListOfRegion))


                (grade-submitted-tests 1)
                (grade-submitted-tests 2)

                (grade-additional-tests 1
                  (check-expect (,$F2 "red" S1) (list S1))
                  (check-expect (,$F2 "blue" S1) '())
                  (check-expect
                   (,$F2 "red"
                         (make-group "blue"
                                     (list G4
                                           (make-single "X" 90 "red"))))
                   (list G1 S1 (make-single "X" 90 "red"))))))))))))
