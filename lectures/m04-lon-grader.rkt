#lang racket
(require spd-grader/check-template)
(require spd-grader/grader)
(require racket/function)

(provide grader)

(define ListOfNumber
  '(one-of empty
           (compound (Number (self-ref fn-for-lon))
                     cons cons?
                     (first rest))))

(define grader
  (lambda ()
    (grade-submission

      (define (%%doubles lon)
        (cond [(empty? lon) empty]
              [else
               (cons (* 2 (first lon))
                     (%%doubles (rest lon)))]))

      (grade-problem 1
        (weights (0 *)
          (grade-htdd ListOfNumber  ; weight is 0 because it is in starter, but we grade it so that
            ;;                      ; students can see grading report for correct self-referential
            ;;                      ; type definition
            (grade-dd-rules-and-template ,ListOfNumber))

          (grade-htdf sum
            (weights (*)

              (grade-signature (ListOfNumber -> Number)) 

              (grade-tests-validity (lon) r
                (list? lon)
                (andmap number? lon)
                (equal? r (foldr + 0 lon)))

              (grade-tests-argument-thoroughness (lon)
                (empty? lon)
                (>= (length lon) 2))

              (grade-thoroughness-by-faulty-functions 1
                (define (sum lon)
                  (local [(define (sum lon) 
                            (cond [(empty? lon) 1]  ;bad base
                                  [else
                                   (+ (first lon)
                                      (sum (rest lon)))]))]
                    (sum lon)))
                (define (sum lon)
                  (local [(define (sum lon) 
                            (cond [(empty? lon) 1]
                                  [else             ;no first
                                   (sum (rest lon))]))]
                    (sum lon)))
                (define (sum lon)
                  (cond [(empty? lon) 0]
                        [else
                         (first lon)])))            ;no NR
              
              (grade-template-origin (ListOfNumber))
              (grade-template        ,ListOfNumber)
              (grade-template-intact ListOfNumber)
              
              (grade-submitted-tests)
              (grade-additional-tests 1
                (check-expect (sum empty) 0)
                (check-expect (sum (cons 1 (cons 2 (cons 3 empty)))) (+ 1 2 3 0)))))))

        (grade-problem 2
          (grade-htdf product
            (weights (*)

              (grade-signature (ListOfNumber -> Number)) 

              (grade-tests-validity (lon) r
                (list? lon)
                (andmap number? lon)
                (equal? r (foldr * 1 lon)))

              (grade-tests-argument-thoroughness (lon)
                (empty? lon)
                (>= (length lon) 2))

               (grade-thoroughness-by-faulty-functions 1
                 (define (product lon) 0)            ;bad base
                 (define (product lon)
                   (local [(define (product lon) 
                             (cond [(empty? lon) 1]  
                                   [else  
                                    (+ (first lon)   ;bad combination
                                       (product (rest lon)))]))]
                     (product lon)))
                 (define (product lon)
                   (local [(define (product lon) 
                             (cond [(empty? lon) 1]
                                   [else             ;no first
                                    (product (rest lon))]))]
                     (product lon)))
                 (define (product lon)
                   (cond [(empty? lon) 0]
                         [else
                          (first lon)])))

               (grade-template-origin (ListOfNumber))
               (grade-template        ,ListOfNumber)
               (grade-template-intact ListOfNumber)

               (grade-submitted-tests)
               (grade-additional-tests 1
                 (check-expect (product empty) 1)
                 (check-expect (product (cons 3 (cons 4 (cons 5 empty)))) (* 3 4 5 1))))))

        (grade-problem 3
          (grade-htdf count
            (weights (*)

              (grade-signature (ListOfNumber -> Natural)) 

              (grade-tests-validity (lon) r
                (andmap number? lon)
                (equal? r (length lon)))

              (grade-tests-argument-thoroughness (lon)
                (empty? lon)
                (>= (length lon) 2))

              (grade-thoroughness-by-faulty-functions 1
                (define (count lon) 0)
                (define (count lon) (foldr + 0 lon)))

              (grade-template-origin (ListOfNumber))
              (grade-template        ,ListOfNumber)
              (grade-template-intact ListOfNumber)

              (grade-submitted-tests)
              (grade-additional-tests 1
                (check-expect (count empty) 0)
                (check-expect (count (cons 3 (cons 4 (cons 5 empty)))) (+ 1 1 1 0))))))

        (grade-problem 4
          (grade-htdf doubles
            (weights (*)

              (grade-signature (ListOfNumber -> ListOfNumber))

              (grade-tests-validity (lon) r
                (list? lon)
                (andmap number? lon)
                (equal? r (%%doubles lon)))
              
              (grade-tests-argument-thoroughness (lon)
                (empty? lon)
                (>= (length lon) 2))
              
              (grade-thoroughness-by-faulty-functions 1
                (define (doubles lon)
                  (cond [(empty? lon) empty]
                        [else
                         (cons (* 2 (first lon)) empty)])))
              
              (grade-template-origin (ListOfNumber))
              (grade-template        ,ListOfNumber)
              (grade-template-intact ListOfNumber)

              (grade-submitted-tests)
              (grade-additional-tests 1
                (check-expect (doubles empty) empty)
                (check-expect (doubles (cons 1 (cons 2 (cons 3 empty))))
                              (cons 2 (cons 4 (cons 6 empty)))))))))))

              


