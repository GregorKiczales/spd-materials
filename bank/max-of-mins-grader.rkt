#lang racket

(require spd-grader/grader
         spd-grader/use-bia-fn)

(provide grader)

(define grader
  (lambda ()
    (grade-submission
      (grade-problem 1
        (grade-use-bia-fn max-of-mins
          (@signature (listof (listof Natural)) -> Natural)

          [(1.0          (foldr _ (map (foldr _ _) _)))]
          
          #:supplied-tests
          (check-expect (max-of-mins (list (list 2))) 2)
          (check-expect (max-of-mins (list (list 3 2 6)
                                           (list 2 40 2 7)
                                           (list 30 20 10)))
                        10)
          
          #:additional-tests
          (check-expect (max-of-mins (list (list 2 3 6)
                                           (list 20 19 18 17)
                                           (list 3 30 10)
                                           (list 60 40 50)
                                           (list 99 90 10 70)))
                        40))))))
