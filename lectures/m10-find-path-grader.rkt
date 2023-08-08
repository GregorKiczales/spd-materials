#lang racket
(require spd-grader/grader)

(provide grader)

(define grader
  (lambda ()
    (grade-submission
      (grade-problem 1
        (grade-htdf find-path
          (begin (ensure-unchanged '((@signature Tree String -> (listof String) or false)
                                     ;; produce path to node w/ given name (or fail)
                                     (check-expect (find-path L1 "L1") (list "L1"))
                                     (check-expect (find-path L1 "L2") false)
                                     (check-expect (find-path L2 "L2") (list "L2"))
                                     (check-expect (find-path M1 "L1") (list "M1" "L1"))
                                     (check-expect (find-path TOP "L3") (list  "TOP" "M2" "L3"))))
                 (grade-submitted-tests)))))))


