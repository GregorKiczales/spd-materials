#lang racket
(require spd-grader/check-template)
(require spd-grader/grader)
(require racket/function)

(provide grader)

(define grader
  (lambda ()
    (grade-submission

      (define (%%grade-standing? gs)
        (or (and (integer? gs) (<= 0 gs 100))
            (member? gs '("H" "P" "F" "T"))))
      
      (define (%%excellent? gs)
        (cond [(number? gs) (>= gs 90)] 
              [(string=? gs "H") false]
              [(string=? gs "P") false]
              [(string=? gs "F") false]
              [else false]))
      
      (define (%%grade->string gs)
        (cond [(number? gs) (string-append (number->string gs) "%")] 
              [(string=? gs "H") "H"]
              [(string=? gs "P") "P"]
              [(string=? gs "F") "F"]
              [else "T"]))
      
      (weights (*)
        (grade-problem 1
          (weights (*)
            (grade-htdd GradeStanding
              (grade-dd-rules-and-template (one-of Natural "H" "P" "F" "T")))
            (grade-htdf excellent?                      
              (weights (*)
                (grade-signature (GradeStanding -> Boolean))
                (grade-tests-validity (gs) r
                  (%%grade-standing? gs)
                  (equal? r (%%excellent? gs)))
                (grade-tests-argument-thoroughness (gs)
                  (and (number? gs) (= gs 89))
                  (and (number? gs) (= gs 90))
                  (and (number? gs) (= gs 91))
                  (and (string? gs) (string=? gs "H"))
                  (and (string? gs) (string=? gs "P"))
                  (and (string? gs) (string=? gs "F"))
                  (and (string? gs) (string=? gs "T")))

                (grade-template-origin (GradeStanding))
                (grade-template (gs) (one-of Natural "H" "P" "F" "T"))
                (grade-template-intact GradeStanding)
                (grade-submitted-tests)
                (grade-additional-tests 1 
                  (check-expect (excellent? 88) false)  
                  (check-expect (excellent? 89) false) 
                  (check-expect (excellent? 90) true)
                  (check-expect (excellent? 91) true)
                  (check-expect (excellent? "H") false)
                  (check-expect (excellent? "P") false)
                  (check-expect (excellent? "F") false)
                  (check-expect (excellent? "T") false))))))

        (grade-problem 2
          (grade-htdf grade->string
            (weights (*)
              (grade-signature (GradeStanding -> String))
              (grade-tests-validity (gs) r
                  (%%grade-standing? gs)
                  (equal? r (%%grade->string gs)))
              (grade-tests-argument-thoroughness (gs)
                (number? gs)
                (and (string? gs) (string=? gs "H"))
                (and (string? gs) (string=? gs "P"))
                (and (string? gs) (string=? gs "F"))
                (and (string? gs) (string=? gs "T")))

              (grade-template-origin (GradeStanding))
              (grade-template (gs) (one-of Natural "H" "P" "F" "T"))
              (grade-template-intact GradeStanding)
              (grade-submitted-tests)
              (grade-additional-tests 1
                (check-expect (grade->string 90) "90%")
                (check-expect (grade->string 80) "80%")
                (check-expect (grade->string "H") "H")
                (check-expect (grade->string "P") "P")
                (check-expect (grade->string "F") "F")
                (check-expect (grade->string "T") "T")))))))))


