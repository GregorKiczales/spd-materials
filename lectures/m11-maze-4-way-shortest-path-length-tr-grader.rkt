#lang racket

(require spd-grader/grader
         spd-grader/check-template
         spd-grader/walker)

(provide grader)

(define Pos
  (compound (Integer Integer)
            make-pos pos?
            (pos-x pos-y)))

(define ListOfPos (make-listof-type 'ListOfPos 'fn-for-lop 'Pos 'fn-for-p))

(define grader
  (lambda ()
    (grade-submission
      (grade-problem 1
        (grade-htdf solve
          (let* ([htdf   (car (context))]
                 [tests  (htdf-checks htdf)])
            
            (weights (.02 .1 .03 .8 *)
              (grade-signature (Maze -> Natural or false)) 
              (rubric-item 'test-thoroughness
                           (andmap (curryr member '(M1 M2 M3 M4 M5 M6 M7))
                                   (map cadr (map cadr tests)))
                           "Must have test for all 7 of M1...M7")
              (grade-template-origin (genrec arb-tree accumulator))
              (grade-tail-recursive 1 '(solve/p solve/lop))
              (grade-additional-tests 1
                (check-expect (solve M1) 9)
                (check-expect (solve M2) 9)
                (check-expect (solve M3) 9) 
                (check-expect (solve M4) 13)
                (check-expect (solve M5) #f)
                (check-expect (solve M6) 27)
                (check-expect (solve M7) 27)))))))))




