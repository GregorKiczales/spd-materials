#lang racket
(require spd-grader/templates)
(require spd-grader/grader)
(require spd-grader/walker)
(provide grader)


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
                (grade-questions-intact render-bst (t) (cond [(false? t) ...] [else ...]))
                (grade-nr-intact render-bst 2)
                (rubric-item 'other (= (length locs) 2) "render-bst - 2 locally defined constants")))))))))

            


  
