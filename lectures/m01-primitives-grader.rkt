#lang racket

(require spd-grader/grader)
(require racket/function)

(provide grader)

(define grader
  (lambda ()
    (grade-submission
      (weights (1 0)
        (grade-problem 1
          (let* ([sexps (problem-sexps (car (context)))]
                 [corr? (and (= (length sexps) 1)
                             (member (car sexps) '((sqrt (+ (sqr 3)    (sqr 4)))
                                                   (sqrt (+ (* 3 3)    (* 4 4)))
                                                   (sqrt (+ (expt 3 2) (expt 4 2))))))])
            (rubric-item 'signature 1
                         corr?
                         "Expression that clearly computes  sqrt ( 3^2 + 4^2 )")))
        (grade-problem 2
          (score-it 'signature 1 1 #f
                    "The autograder can't grade this problem."))))))
