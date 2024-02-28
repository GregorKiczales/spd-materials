#lang racket
(require spd-grader/grader
         spd-grader/templates)

(provide grader)

(define ListOfNumber
  '(one-of empty
           (compound (Number (self-ref fn-for-lon))
                     cons cons?
                     (first rest))))


(define grader
  (lambda ()
    (grade-submission
      (define (%%sequence? lon0)
        ;; prev is  Natural
        ;; invariant: the element of lon0 immediately before (first lon)
        ;; (sequence? (list 2 3 4 5 6))      
        
        ;; (sequence? (list   3 4 5 6) 2)  
        ;; (sequence? (list     4 5 6) 3)
        ;; (sequence? (list       5 6) 4)
        (local [(define (sequence? lon prev)
                  (cond [(empty? lon) true]     
                        [else           
                         (if (= (first lon) (+ 1 prev)) ;exploit (use)
                             (sequence? (rest lon)
                                        (first lon))    ;preserve
                             false)]))]
          
          (if (empty? lon0)                ;if original list is empty, we can't
              true                         ;initialize accumulator, so special case
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
            
            (grade-argument-thoroughness ()
              (per-args (lon)
                (= (length lon) 0)
                (>= (length lon) 2)

                (and (>= (length lon) 2)
                     (not (%%sequence? lon)))

                (and (>= (length lon) 2)
                     (%%sequence? lon))))

            (grade-template-origin ((listof Natural) accumulator))

            (grade-accumulator-intact sequence? (*) 1 1)

            (grade-encapsulated-template-fns (sequence?)
                                           
              (weights (*)
                (grade-questions-intact sequence? ,ListOfNumber)
                (grade-nr-intact        sequence?)))

            (grade-submitted-tests 1)

            (grade-additional-tests 1
              (check-expect (sequence? (list))         true)
              (check-expect (sequence? (list 2))       true)
              (check-expect (sequence? (list 2 3 4))   true)
              (check-expect (sequence? (list 3 5 6))   false)
              (check-expect (sequence? (list 3 2 5 1)) false))))))))




                
