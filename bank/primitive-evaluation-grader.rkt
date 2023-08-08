#lang racket

(require spd-grader/grader spd-grader/check-steps)

(provide grader)


(define grader
  (lambda ()
    (grade-submission
      (weights (*)
 
        (grade-problem 1
          (grade-steps
            (+ (* 2 3) (/ 8 2))))

        (grade-problem 2 
         (grade-steps
           (* (string-length "foo") 2)))))))
