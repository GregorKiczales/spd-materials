#lang racket

(require spd-grader/grader
         spd-grader/lifted-definitions)

(provide grader)


(define grader
  (lambda ()
    (grade-submission
     
      (grade-problem 1
        (grade-sexps "Value"
                     ((list 12 21))))
     
      (grade-problem 2
        (grade-sexps "Value" 
                     (3)))
     
      (grade-problem 3
        (grade-lifted-definitions
         
         (define (boo x lon)
           (local [(define (addx n) (+ n x))]
             (if (zero? x)
                 empty
                 (cons (addx (first lon))
                       (boo (sub1 x) (rest lon))))))
         (boo 2 (list 10 20))
         
         (define (addx_0 n) (+ n 2))
         (define (addx_1 n) (+ n 1))
         (define (addx_2 n) (+ n 0)))))))
