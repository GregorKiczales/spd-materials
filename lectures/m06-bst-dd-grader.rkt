#lang racket
(require spd-grader/check-template)
(require spd-grader/grader)
(require racket/function)

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
          (grade-htdd BST
            (grade-dd-template ,BST)))))))
    
