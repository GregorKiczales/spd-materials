#lang racket
(require spd-grader/grader
         spd-grader/check-signature-by-constraints
         spd-grader/use-bia-fn
         spd-grader/walker)

(provide grader)


(define grader
  (lambda ()
    (grade-submission
                      
      (define (%%all-greater? lon x)
        (local [(define (>x? n) (> n x))]
          (andmap >x? lon)))

      (define (%%all-positive? lon)
        (local [(define (>x? n) (> n 0))]
          (andmap >x? lon)))

      (define (%%to-string s y)
        (string-append (number->string s) y))
      
      (weights (*)
        
        (grade-problem 1
          (weights (*)

            (grade-use-bia-fn all-greater?
              (@signature (listof Number) Number -> Boolean)
              [(1 (andmap2 _ _))]
              #:additional-tests
              (check-expect (all-greater? (list 2 -3 -4) -6) true)
              (check-expect (all-greater? (list -2 -3 -4) -3) false))

            (grade-use-bia-fn all-positive?
              (@signature (listof Number) -> Boolean)
              [(1 (andmap2 _ _))]
              #:additional-tests
              (check-expect (all-positive? (list 2 3 -4)) false)
                  (check-expect (all-positive? (list 2 3  4)) true))))

        (grade-problem 2
          (grade-htdf andmap2
            (weights (*)
              (grade-signature-by-constraints 1
                ((X -> Boolean) (listof X) -> Boolean))

              (grade-argument-thoroughness 
                (per-args (p lox)
                  (andmap p lox)
                  (not (andmap p lox))
                  (and (ormap p lox)
                       (not (andmap p lox)))))
              
              (grade-template-origin 1 ((listof X)))
              
              (grade-submitted-tests 1 2)
              
              (grade-additional-tests 1
                (check-expect (andmap2 positive? empty) true)
                (check-expect (andmap2 positive? (list 2 3 -4)) false)
                (check-expect (andmap2 positive? (list 2 3  4)) true)
                (check-expect (local [(define (fn n) (> n -3))] (andmap2 fn (list -2 -3 -4)))
                              false)
                (check-expect (local [(define (fn n) (< n 0))] (andmap2 fn (list -2 -3 -4)))
                              true)
                (check-expect (andmap2 false? (list true false true)) false)))))


        
        (grade-problem 3
          (grade-htdf filter2
            (weights (*) 

              (grade-signature-by-constraints 1
                ((X -> Boolean) (listof X) -> (listof X)))

              (grade-tests-validity (p lox) r
                (procedure? p)
                (list? lox)
                (equal? r (filter p lox)))

              (grade-argument-thoroughness 
                (per-args (p lox)
                  (empty? lox)
                  (> (length lox) 1)
                  (equal? lox (filter p lox))
                  (not (equal? lox (filter p lox)))))

              (grade-thoroughness-by-faulty-functions 1
                (define (filter2 p lon)
                  (cond [(empty? lon) empty]
                        [else 
                         (if (not (p (first lon)))
                             (cons (first lon) 
                                   (filter2 p (rest lon)))
                             (filter2 p (rest lon)))]))
                (define (filter2 p lon)
                  (cond [(empty? lon) empty]
                        [else 
                         (if (p (first lon))
                             (cons (first lon) 
                                   (filter2 p (rest lon)))
                             empty)]))
                (define (filter2 p lon)
                  (cond [(empty? lon) empty]
                        [else 
                         (cons (first lon) 
                               (filter2 p (rest lon)))])))

              (grade-template-origin 1 ((listof X)))

              (grade-submitted-tests 1 2)

              (grade-additional-tests 1
                (check-expect (filter2 positive? (list 1 -2 3 4)) (list 1 3 4))
                (check-expect (filter2 negative? (list -1 -3 -4 -5))  (list -1 -3 -4 -5))
                (check-expect (filter2 zero?     (list 1 -2 3 4)) (list))))))

        (grade-problem 4
          (grade-htdf map2
            (weights (*) 

              (grade-signature-by-constraints 1
                ((X -> Y) (listof X) -> (listof Y)))

              (grade-tests-validity (p lox) r
                (procedure? p)
                (list? lox)
                (equal? r (map p lox)))

              (grade-argument-thoroughness 
                (per-args (p lox)
                  (empty? lox)
                  (> (length lox) 1)
                  (not (equal? lox (map p lox)))))

              (grade-template-origin 1 ((listof X)))

              (grade-submitted-tests 1 2)

              (grade-additional-tests 1
                (check-expect (map2 add1 (list 1 2 3 4)) (list 2 3 4 5))
                (check-expect (map2 string-length (list "a" "anc" "ab" "defg")) (list 1 3 2 4))))))))))
