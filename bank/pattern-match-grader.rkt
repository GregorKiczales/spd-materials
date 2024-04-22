#lang racket

(require spd-grader/grader
         spd-grader/2-one-of)

(provide grader)


(define grader 
  (lambda ()
    (grade-submission

      (define (%%pattern-match? pat lo1s)
        (cond [(empty? pat) true]                            ;(1)        
              [(empty? lo1s) false]                          ;(2)         
              [(string=? (first pat) "A")                    ;(3) 
               (and (alphabetic? (first lo1s))
                    (%%pattern-match? (rest pat) (rest lo1s)))]
              [(string=? (first pat) "N")                    ;(4)
               (and (numeric? (first lo1s))
                    (%%pattern-match? (rest pat) (rest lo1s)))]))

      (define (%%1string? x) (and (string? x) (= (string-length x) 1)))
      (define (%%pat? x) (member x '("A" "N")))


      (grade-problem 1
        (grade-htdf pattern-match?
          (weights (.05 .10 .20 .5 0 *)

            (grade-signature (Pattern ListOfOneString -> Boolean))

            (grade-tests-validity (pat lo1s) r
              (and (list? pat)  (andmap %%pat? pat))
              (and (list? lo1s) (andmap %%1string? lo1s))
              (equal? r (%%pattern-match? pat lo1s)))

            (grade-thoroughness-by-faulty-functions 1

              (define (pattern-match? pat lo1s)
                (cond [(empty? pat) false]                            ;(1)        
                      [(empty? lo1s) false]                          ;(2)         
                      [(string=? (first pat) "A")                    ;(3) 
                       (and (alphabetic? (first lo1s))
                            (pattern-match? (rest pat) (rest lo1s)))]
                      [(string=? (first pat) "N")                    ;(4)
                       (and (numeric? (first lo1s))
                            (pattern-match? (rest pat) (rest lo1s)))]))

              (define (pattern-match? pat lo1s)
                (cond [(empty? pat) true]                            ;(1)        
                      [(empty? lo1s) true]                          ;(2)         
                      [(string=? (first pat) "A")                    ;(3) 
                       (and (alphabetic? (first lo1s))
                            (pattern-match? (rest pat) (rest lo1s)))]
                      [(string=? (first pat) "N")                    ;(4)
                       (and (numeric? (first lo1s))
                            (pattern-match? (rest pat) (rest lo1s)))]))

              (define (pattern-match? pat lo1s)
                (cond [(empty? pat) true]                            ;(1)        
                      [(empty? lo1s) false]                          ;(2)         
                      [(string=? (first pat) "A")                    ;(3) 
                       (and (numeric? (first lo1s))
                            (pattern-match? (rest pat) (rest lo1s)))]
                      [(string=? (first pat) "N")                    ;(4)
                       (and (numeric? (first lo1s))
                            (pattern-match? (rest pat) (rest lo1s)))]))

              (define (pattern-match? pat lo1s)
                (cond [(empty? pat) true]                            ;(1)        
                      [(empty? lo1s) false]                          ;(2)         
                      [(string=? (first pat) "A")                    ;(3) 
                       (and (alphabetic? (first lo1s))
                            (pattern-match? (rest pat) (rest lo1s)))]
                      [(string=? (first pat) "N")                    ;(4)
                       (and (alphabetic? (first lo1s))
                            (pattern-match? (rest pat) (rest lo1s)))])))
            
            (grade-2-one-of 1 (pat lo1s)
              (cond [(empty? pat) true]                            ;(1)        
                    [(empty? lo1s) false]                          ;(2)         
                    [(string=? (first pat) "A")                    ;(3) 
                     (and (alphabetic? (first lo1s))
                          (pattern-match? (rest pat) (rest lo1s)))]
                    [else                                          ;(4)
                     (and (numeric? (first lo1s))
                          (pattern-match? (rest pat) (rest lo1s)))]))
            
            (grade-submitted-tests) 
            (grade-additional-tests 1
              (check-expect (pattern-match? empty empty) true)
              (check-expect (pattern-match? empty (list "a")) true)
              (check-expect (pattern-match? (list "A") empty) false)
              (check-expect (pattern-match? (list "N") empty) false)
              (check-expect (pattern-match? (list "A" "N" "A") (list "x" "3" "y")) true)
              (check-expect (pattern-match? (list "A" "N" "A") (list "1" "3" "y")) false)
              (check-expect (pattern-match? (list "N" "A" "N") (list "1" "a" "4")) true)
              (check-expect (pattern-match? (list "N" "A" "N") (list "1" "b" "c")) false)
              (check-expect (pattern-match? (list "A" "N" "A" "N" "A" "N")
                                            (list "V" "6" "T" "1" "Z" "4")) true))))))))
 
