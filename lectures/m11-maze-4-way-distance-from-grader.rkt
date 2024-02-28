#lang racket

(require spd-grader/grader
         spd-grader/templates)

(provide grader)

(define Pos
  '(compound (Integer Integer)
             make-pos pos?
             (pos-x pos-y)))

(define ListOfPos
  '(one-of empty
           (compound ((ref fn-for-p) (self-ref fn-for-lop))
                     cons cons?
                     (first rest))))


(define grader
  (lambda ()
    (grade-submission
      
      (grade-problem 1
        (grade-htdf distance-from
          (weights (*)

            (ensure-unchanged
             '((@signature Maze Pos Pos -> Natural or false)
               ;; if path exists from start to end produce distance between
               ;; CONSTRAINT maze has a true at least in the upper left
               (check-expect (distance-from M1 (make-pos 1 1) (make-pos 1 4)) 3)
               (check-expect (distance-from M1 (make-pos 1 1) (make-pos 4 1)) #f)
               
               (check-expect (distance-from M2 (make-pos 0 0) (make-pos 4 4)) 8)
               
               (check-expect (distance-from M7 (make-pos 2 2) (make-pos 3 3)) 2)
               (check-expect (distance-from M7 (make-pos 2 0) (make-pos 7 2)) 11)))

           (grade-accumulator-intact distance-from (fn-for-p fn-for-lop) 2 2)

            (grade-encapsulated-template-fns (fn-for-p fn-for-lop)
              (weights (*)
                
                (grade-questions-intact fn-for-p (p path dist)
                  (cond [(equal? p end) ...]
                        #;[(solved? p) ...]
                        [(member? p path) ...] [else ...]))

                (grade-mr-intact        fn-for-p fn-for-lop)

                (grade-questions-intact fn-for-lop ,ListOfPos)
                
                (grade-mr-intact        fn-for-lop fn-for-p)))

            (grade-submitted-tests 1)))))))
