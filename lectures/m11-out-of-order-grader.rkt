#lang racket

(require spd-grader/grader
         spd-grader/templates)

(provide grader)

(define ListOfNN
  '(one-of empty
           (compound (String (self-ref fn-for-nn))
                     cons cons?
                     (first rest))))

(define grader
  (lambda ()
    (grade-submission
      
      (grade-problem 1
        (grade-htdf first-out-of-order
          (weights (*)

            (ensure-unchanged
             '((@signature Map Natural -> Natural or false)
               ;; in TR traversal of graph from n, produce first out of sequence node number

               (check-expect (first-out-of-order MAP   1) 8)
               (check-expect (first-out-of-order MAP  11) false)
               (check-expect (first-out-of-order MAP 101) 108)

               (@template-origin genrec arb-tree accumulator)))


            
            (grade-accumulator-intact first-out-of-order (fn-for-node fn-for-lonn) 2 2)

            (grade-tail-recursive 1 '(fn-for-node fn-for-lonn))

            (grade-encapsulated-template-fns (fn-for-node fn-for-lonn)
              (weights (*)

                (grade-mr-intact        fn-for-node fn-for-lonn )
                
                (grade-questions-intact fn-for-lonn ,ListOfNN)
                (grade-mr-intact        fn-for-lonn fn-for-node)))
            
            (grade-submitted-tests 1))))

      (grade-problem 2
        (grade-htdf first-out-of-order-path
          (weights (*)

            (ensure-unchanged
             '((@signature Map Natural -> (listof Natural) or false)
               ;; in TR traversal of graph from n, produce path if first out of sequence node

               (check-expect (first-out-of-order-path MAP   1) (list 1 6 8))
               (check-expect (first-out-of-order-path MAP  11) false)
               (check-expect (first-out-of-order-path MAP 101) (list 101 102 103 105 106 108))
               
               (@template-origin genrec arb-tree accumulator)))
            
            (grade-accumulator-intact first-out-of-order (fn-for-node fn-for-lonn) 3 3) ;!!!

            (grade-tail-recursive 1 '(fn-for-node fn-for-lonn))

            (grade-encapsulated-template-fns (fn-for-node fn-for-lonn)
              (weights (*)
                (grade-mr-intact        fn-for-node fn-for-lonn )
                
                (grade-questions-intact fn-for-lonn ,ListOfNN)
                (grade-mr-intact        fn-for-lonn fn-for-node)))
            
            (grade-submitted-tests 1))))

      )))
