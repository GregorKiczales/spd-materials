#lang racket

(require spd-grader/grader)
(provide grader)

(define grader
  (lambda ()
    (grade-submission

      (define (%%count-odds t)
        (cond [(false? t) 0]
              [else
               (if (odd? (node-key t))
                   (+ 1 
                      (%%count-odds (node-l t))
                      (%%count-odds (node-r t)))
                   (+ (%%count-odds (node-l t))
                      (%%count-odds (node-r t))))]))

      (define (%%height t)
        (cond [(false? t) 0]
              [else
               (max (add1 (%%height (node-l t)))
                    (add1 (%%height (node-r t))))]))

      (weights (*)
        (grade-problem 1
          (grade-htdf count-odds
            (weights (*)

              (grade-signature (BST -> Natural))

              (grade-tests-validity (bst) r
                (and (number? r) (>= r 0))
                (or (node? bst) (false? bst))
                (equal? r (%%count-odds bst)))

              (grade-tests-argument-thoroughness (bst)
                (false? bst)
                (and (not (false? bst))
                     (false? (node-l bst))
                     (false? (node-r bst)))
                (and (not (false? bst))
                     (>= (%%height (node-l bst)) 2)
                     (>= (%%height (node-r bst)) 2)
                     (not (= (%%count-odds (node-l bst))
                             (%%count-odds (node-r bst))))))
              
              (grade-thoroughness-by-faulty-functions 1
                (define (count-odds t)
                  (cond [(false? t) 1]
                        [else
                         (if (odd? (node-key t))
                             (+ 1 
                                (count-odds (node-l t))
                                (count-odds (node-r t)))
                             (+ (count-odds (node-l t))
                                (count-odds (node-r t))))]))
                (define (count-odds t)
                  (cond [(false? t) 0]
                        [else
                         (if (not (odd? (node-key t)))
                             (+ 1 
                                (count-odds (node-l t))
                                (count-odds (node-r t)))
                             (+ (count-odds (node-l t))
                                (count-odds (node-r t))))]))
                (define (count-odds t)
                  (cond [(false? t) 0]
                        [else
                         (+ 1 
                            (count-odds (node-l t))
                            (count-odds (node-r t)))])))
              
              (grade-template-origin (BST))
              (grade-submitted-tests)
              (grade-additional-tests 1
                (check-expect (count-odds BST0) 0)
                (check-expect (count-odds BST1) 1)
                (check-expect (count-odds BST42) 1)
                (check-expect (count-odds BST10) 4)))))))))
