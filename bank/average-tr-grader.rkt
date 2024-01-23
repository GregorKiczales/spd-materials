#lang racket

(require spd-grader/grader
         spd-grader/templates
         spd-grader/walker)

(provide grader)


(define grader
  (lambda ()
    (grade-submission

      (define (%%average lon)
        (local[(define (average lon cnt sum)
                 (cond [(empty? lon) (/ sum cnt)]
                       [else
                        (average (rest lon) (add1 cnt)
                                 (+ (first lon) sum))]))]
          (average lon 0 0)))
      
      (grade-problem 1
        (grade-htdf average
          (grade-prerequisite 'other "does not call length" (calls-none? average '(length))
            (weights+
              
              [.05 (grade-signature ((listof Number) -> Number))]
              
              [.20 (grade-tests-validity (lon) r
                     (list? lon)
                     (> (length lon) 0)
                     (andmap number? lon)
                     (equal? r (%%average lon)))]
              
              [.25 (grade-argument-thoroughness ()
                                                (per-args (lon)
                                                  (= (length lon) 1)
                                                  (> (length lon) 1)))]
              
              [.10 (grade-template-origin ((listof X) accumulator))]
              
              [.10 (grade-accumulator-intact average (*) 2 2)]
              
              [*   (grade-additional-tests 1
                     (check-expect (average (list 5)) 5)
                     (check-expect (average (list 2 3 4)) 3) )])))))))
       
       
