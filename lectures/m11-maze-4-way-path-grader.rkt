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
        (grade-htdf solve
          (weights (*)

            (ensure-unchanged
             '((@signature Maze -> Boolean)
               ;; produce true if maze is solvable, false otherwise
               ;; CONSTRAINT maze has a true at least in the upper left
               (check-expect (solve M1) #t)
               (check-expect (solve M2) #t)
               (check-expect (solve M3) #t) 
               (check-expect (solve M4) #t)
               (check-expect (solve M5) #f)
               (check-expect (solve M6) #t)
               (check-expect (solve M7) #t)))

            (grade-accumulator-intact solve? (solve/p solve/lop) 1 1)

            (grade-encapsulated-template-fns (solve/p solve/lop)
              (weights (*)
                
                (grade-questions-intact/body solve/p (p path)
                  (cond [(solved? p) ...]
                        [(member? p path) ...]
                        [else ...]))
                
                (grade-mr-intact        solve/p solve/lop)
                
                (grade-questions-intact solve/lop ListOfPos)
                
                (grade-mr-intact        solve/lop solve/p)))
            
            (grade-submitted-tests 1))))


      (grade-problem 2
        (grade-htdf find-path
          (let* ([htdf (car (context))]
                 [tests (htdf-checks htdf)])
            
            (weights (*)
            
              (grade-signature (Maze -> (listof Pos) or false))

              (rubric-item 'submitted-tests
                           (andmap (curryr member '(M1 M2 M3 M4 M5 M6 M7))
                                   (map cadr (map cadr tests)))
                           "Should have tests for all 7 of M1...M7")
              
              (grade-template-origin (genrec arb-tree try-catch accumulator))

              (grade-accumulator-intact find-path (find-path/p find-path/lop) 1 1)

              (grade-encapsulated-template-fns (find-path/p find-path/lop)
                
                (weights (*)
                  
                  (grade-questions-intact/body find-path/p (p path)
                    (cond [(solved? p) ...]
                          [(member? p path) ...] [else ...]))
                
                  (grade-mr-intact        find-path/p find-path/lop)
                
                  (grade-questions-intact find-path/lop ListOfPos)

                    
                  (grade-mr-intact        find-path/lop find-path/p)))
              
              (grade-submitted-tests 1)
              (grade-additional-tests 1
                (check-expect (find-path M1) (list (make-pos 0 0)
                                               (make-pos 0 1)
                                               (make-pos 1 1)
                                               (make-pos 1 2)
                                               (make-pos 1 3)
                                               (make-pos 1 4)
                                               (make-pos 2 4)
                                               (make-pos 3 4)
                                               (make-pos 4 4)))
                (check-expect (find-path M2) (list (make-pos 0 0)
                                               (make-pos 1 0)
                                               (make-pos 2 0)
                                               (make-pos 3 0)
                                               (make-pos 4 0)
                                               (make-pos 4 1)
                                               (make-pos 4 2)
                                               (make-pos 4 3)
                                               (make-pos 4 4)))
                (check-expect (find-path M3) (list (make-pos 0 0)
                                               (make-pos 0 1)
                                               (make-pos 0 2)
                                               (make-pos 0 3)
                                               (make-pos 0 4)
                                               (make-pos 1 4)
                                               (make-pos 2 4)
                                               (make-pos 3 4)
                                               (make-pos 4 4))) 
                (check-expect (find-path M4) (list (make-pos 0 0)
                                               (make-pos 1 0)
                                               (make-pos 2 0)
                                               (make-pos 3 0)
                                               (make-pos 4 0)
                                               (make-pos 4 1)
                                               (make-pos 4 2)
                                               (make-pos 3 2)
                                               (make-pos 2 2)
                                               (make-pos 2 3)
                                               (make-pos 2 4)
                                               (make-pos 3 4)
                                               (make-pos 4 4)))
                (check-expect (find-path M5) #f)
                (check-expect (find-path M6) (list (make-pos 0 0)
                                               (make-pos 1 0)
                                               (make-pos 2 0)
                                               (make-pos 2 1)
                                               (make-pos 2 2)
                                               (make-pos 2 3)
                                               (make-pos 3 3)
                                               (make-pos 3 4)
                                               (make-pos 3 5)
                                               (make-pos 3 6)
                                               (make-pos 3 7)
                                               (make-pos 4 7)
                                               (make-pos 5 7)
                                               (make-pos 5 6)
                                               (make-pos 5 5)
                                               (make-pos 5 4)
                                               (make-pos 5 3)
                                               (make-pos 5 2)
                                               (make-pos 5 1)
                                               (make-pos 5 0)
                                               (make-pos 6 0)
                                               (make-pos 7 0)
                                               (make-pos 8 0)
                                               (make-pos 9 0)
                                               (make-pos 9 1)
                                               (make-pos 9 2)
                                               (make-pos 8 2)
                                               (make-pos 7 2)
                                               (make-pos 7 3)
                                               (make-pos 7 4)
                                               (make-pos 8 4)
                                               (make-pos 9 4)
                                               (make-pos 9 5)
                                               (make-pos 9 6)
                                               (make-pos 8 6)
                                               (make-pos 7 6)
                                               (make-pos 7 7)
                                               (make-pos 7 8)
                                               (make-pos 8 8)
                                               (make-pos 9 8)
                                               (make-pos 9 9)))
                (check-expect (find-path M7) (list
                                          (make-pos 0 0)
                                          (make-pos 1 0)
                                          (make-pos 2 0)
                                          (make-pos 3 0)
                                          (make-pos 4 0)
                                          (make-pos 5 0)
                                          (make-pos 6 0)
                                          (make-pos 7 0)
                                          (make-pos 8 0)
                                          (make-pos 9 0)
                                          (make-pos 9 1)
                                          (make-pos 9 2)
                                          (make-pos 8 2)
                                          (make-pos 7 2)
                                          (make-pos 7 3)
                                          (make-pos 7 4)
                                          (make-pos 8 4)
                                          (make-pos 9 4)
                                          (make-pos 9 5)
                                          (make-pos 9 6)
                                          (make-pos 8 6)
                                          (make-pos 7 6)
                                          (make-pos 7 7)
                                          (make-pos 7 8)
                                          (make-pos 8 8)
                                          (make-pos 9 8)
                                          (make-pos 9 9)))))))))))
