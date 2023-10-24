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
            (let* ([htdf (car (context))]
                   [defn (car (htdf-defns htdf))]
                   [fns  (called-fn-names defn)]
                   [locs (cdr (defines defn))])
              (weights (*)
                (grade-submitted-tests 2)
                (grade-template-origin (BST))
                (grade-template-intact t
                                       (cond [(false? t) (...)]
                                             [else
                                              (... (node-key t)    ;Integer
                                                   (node-val t)    ;String
                                                   (fn-for-bst (node-l t))
                                                   (fn-for-bst (node-r t)))]))
                (rubric-item 'other (= (length locs) 2) "2 locally defined constants")
                (rubric-item 'other (= (count (lambda (x) (eqv? x 'render-bst)) fns) 2) "2 calls to render-bst")))))))))

            


  
