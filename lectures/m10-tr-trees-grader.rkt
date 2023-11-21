#lang racket
(require spd-grader/grader)
(require spd-grader/walker)
(provide grader)

(define grader
  (lambda ()
    (grade-submission
      (weights (*)
        
        (grade-problem 1
          (grade-htdf t->b-sorted?
            (let ()
              (ensure-unchanged '((@signature Tree -> Boolean)
                                  ;; produce true if ever subtree has a number greater than its parent
                                  (check-expect (t->b-sorted? L1) true)
                                  (check-expect (t->b-sorted? M1) true)
                                  (check-expect (t->b-sorted? TOP1) true)
                                  (check-expect (t->b-sorted? TOP2) false)
                                  (check-expect (t->b-sorted? TOP3) true)))
              (grade-submitted-tests))))
        
        
        (grade-problem 2
          (grade-htdf top/left->bot/right-sorted?
            (let ()
              (ensure-unchanged '((@signature Tree -> Boolean)
                                  ;; produce tree w/ given number (or fail)
                                  (check-expect (top/left->bot/right-sorted? L1) true)
                                  (check-expect (top/left->bot/right-sorted? M1) true)
                                  (check-expect (top/left->bot/right-sorted? TOP1) true)
                                  (check-expect (top/left->bot/right-sorted? TOP2) false)
                                  (check-expect (top/left->bot/right-sorted? TOP3) false)))
              
              (weights (.2 *) ;(.2 .2 *);!!!
                (grade-submitted-tests)
                ;(grade-template-origin (Tree (listof Tree) accumulator)) ;!!!
                (grade-tail-recursive 1)))))
        
        (grade-problem 3
          (grade-htdf count-nodes
            (let ()
              (ensure-unchanged '((@signature Tree -> Natural)
                                  ;; produce count of all nodes in the given tree
                                  (check-expect (count-nodes L1) 1)
                                  (check-expect (count-nodes M2) 3)
                                  (check-expect (count-nodes TOP) 6)))
              
              (weights (.1 .6 *)
                (grade-template-origin 1 (Tree (listof Tree) accumulator))
                (grade-tail-recursive 1)
                (grade-submitted-tests 1)))))
        
        (grade-problem 4
          (grade-htdf all-names
            (let ()
              (ensure-unchanged '((@signature Tree -> (listof String))
                                  ;; produce list of names of all nodes in the given tree
                                  (check-expect (all-names L1) (list "L1"))
                                  (check-expect (all-names M2) (list "M2" "L2" "L3"))
                                  (check-expect (all-names TOP) (list "TOP" "M1" "L1" "M2" "L2" "L3"))))
              
              (weights (.1 .6 *)
                (grade-template-origin 1 (Tree (listof Tree) accumulator))
                (grade-tail-recursive 1)
                (grade-submitted-tests 1)))))
        
        (grade-problem 5
          (grade-htdf all-leaves
            (let ()
              (ensure-unchanged '((@signature Tree -> (listof Tree))
                                  ;; produce list of all leaf nodes in the given tree
                                  (check-expect (all-leaves L1) (list L1))
                                  (check-expect (all-leaves M2) (list L2 L3))
                                  (check-expect (all-leaves TOP) (list L1 L2 L3))))
              
              (weights (.1 .6 *)
                (grade-template-origin 1 (Tree (listof Tree) accumulator))
                (grade-tail-recursive 1)
                (grade-submitted-tests 1)))))))))


