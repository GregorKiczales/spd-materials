#lang racket

(require spd-grader/grader
         spd-grader/check-template
         racket/function)

(provide grader)

(define BST
  (one-of false
          (compound (Integer String (sref BST fn-for-bst) (sref BST fn-for-bst))
                    make-node node?
                    (node-key node-val node-l node-r))))

(define grader
  (lambda ()
    (grade-submission
      (weights (*)
        (grade-problem 1
          (grade-htdd BST
            (grade-dd-template BST)))))))
    
