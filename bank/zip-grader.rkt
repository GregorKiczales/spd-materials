#lang racket

(require spd-grader/grader
         spd-grader/2-one-of)

(provide grader)


(define grader 
  (lambda ()
    (grade-submission

      (grade-problem 1
        (grade-htdf zip
          (weights (.05 .10 .20 .5 0 *)

            (grade-signature (ListOfNumber ListOfNumber -> ListOfEntry))

            (grade-tests-validity (lsta lstb) r
              (and (list? lsta) (andmap number? lsta))
              (and (list? lstb) (andmap number? lstb))
              (equal? r (map make-entry lsta lstb)))

            (grade-thoroughness-by-faulty-functions 1

              (define (zip lsta lstb)
                (cond [(empty? lsta) empty] ;(1)
                      [else                 ;(2)
                       (cons (make-entry (first lstb) (first lsta))
                             (zip (rest lsta) (rest lstb)))]))

              (define (zip lsta lstb)
                (cond [(empty? lsta) empty] ;(1)
                      [else                 ;(2)
                       (cons (make-entry (first lsta) (first lstb))
                             (zip (rest lstb) (rest lsta)))])))
            
            (grade-2-one-of 1 (lsta lstb)
              (cond [(empty? lsta) empty] ;(1)
                    [else                 ;(2)
                     (cons (make-entry (first lsta) (first lstb))
                           (zip (rest lsta) (rest lstb)))]))
            
            (grade-submitted-tests) 
            (grade-additional-tests 1
              (check-expect (zip (build-list 10 add1) (build-list 10 sqr))
                            (map make-entry (build-list 10 add1) (build-list 10 sqr))))))))))
