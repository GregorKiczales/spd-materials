#lang racket
(require spd-grader/grader)
(require spd-grader/walker)
(provide grader)

(define grader
  (lambda ()
    (grade-submission
      (grade-problem 1
        (grade-htdf solve
          (let ()
            (ensure-unchanged '((check-expect (solve M1) true)
                                (check-expect (solve M2) true)
                                (check-expect (solve M3) true) 
                                (check-expect (solve M4) true)
                                (check-expect (solve M5) false)
                                (check-expect (solve M6) true)
                                (check-expect (solve M7) true)))
            
            (weights (.02 .03 .8 *)
              (grade-signature (Maze -> Boolean))
              (grade-template-origin (genrec arb-tree accumulator))
              (grade-tail-recursive 1 '(solve/p solve/lop))
              (grade-submitted-tests))))))))


