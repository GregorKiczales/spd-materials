#lang racket

(require spd-grader/grader)
(require spd-grader/check-steps)

(provide grader)

(define grader
  (lambda ()
    (grade-submission
      (grade-problem 1                       
        (rubric-item 'signature 1
                     (check '(< (abs (- (area 3) (* 3.14 (sqr 3)))) .1))
                     "Evaluating (area 3) produces (* 3.14 (sqr 3))")
        (rubric-item 'signature 1
                     (check '(< (abs (- (area 5) (* 3.14 (sqr 5)))) .1))
                     "Evaluating (area 5) produces (* 3.14 (sqr 5))"))
        
      (grade-problem 2
        (grade-steps
          (define (silly x)
            (* 2 (sqr x)))
          
          (silly (* 1 3)))))))

(define (check expr)
  (calling-evaluator #f expr))
