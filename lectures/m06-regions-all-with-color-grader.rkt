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

      (define (%%all-with-color c r)
        (local [(define (fn-for--region r)
                  (cond [(leaf? r)
                         (if (string=? (leaf-color r) c)
                             (list r)
                             empty)]
                        [else
                         (if (string=? (inner-color r) c)
                             (cons r (fn-for--lor (inner-subs r)))
                             (fn-for--lor (inner-subs r)))]))

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
                  (leaf? reg)
                  (and (inner? reg)
                       (not (empty? (inner-subs reg)))
                       (not (empty? (all-with-color--region c reg)))))
                
                (grade-thoroughness-by-faulty-functions 1

                  (define (,$F2 c reg)
                    (local [(define (all-with-color--region r)
                              (cond [(leaf? r) (list r)]
                                    [(inner?  r) (if (string=? (inner-color r) c)
                                                     (cons r (all-with-color--lor (inner-subs r)))
                                                     (all-with-color--lor (inner-subs r)))]))
                            (define (all-with-color--lor lor)
                              (cond [(empty? lor) empty]
                                    [else
                                     (append (all-with-color--region (first lor))
                                             (all-with-color--lor (rest lor)))]))]
                      (all-with-color--region reg)))

                  (define (,$F2 c reg)
                    (local [(define (all-with-color--region r)
                              (cond [(leaf? r) (if (string=? (leaf-color r) c) (list r) '())]
                                    [(inner?  r) (cons r (all-with-color--lor (inner-subs r)))]))
                            (define (all-with-color--lor lor)
                              (cond [(empty? lor) empty]
                                    [else
                                     (append (all-with-color--region (first lor))
                                             (all-with-color--lor (rest lor)))]))]
                      (all-with-color--region reg)))

                  (define (,$F2 c reg)
                    (local [(define (all-with-color--region r)
                              (cond [(leaf? r) (if (string=? (leaf-color r) c) (list r) '())]
                                    [(inner?  r) (all-with-color--lor (inner-subs r))]))
                            (define (all-with-color--lor lor)
                              (cond [(empty? lor) empty]
                                    [else
                                     (append (all-with-color--region (first lor))
                                             (all-with-color--lor (rest lor)))]))]
                      (all-with-color--region reg)))

                  (define (,$F2 c reg)
                    (local [(define (all-with-color--region r)
                              (cond [(leaf? r) (if (string=? (leaf-color r) c) (list r) '())]
                                    [(inner?  r) (if (string=? (inner-color r) c)
                                                     (cons r (all-with-color--lor (inner-subs r)))
                                                     (all-with-color--lor (inner-subs r)))]))
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
                  (check-expect (,$F2 "red" L1) (list L1))
                  (check-expect (,$F2 "blue" L1) '())
                  (check-expect
                   (,$F2 "red"
                         (make-inner "blue"
                                     (list I4
                                           (make-leaf "X" 90 "red"))))
                   (list I1 L1 (make-leaf "X" 90 "red"))))))))))))
