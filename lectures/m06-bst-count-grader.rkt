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

      (define (%%count t)
        (cond [(false? t) 0]
              [else
               (+ 1 
                  (%%count (node-l t))
                  (%%count (node-r t)))]))

      (define (%%height t)
        (cond [(false? t) 0]
              [else
               (max (add1 (%%height (node-l t)))
                    (add1 (%%height (node-r t))))]))
                      
      (weights (*)
        (grade-problem 1
          (grade-htdf count
            (weights (*)

              (grade-signature (BST -> Natural))

              (grade-tests-validity (t) r
                (and (number? r) (>= r 0))
                (or (node? t) (false? t))
                (equal? r (%%count t)))

              (grade-tests-argument-thoroughness (bst)
                (false? bst)
                (and (not (false? bst))
                     (false? (node-l bst))
                     (false? (node-r bst)))
                (and (not (false? bst))
                     (>= (%%height (node-l bst)) 2))
                (and (not (false? bst))
                     (>= (%%height (node-r bst)) 2)))
            
              (grade-thoroughness-by-faulty-functions 1
                (define (count t)
                  (cond [(false? t) 1]
                        [else
                         (+ 1 
                            (count (node-l t))
                            (count (node-r t)))]))
                (define (count t)
                  (cond [(false? t) 0]
                        [else
                         (+ 2 
                            (count (node-l t))
                            (count (node-r t)))]))
                (define (count t)
                  0)
                (define (count t)
                  (cond [(false? t) 0]
                        [else
                         (+ 1 
                            (count (node-l t)))])))
              
              (grade-template-origin        (BST))
              (grade-questions-intact count  BST)
               
              (grade-submitted-tests)
              (grade-additional-tests 1
                (check-expect (count BST0) 0)
                (check-expect (count BST1) 1)
                (check-expect (count BST42) 4)
                (check-expect (count BST10) 9)))))))))
