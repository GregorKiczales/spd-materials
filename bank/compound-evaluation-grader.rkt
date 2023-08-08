#lang racket

(require spd-grader/grader spd-grader/check-steps)

(provide grader)


(define grader
  (lambda ()
    (grade-submission 
      (grade-problem 1
        (grade-steps
            
          (define-struct census-data (city population))
            
          (define (add-newborn cd)
            (make-census-data (census-data-city cd)
                              (add1 (census-data-population cd))))
          
          (add-newborn (make-census-data "Vancouver" 603502)))))))
