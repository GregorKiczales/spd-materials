#lang racket

(require spd-grader/grader spd-grader/check-steps)

(provide grader)


(define grader
  (lambda ()
    (grade-submission 
      (grade-problem 1
        (grade-problem-sexps "Lifted definitions"
                             ((define x_0 (* 3 3))
                              (define x_1 (* 3 2))))))))
