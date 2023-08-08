#lang racket

(require spd-grader/grader)

(provide grader)


(define grader
  (lambda ()
    (grade-submission
     
      (grade-problem 1
        (grade-problem-sexps "Value"
                             ((list 12 21))))
     
      (grade-problem 2
        (grade-problem-sexps "Value" 
                             (3)))
     
      (grade-problem 3
        (grade-problem-sexps "Lifted definitions" 
                             ((define (addx_0 n) (+ n 2))
                              (define (addx_1 n) (+ n 1))
                              (define (addx_2 n) (+ n 0))))))))
