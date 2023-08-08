#lang racket
(require spd-grader/check-template)
(require spd-grader/grader)
(require spd-grader/walker)
(provide grader)


(define grader
  (lambda ()
    (grade-submission
      (weights (*)
        (grade-problem 1
          (grade-htdf render-bst
            (grade-submitted-tests 2)
            (grade-template-origin (BST))
            (grade-template-intact t
              (cond [(false? t) (...)]
                    [else
                     (... (node-key t)    ;Integer
                          (node-val t)    ;String
                          (fn-for-bst (node-l t))
                          (fn-for-bst (node-r t)))]))

            (let* ([htdf  (car (context))]
                   [defns (htdf-defns htdf)]
                   [fns   (free (caddr (car defns)))]
                   [locs  (cdr (defines defns))])
              (rubric 'other "Refactoring"
                      [(= (length locs) 2) 1 "incorrect number of locally defined functions"]
                      [(= (count (lambda (x) (eqv? x 'render-bst)) fns) 2) 1 "Correct number of calls to render-bst"]))))))))

            


  
