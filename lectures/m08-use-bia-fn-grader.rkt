#lang racket
(require spd-grader/grader
         spd-grader/walker
         spd-grader/use-bia-fn)

(provide grader)

(define grader
  (lambda ()
    (grade-submission
      (weights (.2 .2 #;.2 *) ;!!!

        (grade-problem 1
          (grade-use-bia-fn odds-minus-evens
            (@signature (listof Integer) -> Integer)                            
            [(1 (foldr _ _))]
            #:supplied-tests
            (check-expect (odds-minus-evens (list 3)) 3)
            (check-expect (odds-minus-evens (list 2)) -2)
            (check-expect (odds-minus-evens (list 1 4 5 2)) 0)
            #:additional-tests
            (check-expect (odds-minus-evens (list 1 3 5  2 6)) 1)))

        (grade-problem 2
          (grade-use-bia-fn sum-larger-than
            (@signature Integer (listof Integer) -> Integer)
            [(1.0 (foldr _ (filter _ _)))]
            #:supplied-tests
            (check-expect (sum-larger-than 4 (list 3)) 0)
            (check-expect (sum-larger-than 5 (list 5)) 0)
            (check-expect (sum-larger-than 6 (list 6)) 0)
            (check-expect (sum-larger-than 3 (list 1 2 3 4 5)) 9)
            #:additional-tests
            (check-expect (sum-larger-than 5 (list 1 2 3 4 5 6 7 8 9)) (+ 6 7 8 9))))

        (grade-problem 3
          (grade-use-bia-fn boxes
            (@signature Natural -> Image)
            [(1 (foldr _ (build-list _ _)))
             (1 (foldr _ (map _ (build-list _ _))))
             (1 (foldr _ (map _ (map _ (build-list _ _)))))]
            #:supplied-tests
            (check-expect (boxes 0) empty-image)
            (check-expect (boxes 1) (square 1 "outline" "black"))
            (check-expect (boxes 2)
                          (overlay (square 11 "outline" "black")
                                   (square 1 "outline" "black")))
            #:additional-tests
            (check-expect (boxes 3)
                          (overlay (square 21 "outline" "black")
                                   (square 11 "outline" "black")
                                   (square 1 "outline" "black")))))

        #; ;!!! make this work, infer-biaf-compositions isn't up to it now
        (grade-problem 4
          (grade-use-bia-fn pyramid                            
            (@signature Natural -> Image)
            [(1 (foldr _ (build-list _ (foldr _ (build-list _ _)))))]
            #:supplied-tests
            (check-expect (pyramid 0) empty-image)
            (check-expect (pyramid 1) CIRCLE)
            (check-expect (pyramid 2)
                          (above CIRCLE
                                 (beside CIRCLE CIRCLE)))
            (check-expect (pyramid 3)
                          (above CIRCLE
                                 (beside CIRCLE CIRCLE)
                                 (beside CIRCLE CIRCLE CIRCLE)))
            #:additional-tests
            (check-expect (pyramid 4)
                          (above CIRCLE
                                 (beside CIRCLE CIRCLE)
                                 (beside CIRCLE CIRCLE CIRCLE)
                                 (beside CIRCLE CIRCLE CIRCLE CIRCLE)))))))))

            #;
              (let* ([htdf   (car (context))]
                     [defns  (htdf-defns htdf)]
                     [defn   (and (pair? defns) (car defns))]
                     [called (and defn (called-fn-names (caddr (car defns))))]
                     [correct? (and called
                                    (= (length (filter (curry eqv? 'foldr) called))
                                       (length (filter (curry eqv? 'build-list) called))))])
                (weights (*)
                  (rubric-item 'template 1 correct? "must call both foldr and build-list twice")
                  (grade-additional-tests 1
                    (check-expect (pyramid 4)
                                  (above CIRCLE
                                         (beside CIRCLE CIRCLE)
                                         (beside CIRCLE CIRCLE CIRCLE)
                                         (beside CIRCLE CIRCLE CIRCLE CIRCLE))))))
  
