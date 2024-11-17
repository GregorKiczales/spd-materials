#lang racket
(require spd-grader/grader
         spd-grader/check-template
         spd-grader/templates)

(provide grader)

(define BST
  (one-of false
          (compound (Integer String (sref BST fn-for-bst) (sref BST fn-for-bst))
                    make-node node?
                    (node-key node-val node-l node-r))))


(define grader
  (lambda ()
    (grade-submission

      (define (%%bt? x)
        (or (false? x)
            (and (node? x)
                 (integer? (node-k x))
                 (string?  (node-v x))
                 (%%bt?    (node-l x))
                 (%%bt?    (node-r x)))))

      (define (%%bst? bt0)
        (local [(define (bst? bt lower upper)
                  (cond [(false? bt) true]
                        [else
                         (and (< lower (node-k bt) upper)
                              (bst? (node-l bt)  lower        (node-k bt))
                              (bst? (node-r bt)  (node-k bt)  upper))]))]
          (bst? bt0 -inf.0 +inf.0)))

      (define (%%height t)
        (cond [(false? t) 0]
              [else
               (max (add1 (%%height (node-l t)))
                    (add1 (%%height (node-r t))))]))
                  
      (grade-problem 1
        (grade-htdf bst?
          (weights (*)
            
            (grade-signature (BinaryTree -> Boolean))

            (grade-tests-validity (bt) r
              (%%bt? bt)
              (equal? r (%%bst? bt)))


            (grade-argument-thoroughness
                (per-args (bst)
                  (false? bst)
                  (and (not (false? bst))
                       (false? (node-l bst))
                       (false? (node-r bst)))
                  (>= (%%height (node-l bst)) 2)
                  (>= (%%height (node-r bst)) 2)))

            (grade-template-origin (BinaryTree accumulator))

            (grade-accumulator-intact bst? (*) 2 2)

            (score-max 
             (grade-encapsulated-template-fns (fn-for-bt)
               (weights (*)
                 (grade-questions-intact fn-for-bt BST)
                 (grade-nr-intact        fn-for-bt 2)))
             
             (grade-encapsulated-template-fns (bst?)
               (weights (*)
                 (grade-questions-intact bst? BST)
                 (grade-nr-intact        bst? 2))))
            
            (grade-submitted-tests 1)
            (grade-additional-tests 1
              (check-expect (bst? BT1) true)
              (check-expect (bst? BT2) false)
              (check-expect (bst? BT3) false)
              (check-expect (bst? BT4) false)
              (check-expect (bst? BT5) false))))))))
