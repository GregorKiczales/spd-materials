#lang racket
(require spd-grader/grader
         spd-grader/check-template
         spd-grader/templates)

(provide grader)


(define grader
  (lambda ()
    (grade-submission

      (define (%%boxes n)
        (cond [(zero? n) (square 1 "outline" "black")]
              [else
               (overlay (square (+ 1 (* n 10)) "outline" "black")
                        (%%boxes (sub1 n)))]))
      
      (define (%%blist n)
        (cond [(zero? n) empty]
              [else
               (append (%%blist (sub1 n))
                       (cons n empty))]))

      (grade-problem 1
        (weights (*)

; check-template can't deal with the type hack that is self-referential Natural
;         (grade-htdd Natural       ; weight is 0 because it is in starter, but we grade it so that
;           ;;                      ; students can see grading report for correct self-referential
;           ;;                      ; type definition
;           (grade-dd-rules-and-template (one-of 0
;                                                (compound ((self-ref fn-for-natural))
;                                                          add1 identity
;                                                           (sub1)))))

          (grade-htdf boxes
            (weights (*)
              (grade-signature (Natural -> Image))
              (grade-tests-validity (n) r
                (and (integer? n) (>= n 0))
                (equal? (%%boxes n) r))
              (grade-tests-argument-thoroughness (n)
                (zero? n)
                (> n 0))
              (grade-thoroughness-by-faulty-functions 1
                (define (boxes n)
                  (cond [(zero? n) (square 1 "outline" "black")]
                        [else
                         (overlay (square (+ 1 (* n 10)) "outline" "black")
                                  empty-image)]))
                (define (boxes n)
                  (cond [(zero? n) empty-image]
                        [else
                         (local [(define (boxes n)
                                   (cond [(zero? n) (square 1 "outline" "black")]
                                         [else
                                          (overlay (square (+ 1 (* n 10)) "outline" "black")
                                                   (boxes (sub1 n)))]))]
                           (overlay (square (+ 1 (* n 10)) "outline" "black")
                                    (boxes (sub1 n))))])))
              
              (grade-template-origin (Natural))
              (grade-template (n)
                  (cond [(zero? n) (...)]
                        [else
                         (... n            
                              (boxes (sub1 n)))]))
              
              (grade-questions-intact boxes (n)
                (cond [(zero? n) (...)]
                      [else
                       (... n            
                            (fn-for-natural (sub1 n)))]))
              
              (grade-submitted-tests)
              (grade-additional-tests 1
                (check-expect (boxes 0) (square 1 "outline" "black"))
                (check-expect (boxes 1)
                              (overlay (square 11 "outline" "black")
                                       (square 1 "outline" "black")))
                (check-expect (boxes 2)
                              (overlay (square 21 "outline" "black")
                                       (square 11 "outline" "black")
                                       (square  1 "outline" "black"))))))))
      
      (grade-problem 2
        (grade-htdf fact
          (weights (*)
            (grade-signature (Natural -> Natural))

            (grade-tests-validity (n) r
              (and (number? n) (>= n 0))
              (equal? r (foldr * 1 (build-list n add1))))
            (grade-tests-argument-thoroughness (n)
              (and (number? n) (zero? n))
              (and (number? n) (> n 0)))
            (grade-thoroughness-by-faulty-functions 1
              (define (fact n)
                0)
              (define (fact n)
                (cond [(zero? n) 1]
                      [else
                       (local [(define (fact i)
                                 (if (zero? i)
                                     1
                                     (+ i (fact (sub1 i)))))]
                         (+ n 
                            (fact (sub1 n))))])))

            
              (grade-template-origin (Natural))
              (grade-template (n)
                  (cond [(zero? n) (...)]
                        [else
                         (... n            
                              (fact (sub1 n)))]))
              
              (grade-questions-intact fact (n)
                (cond [(zero? n) (...)]
                      [else
                       (... n            
                            (fn-for-natural (sub1 n)))]))
              
            (grade-submitted-tests)
            (grade-additional-tests 1
              (check-expect (fact 0) 1)
              (check-expect (fact 3) (* 3 2 1))))))
        
      (grade-problem 3
        (grade-htdf blist
          (weights (*)
            (grade-signature (Natural -> ListOfNatural))

            (grade-tests-validity (n) r
              (and (number? n) (>= n 0))
              (equal? r (%%blist n)))
            (grade-thoroughness-by-faulty-functions 1
              (define (blist n)
                (cond [(zero? n) (cons 1 empty)]
                      [else
                       (local [(define (blist n)
                                 (cond [(zero? n) empty]
                                       [else
                                        (append (blist (sub1 n))
                                                (cons n empty))]))]
                         (blist n))]))
              (define (blist n)
                (cond [(zero? n) empty]
                      [else
                       (local [(define (blist n)
                                 (cond [(zero? n) empty]
                                       [else
                                        (append (blist (sub1 n))
                                                (cons (- n 1) empty))]))]
                         (blist n))])))

            
              (grade-template-origin (Natural))
              (grade-template (n)
                  (cond [(zero? n) (...)]
                        [else
                         (... n            
                              (blist (sub1 n)))]))
              
              (grade-questions-intact blist (n)
                (cond [(zero? n) (...)]
                      [else
                       (... n            
                            (fn-for-natural (sub1 n)))]))

            (grade-submitted-tests)
            (grade-additional-tests 1
              (check-expect (blist 0) empty)
              (check-expect (blist 3) (cons 1 (cons 2 (cons 3 empty)))))))))))
                                                 
