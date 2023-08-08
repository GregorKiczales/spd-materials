#lang racket
(require spd-grader/grader)
(require spd-grader/walker)
(provide grader)


(define grader
  (lambda ()
    (grade-submission
      (define (%%sequence? lon0)
        (local [(define (sequence? lon acc)
                  (cond [(empty? lon) true]
                        [else
                         (if (= (first lon) (+ 1 acc)) 
                             (sequence? (rest lon)
                                        (first lon)) 
                             false)]))]
          (if (empty? lon0)
              true
              (sequence? (rest lon0)
                         (first lon0)))))

      (define (%%natural? x)
        (and (integer? x) (>= x 0)))
      
      (grade-problem 1
        (grade-htdf sequence?
          (weights (*)
            (grade-signature ((listof Natural) -> Boolean))
            (grade-tests-validity (lon) r
              (list? lon)
              (andmap %%natural? lon)
              (equal? r (%%sequence? lon)))
            (grade-tests-argument-thoroughness (lon)
             ;(= (length lon) 0)  ;!!!
              (= (length lon) 1)
              (> (length lon) 1)
              (not (equal? lon (sort lon >))))

            (score-max (grade-template-origin ((listof X) accumulator))
                       (grade-template-origin ((listof Natural) accumulator)))

            (grade-submitted-tests 1)

            (grade-additional-tests 1
              (check-expect (sequence? (list 2))     true)
              (check-expect (sequence? (list 2 3 4)) true)
              (check-expect (sequence? (list 3 5 6)) false))))))))




                
