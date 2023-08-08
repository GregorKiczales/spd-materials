#lang racket

(require spd-grader/grader
         spd-grader/walker)

(provide grader)

;;GRADER ONLY RUNS GIVEN TESTS AGAINST THE FUNCTIONS
(define grader 
  (lambda ()
    (grade-submission
      (weights (*)
      
        (grade-problem 1
          (grade-htdf all-names
            (ensure-unchanged '((@signature Tree -> (listof String))
                                ;; produce the names of all nodes in t
                                (check-expect (all-names L1) (list "L1"))
                                (check-expect (all-names M2) (list "M2" "L2" "L3"))
                                (check-expect (all-names TOP) (list "TOP" "M1" "L1" "M2" "L2" "L3"))))

            (weights (.1 .6 *)
              (grade-template-origin 1 (Tree (listof Tree) accumulator encapsulated*))
              (grade-tail-recursive 1)
              (grade-additional-tests 1
                (check-expect (all-names L1) (list "L1"))
                (check-expect (all-names M2) (list "M2" "L2" "L3"))
                (check-expect (all-names TOP) (list "TOP" "M1" "L1" "M2" "L2" "L3"))))))
      
        (grade-problem 2
          (grade-htdf count-nodes
            (ensure-unchanged '((@signature Tree -> Natural)
                                ;; produce a count of the number of nodes in t
                                (check-expect (count-nodes L1) 1)
                                (check-expect (count-nodes M2) 3)
                                (check-expect (count-nodes TOP) 6)))

            (weights (.1 .6 *)
              (grade-template-origin 1 (Tree (listof Tree) accumulator encapsulated*))
              (grade-tail-recursive 1)
              (grade-additional-tests 1
                (check-expect (count-nodes L1) 1)
                (check-expect (count-nodes M2) 3)
                (check-expect (count-nodes TOP) 6)))))
      
        (grade-problem 3
          (grade-htdf all-leaves
            (ensure-unchanged '((@signature Tree -> (listof String))
                                ;; produce the names of all leaf nodes (nodes without children) in t
                                (check-expect (all-leaves L1)  (list "L1"))
                                (check-expect (all-leaves M2)  (list "L2" "L3"))
                                (check-expect (all-leaves TOP) (list "L1" "L2" "L3"))))

            (weights (.1 .6 *)
              (grade-template-origin 1 (Tree (listof Tree) accumulator encapsulated*))
              (grade-tail-recursive 1)
              (grade-additional-tests 1
                (check-expect (all-leaves L1)  (list "L1"))
                (check-expect (all-leaves M2)  (list "L2" "L3"))
                (check-expect (all-leaves TOP) (list "L1" "L2" "L3"))))))))))
