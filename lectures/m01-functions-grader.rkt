#lang racket

(require spd-grader/grader)
(require spd-grader/check-steps)

(provide grader)

(define grader
  (lambda ()
    (grade-submission
      (grade-problem 1
        (rubric-item 'other
                     (calling-evaluator #f '(< (abs (- (area 3) (* 3.14 (sqr 3)))) .01))
                     "Evaluating (area 3) produces (* 3.14 (sqr 3))")
        (rubric-item 'other
                     (calling-evaluator #f '(< (abs (- (area 5) (* 3.14 (sqr 5)))) .01))
                     "Evaluating (area 5) produces (* 3.14 (sqr 5))"))
        
      (grade-problem 2
        (grade-steps
          (define (silly x)
            (* 2 (sqr x)))
          
          (silly (* 1 3)))))))
