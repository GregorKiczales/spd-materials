#lang racket

(require spd-grader/grader)
(require spd-grader/walker)

(provide grader)

(define grader
  (lambda ()
    (grade-submission

      (weights (*)

        (grade-problem 1
          (score-max
           (grade-top-level-expression () (sqrt (+ (sqr 3)    (sqr 4))))
           (grade-top-level-expression () (sqrt (+ (* 3 3)    (* 4 4))))
           (grade-top-level-expression () (sqrt (+ (expt 3 2) (expt 4 2))))))
        
        (grade-problem 2
          (grade-top-level-expression ()
            (beside (rectangle 100 200 "solid" "red")
                    (rectangle 200 200 "solid" "white")
                    (rectangle 100 200 "solid" "red"))))))))
