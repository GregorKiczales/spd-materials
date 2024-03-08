#lang racket

(require spd-grader/grader)
(require spd-grader/design-abstract-fold)

(provide grader)

(define grader
  (lambda ()
    (grade-submission

      (grade-problem 2        
        (grade-design-abstract-fold fold-tree
          (@signature (String Y -> X)
                      (Z Y -> Y)
                      (Natural X -> Z)
                      Y
                      Tree
                      -> X)

          (#:copy-test  TTOP  TTOP)
          (#:count-test TTOP (+ 1 2 3 4 11 12) TTOP (+ 1 2 3 4 11 12))

          (@template-origin encapsulated Tree (listof Branch) Branch)
          
          (define (fold-tree c1 c2 c3 b1 t)
            (local [(define (fn-for-t t)
                      (c1 (tree-name t)
                          (fn-for-lob (tree-branches t))))
                    
                    (define (fn-for-lob lob)
                      (cond [(empty? lob) b1]
                            [else
                             (c2 (fn-for-b (first lob))
                                 (fn-for-lob (rest lob)))]))
                    
                    (define (fn-for-b b)
                      (c3 (branch-num b)
                          (fn-for-t (branch-tree b))))]
              
              (fn-for-t t))))))))
