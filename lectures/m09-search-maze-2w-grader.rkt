#lang racket
(require spd-grader/grader)
(require spd-grader/walker)
(provide grader)

(define grader
  (lambda ()
    (grade-submission

      (define (%%maze? x) 
        (and (list? x) (andmap boolean? x) (integer? (sqrt (length x)))))
      
      (define (%%solvable? m)
        (local [(define (fn-for-pos p)
                  (if (solved? p m)
                      true
                      (fn-for-lop (valid-next-positions p))))
                (define (fn-for-lop lop)
                  (cond [(empty? lop) false]
                        [else
                         (local [(define try (fn-for-pos (first lop)))]
                           (if (not (false? try))
                               try		       
                               (fn-for-lop (rest lop))))]))
                (define MAX-X/Y (sub1 (sqrt (length m))))
                (define (solved? p m)
                  (= (pos-x p) (pos-y p) MAX-X/Y))
                (define (valid-next-positions p)
                  (filter valid? (all-next-positions p)))
                (define (all-next-positions p)
                  (local [(define x (pos-x p))
                          (define y (pos-y p))]
                    (list (make-pos (add1 x)      y)
                          (make-pos       x (add1 y)))))
                (define (valid? p)
                  (and (<= 0 (pos-x p) MAX-X/Y)
                       (<= 0 (pos-y p) MAX-X/Y)
                       (mref m p)))]
          (fn-for-pos (make-pos 0 0))))

      (weights (*)

        (grade-problem 2
          (weights (*)
            (grade-htdf solvable?
              (weights (*)

                (grade-signature (Maze -> Boolean))

                (grade-tests-validity (m) r
                  (%%maze? m)
                  (equal? r (%%solvable? m)))

                (grade-argument-thoroughness ()
                  (per-args (m)
                    (>= (length m) 16)
                    (member false m)
                    (member true  m)
                    (%%solvable? m)
                    (not (%%solvable? m))))
                
                (grade-template-origin (encapsulated genrec arb-tree try-catch))
                (grade-submitted-tests 1)
                (grade-additional-tests 1
                  (check-expect (solvable? M1) #t)
                  (check-expect (solvable? M2) #t)
                  (check-expect (solvable? M3) #t) 
                  (check-expect (solvable? M4) #f))))))))))

               
                     
