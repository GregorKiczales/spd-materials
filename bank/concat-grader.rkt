#lang racket

(require spd-grader/grader
         spd-grader/2-one-of
         spd-grader/walker)

(provide grader)


(define grader 
  (lambda ()
    (grade-submission

      (grade-problem 1
        (grade-htdf concat
          (let* ([htdf (car (context))]
                 [defns (htdf-defns htdf)]
                 [defn  (and (pair? defns) (car defns))])
            
            (grade-prerequisite 'other "must not call append"
                (calls-none? defn '(append))
              
              (weights (.05 .10 .20 .5 0 *)

                (grade-signature (ListOfString ListOfString -> ListOfString))

                (grade-tests-validity (lsta lstb) r
                  (and (list? lsta) (andmap string? lsta))
                  (and (list? lstb) (andmap string? lstb))
                  (equal? r (append lsta lstb)))
                
                (grade-thoroughness-by-faulty-functions 1
                                                        
                  (define (concat lsta lstb)
                    (cond [(empty? lstb) lstb] ;(1)
                          [(empty? lsta) lstb] ;(2)
                          [else                ;(3)
                           (cons (first lsta)
                                 (concat (rest lsta) lstb))]))
                  
                  (define (concat lsta lstb)
                    (cond [(empty? lstb) lsta] ;(1)
                          [(empty? lsta) lsta] ;(2)
                          [else                ;(3)
                           (cons (first lsta)
                                 (concat (rest lsta) lstb))]))
                  
                  (define (concat lsta lstb)
                    (cond [(empty? lstb) lsta] ;(1)
                          [(empty? lsta) lstb] ;(2)
                          [else                ;(3)
                           (cons (first lstb)
                                 (concat (rest lsta) lstb))]))
                  
                  (define (concat lsta lstb)
                    (cond [(empty? lstb) lsta] ;(1)
                          [(empty? lsta) lstb] ;(2)
                          [else                ;(3)
                           (cons (first lsta)
                                 (concat lsta (rest lstb)))])))
                
                (grade-2-one-of 1
                                (lsta lstb)
                                (cond [(empty? lstb) lsta] ;(1)
                                      [(empty? lsta) lstb] ;(2)
                                      [else                ;(3)
                                       (cons (first lsta)
                                             (concat (rest lsta) lstb))]))
                
                (grade-submitted-tests) 
                (grade-additional-tests 1
                  (check-expect (concat '("a" "c" "d" "e") '("b" "f")) '("a" "c" "d" "e" "b" "f")))))))))))

