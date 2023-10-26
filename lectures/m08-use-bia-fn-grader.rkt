#lang racket
(require spd-grader/grader
         spd-grader/walker
         spd-grader/use-bia-fn)

(provide grader)

(define grader
  (lambda ()
    (grade-submission
      (weights (*) 

        (grade-problem 1
          (grade-use-bia-fn circles
            (@signature (listof Natural) -> (listof Image))
            [(1 (map _ _))]
            #:supplied-tests
            (check-expect (circles (list 3))
                          (list (circle 3 "solid" "blue")))
            (check-expect (circles (list 1 2 10))
                          (list (circle 1 "solid" "blue")
                                (circle 2 "solid" "blue")
                                (circle 10 "solid" "blue")))
            #:additional-tests
            (check-expect (circles (list 10 20 30))
                          (list (circle 10 "solid" "blue")
                                (circle 20 "solid" "blue")
                                (circle 30 "solid" "blue")))))

        (grade-problem 2
          (grade-use-bia-fn keep-in-interval
            (@signature Integer Integer (listof Integer) -> (listof Integer))
            [(1 (filter _ _))]
            #:supplied-tests
            (check-expect (keep-in-interval 0 10 (list -1 0 5 10 12)) (list 0 5 10))
            (check-expect (keep-in-interval -1 1 (list 3 0 5 1 0)) (list 0 1 0))
            #:additional-tests
            (check-expect (keep-in-interval 1 5 (list 0 1 2 3 4 5 6 7)) (list 1 2 3 4 5))))

        (grade-problem 3
          (grade-use-bia-fn odds-minus-evens
            (@signature (listof Integer) -> Integer)                            
            [(1 (foldr _ _))]
            #:supplied-tests
            (check-expect (odds-minus-evens (list 3)) 3)
            (check-expect (odds-minus-evens (list 2)) -2)
            (check-expect (odds-minus-evens (list 1 4 5 2)) 0)
            #:additional-tests
            (check-expect (odds-minus-evens (list 1 3 5  2 6)) 1)))

        (grade-problem 4
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

        (grade-problem 5
          (grade-use-bia-fn fact
            (@signature Natural -> Natural)
            [(1.0 (foldr _ (build-list _ _)))]
            #:supplied-tests
            (check-expect (fact 0) 1)
            (check-expect (fact 3) (* 3 2 1))
            #:additional-tests
            (check-expect (fact 5) (* 5 4 3 2 1))))

        (grade-problem 6
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

        (grade-problem 7
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
                  (rubric-item 'template correct? "must call both foldr and build-list twice")
                  (grade-additional-tests 1
                                          (check-expect (pyramid 4)
                                                        (above CIRCLE
                                                               (beside CIRCLE CIRCLE)
                                         (beside CIRCLE CIRCLE CIRCLE)
                                         (beside CIRCLE CIRCLE CIRCLE CIRCLE))))))
  
