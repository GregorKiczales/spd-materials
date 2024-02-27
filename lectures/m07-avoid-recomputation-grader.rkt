#lang racket
(require spd-grader/grader
         spd-grader/walker
         spd-grader/templates)

(provide grader)

(define BST
  '(one-of false
           (compound (Integer String (self-ref fn-for-bst) (self-ref fn-for-bst))
                     make-node node?
                     (node-key node-val node-l node-r))))


(define grader
  (lambda ()
    (grade-submission
      (weights (*)
        (grade-problem 1
          (grade-htdf render-bst
            (let ([locs (cdr (defines render-bst))])
              (weights (*)
                (grade-submitted-tests 2)
                (grade-template-origin (BST))
                (grade-questions-intact render-bst ,BST)
                (grade-nr-intact render-bst 2)
                (rubric-item 'other (= (length locs) 2) "render-bst - 2 locally defined constants")))))))))

            


  
