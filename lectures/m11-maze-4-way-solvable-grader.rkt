#lang racket
(require spd-grader/grader)
(provide grader)

(define grader
  (lambda ()
    (grade-submission
      (grade-problem 1
        (grade-htdf solve
          (begin (ensure-unchanged '((check-expect (solve M1) true)
                                     (check-expect (solve M2) true)
                                     (check-expect (solve M3) true) 
                                     (check-expect (solve M4) true)
                                     (check-expect (solve M5) false)
                                     (check-expect (solve M6) true)
                                     (check-expect (solve M7) true)))
                 (weights (.05 .1 *)
                   (grade-signature (Maze -> Boolean))              
                   (grade-template-origin (genrec arb-tree try-catch accumulator encapsulated*))
                   (grade-submitted-tests))))))))
