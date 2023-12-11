#lang racket

(require spd-grader/grader
         spd-grader/lifted-definitions)

(provide grader)

(define grader
  (lambda ()
    (grade-submission
      (grade-problem 1
        (grade-lifted-definitions

         (define (foo x y)
           (local [(define (bar x z)
                     (list x y z))
                   (define (baz x y)
                     (local [(define (bar z)
                               (list x y z))]
                       (* 2 x y)))]
             (bar x (baz x y))))

         (foo 1 2)

         (define (bar_0 x z)
           (list x 2 z))

         (define (baz_0 x y)
           (local [(define (bar z)
                     (list x y z))]
             (* 2 x y)))

         (define (bar_1 z)
           (list 1 2 z)))))))
