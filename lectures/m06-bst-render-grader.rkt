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

(define-struct node (key val l r))
(define grader
  (lambda ()
    (grade-submission

      (define (%%render-bst t)
        (cond [(false? t)  empty-image]
              [else
               (above (text (string-append (number->string (node-key t))
                                           ":"
                                           (node-val t))
                            TEXT-SIZE
                            TEXT-COLOR)
                      (beside (%%render-bst (node-l t))
                              (%%render-bst (node-r t))))]))
      (weights (*)
        (grade-problem 1
          (grade-htdf render-bst
            (weights (*)
              (grade-signature (BST -> Image))

              (grade-tests-validity (t) r
                (or (false? t) (node? t))
                (equal? r (%%render-bst t)))

              (grade-tests-argument-thoroughness (t)
                (false? t)
                (and (not (false? t)) (false? (node-l t)))
                (and (not (false? t)) (false? (node-r t))))
              
              (grade-thoroughness-by-faulty-functions 1
                (define (render-bst t)
                  (cond [(false? t) empty-image]
                        [else
                         (above (text (string-append (number->string (node-key t))
                                                     ":"
                                                     (node-val t))
                                      TEXT-SIZE
                                      TEXT-COLOR)
                                (render-bst (node-l t)))]))
                
                (define (render-bst t)
                  (cond [(false? t) empty-image]
                        [else
                         (above (text (string-append (number->string (node-key t))
                                                     ":"
                                                     (node-val t))
                                      TEXT-SIZE
                                      TEXT-COLOR)
                                (render-bst (node-r t)))]))

                (define (render-bst t)
                  empty-image))

              (grade-template-origin (BST))
              (grade-questions-intact render-bst BST)

              (grade-submitted-tests)
              (grade-additional-tests 1
                (check-expect (render-bst false) empty-image)
                (check-expect (render-bst (make-node 1 "abc" false false))
                              (above (text "1:abc" TEXT-SIZE TEXT-COLOR)
                                     (beside (render-bst false)
                                             (render-bst false))))
                (check-expect (render-bst (make-node 3 "ilk" BST1 BST4))
                              (above (text "3:ilk" TEXT-SIZE TEXT-COLOR)
                                     (beside (render-bst BST1)
                                             (render-bst BST4))))))))))))
