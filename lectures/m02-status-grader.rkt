#lang racket
(require spd-grader/check-template)
(require spd-grader/grader)
(require racket/function)

(provide grader)

(define Status '(one-of "minor" "adult"))

(define grader
  (lambda ()
    (grade-submission
      (grade-problem 1
        (weights (*)
          (grade-htdd Status
            (grade-dd-rules-and-template ,Status))
          (grade-htdf can-vote?
            (weights (*)
              (grade-signature (Status -> Boolean))
              (grade-tests-validity (s) r
                (and (string? s) (or (string=? s "minor") (string=? s "adult")))
                (cond [(string=? s "minor") (not r)]
                      [(string=? s "adult") r]))
              (grade-tests-argument-thoroughness (s)
                (string=? s "minor")
                (string=? s "adult"))
              (grade-template-origin (Status))
              (grade-template        ,Status)
              (grade-template-intact Status)
              (grade-submitted-tests)
              (grade-additional-tests 1
                (check-expect (can-vote? "minor") false)
                (check-expect (can-vote? "adult") true)))))))))

