#lang racket

(require spd-grader/grader
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

      (define (%%lookup t k)
        (cond [(false? t) false]
              [else
               (cond [(= k (node-key t)) (node-val t)]
                     [(< k (node-key t)) (%%lookup (node-l t) k)]
                     [(> k (node-key t)) (%%lookup (node-r t) k)])]))
      
      (define (%%height t)
        (cond [(false? t) 0]
              [else
               (max (add1 (%%height (node-l t)))
                    (add1 (%%height (node-r t))))]))
      
      (weights (*)
        (grade-problem 1
          (grade-htdf lookup
            (weights (*)
              (grade-signature (BST Integer -> String or false))

              (grade-tests-validity (t k) r
                (or (false? t) (node? t))
                (integer? k)
                (equal? r (%%lookup t k)))

              (grade-tests-argument-thoroughness (t int)

                (and (not (false? t)) (false? (node-l t)) (false? (node-r t)))

                (and (not (false? t))
                     (>= (%%height (node-l t)) 2)
                     (or (not (false? (%%lookup (node-r (node-l t)) int)))
                         (not (false? (%%lookup (node-l (node-l t)) int)))))

                (and (not (false? t))
                     (>= (%%height (node-r t)) 2)
                     (or (not (false? (%%lookup (node-r (node-r t)) int)))
                         (not (false? (%%lookup (node-l (node-r t)) int)))))
                
                (and (not (false? t)) (false? (%%lookup t int))))

              (grade-thoroughness-by-faulty-functions 1

                (define (lookup t k)
                  (cond [(false? t) true]
                        [else
                         (cond [(= k (node-key t)) (node-val t)]
                               [(< k (node-key t)) (lookup (node-l t) k)]
                               [(> k (node-key t)) (lookup (node-r t) k)])]))

                (define (lookup t k)
                  (cond [(false? t) true]
                        [else
                         (cond [(= k (node-key t)) (node-val t)]
                               [else (lookup (node-r t) k)])]))

                (define (lookup t k)
                  (cond [(false? t) true]
                        [else
                         (cond [(= k (node-key t)) (node-val t)]
                               [else (lookup (node-l t) k)])])))

              (grade-template-origin (BST))
              (grade-questions-intact lookup ,BST Integer)
              
              (grade-submitted-tests)
              (grade-additional-tests 1
                (check-expect (lookup BST1   1) "abc")
                (check-expect (lookup BST1   0) false)
                (check-expect (lookup BST1  99) false)
                (check-expect (lookup BST10  1) "abc")
                (check-expect (lookup BST10  4) "dcj")
                (check-expect (lookup BST10 27) "wit")
                (check-expect (lookup BST10 50) "dug")))))))))
