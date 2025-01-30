#lang racket

(require spd-grader/grader
         spd-grader/check-template
         spd-grader/templates)

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
        (grade-htdf solvable-no-revisits?
          (weights (*)
            
            (ensure-unchanged
             '((@signature Maze -> Boolean)
               ;; produce true if maze is solvable, false otherwise
               ;; CONSTRAINT: maze has a true at least in the upper left
               (check-expect (solvable-no-revisits? M1) #t)
               (check-expect (solvable-no-revisits? M2) #t)
               (check-expect (solvable-no-revisits? M3) #t) 
               (check-expect (solvable-no-revisits? M4) #t)
               (check-expect (solvable-no-revisits? M5) #f)
               (check-expect (solvable-no-revisits? M6) #t)
               (check-expect (solvable-no-revisits? M7) #t)))
            
            (grade-accumulator-intact solvable-no-revisits? (fn-for-p fn-for-lop) 2 2)

            (grade-tail-recursive 1 '(fn-for-p fn-for-lop))
            
            (grade-encapsulated-template-fns (fn-for-p fn-for-lop)
              (weights (*)
                
                (grade-questions-intact/body fn-for-p (p p-wl visited)
                  (cond [(solved? p) ...]
                        [(member? p visited) ...]
                        [else ...]))
                
                (grade-mr-intact        fn-for-p fn-for-lop)
                
                (grade-questions-intact fn-for-lop ListOfPos)
                
                (grade-mr-intact        fn-for-lop fn-for-p)))
            
            (grade-submitted-tests 1)))))))
