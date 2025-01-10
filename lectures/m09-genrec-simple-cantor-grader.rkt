#lang racket
(require spd-grader/grader)
(require spd-grader/walker)
(provide grader)

(define grader
  (lambda ()
    (grade-submission

      (define (%%cantor w)
        (cond [(<= w CUTOFF) (rectangle w BAR-HEIGHT "solid" BAR-COLOR)]
              [else
               (local [(define w/3 (/ w 3))
                       (define top (rectangle w BAR-HEIGHT "solid" BAR-COLOR))
                       (define gap (rectangle w GAP-HEIGHT "solid" SPACER-COLOR))
                       (define l&r (%%cantor w/3))
                       (define spc (rectangle w/3 BAR-HEIGHT "solid" SPACER-COLOR))]
                 (above top
                        gap
                        (beside l&r spc l&r)))]))

      (weights (*)
        (grade-problem 1
          (weights (*)
            (grade-htdf cantor
              (weights (*)
                (grade-signature (Number -> Image))

                (grade-tests-validity (n) r
                  (and (number? n) (>= n 0))
                  (equal? r (%%cantor n)))

                (grade-argument-thoroughness ()
                  (per-args (n)
                    (= 0 n)
                    (> n CUTOFF)
                    (= n CUTOFF)
                    (< n CUTOFF)))

                (grade-thoroughness-by-faulty-functions 1
                  (define (cantor w)
                    (cond [(<= w CUTOFF) empty-image]
                          [else
                           (local [(define w/3 (/ w 3))
                                   (define top (rectangle w BAR-HEIGHT "solid" BAR-COLOR))
                                   (define gap (rectangle w GAP-HEIGHT "solid" SPACER-COLOR))
                                   (define l&r (cantor (/ w 3)))
                                   (define spc (rectangle (/ w 3) BAR-HEIGHT "solid" SPACER-COLOR))]
                             (above top
                                    gap
                                    (beside l&r spc l&r)))]))
                  (define (cantor w)
                    (cond [(< w CUTOFF) (rectangle w BAR-HEIGHT "solid" BAR-COLOR)]
                          [else
                           (local [(define w/3 (/ w 3))
                                   (define top (rectangle w BAR-HEIGHT "solid" BAR-COLOR))
                                   (define gap (rectangle w GAP-HEIGHT "solid" SPACER-COLOR))
                                   (define l&r (cantor (/ w 3)))
                                   (define spc (rectangle (/ w 3) BAR-HEIGHT "solid" SPACER-COLOR))]
                             (above top
                                    gap
                                    (beside l&r spc l&r)))]))
                  (define (cantor w)
                    (cond [(<= w CUTOFF) (rectangle w BAR-HEIGHT "solid" BAR-COLOR)]
                          [else
                           (local [(define w/3 (/ w 3))
                                   (define top (rectangle w BAR-HEIGHT "solid" BAR-COLOR))
                                   (define gap (rectangle w GAP-HEIGHT "solid" SPACER-COLOR))
                                   (define l&r (cantor (/ w 3)))
                                   (define spc (rectangle (/ w 3) BAR-HEIGHT "solid" SPACER-COLOR))]
                             (above (beside l&r spc l&r)
                                    gap
                                    top))]))
                  (define (cantor w)
                    (cond [(<= w CUTOFF) (rectangle w BAR-HEIGHT "solid" BAR-COLOR)]
                          [else
                           (local [(define w/3 (/ w 3))
                                   (define top (rectangle w BAR-HEIGHT "solid" BAR-COLOR))
                                   (define gap (rectangle w GAP-HEIGHT "solid" SPACER-COLOR))
                                   (define l&r (cantor (/ w 3)))
                                   (define spc (rectangle (/ w 3) BAR-HEIGHT "solid" SPACER-COLOR))]
                             (beside top
                                     gap
                                     (beside l&r spc l&r)))]))
                  (define (cantor w)
                    (rectangle w BAR-HEIGHT "solid" BAR-COLOR)))

                (grade-template-origin (genrec))
                (grade-submitted-tests  1)
                (grade-additional-tests 1
                  (check-expect (cantor 0)
                                (rectangle 0             BAR-HEIGHT "solid" BAR-COLOR))
                  (check-expect (cantor (sub1 CUTOFF))
                                (rectangle (sub1 CUTOFF) BAR-HEIGHT "solid" BAR-COLOR))
                  (check-expect (cantor CUTOFF)
                                (rectangle CUTOFF        BAR-HEIGHT "solid" BAR-COLOR))

                  (check-expect (cantor (* 3 CUTOFF))
                                (above (rectangle (* 3 CUTOFF) BAR-HEIGHT "solid" BAR-COLOR)
                                       (rectangle (* 3 CUTOFF) GAP-HEIGHT "solid" SPACER-COLOR)
                                       (beside (cantor CUTOFF)
                                               (rectangle CUTOFF BAR-HEIGHT "solid" SPACER-COLOR)
                                               (cantor CUTOFF)))))))))))))

