#lang racket

(require spd-grader/grader
         spd-grader/lifted-definitions)

(provide grader)


(define grader
  (lambda ()
    (grade-submission 
      (grade-problem 1
        (grade-lifted-definitions
         
         (define (foo n)
           (local [(define x (* 2 n))]
             (if (even? x)
                 n
                 (+ n (foo (sub1 n))))))
         
         (foo 3)

         (define (bar_0 x) (* 2 3))
         
         (define (bar_1 x) (* 2 6)))))))



         
