#lang racket

(require spd-grader/grader)
(require spd-grader/walker)

(provide grader)

(define grader
  (lambda ()
    (grade-submission

      (define %%P2-SOLUTION
        (beside (rectangle 100 200 "solid" "red")
                (rectangle 200 200 "solid" "white")
                (rectangle 100 200 "solid" "red")))

      (weights (*)
        (grade-problem 1
          (let* ([sexps (problem-sexps (car (context)))]
                 [corr? (and (= (length sexps) 1)
                             (member (car sexps) '((sqrt (+ (sqr 3)    (sqr 4)))
                                                   (sqrt (+ (* 3 3)    (* 4 4)))
                                                   (sqrt (+ (expt 3 2) (expt 4 2))))))])
            (rubric-item 'other
                         corr?
                         "Expression that clearly computes  sqrt ( 3^2 + 4^2 )")))
        (grade-problem 2
          (let* ([sexps  (problem-sexps (car (context)))]
                 [called (called-fn-names (car sexps))])
            (weights (*)
              (rubric-item 'template (member 'rectangle called) "Calls rectangle")
              (rubric-item 'template (= (length (filter (lambda (x) (eq? x 'rectangle)) called)) 3) "Calls rectangle 3 times")
              (rubric-item 'template (member 'beside called) "Calls beside")
              (rubric-item 'other (calling-evaluator #f `(equal? ,(car sexps) %%P2-SOLUTION)) "Produces correct image"))))))))
