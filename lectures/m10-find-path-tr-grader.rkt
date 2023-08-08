#lang racket
(require spd-grader/grader)
(require spd-grader/walker)

(provide grader)

(define grader
  (lambda ()
    (grade-submission
      (grade-problem 1
        (grade-htdf find-path
          (let ()
            (ensure-unchanged '((check-expect (find-path L1 "L1") (list "L1"))
                                (check-expect (find-path L1 "foo") false)
                                (check-expect (find-path TOP "M1") (list "TOP" "M1"))
                                (check-expect (find-path TOP "L1") (list "TOP" "M1" "L1"))
                                (check-expect (find-path TOP "M2") (list "TOP" "M2"))
                                (check-expect (find-path TOP "L2") (list "TOP" "M2" "L2"))
                                (check-expect (find-path TOP "L3") (list "TOP" "M2" "L3"))))
            
            (weights (.02 .03  .8 *)
              (grade-signature 1 (Tree String -> (listof String) or false))
              (grade-template-origin 1 (Tree (listof Tree) accumulator))
              (grade-tail-recursive 1)
              (grade-submitted-tests 1))))))))


