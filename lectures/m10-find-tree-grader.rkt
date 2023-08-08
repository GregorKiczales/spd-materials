#lang racket
(require spd-grader/grader)
(require spd-grader/walker)
(provide grader)

(define grader
  (lambda ()
    (grade-submission
      (weights (2/10 8/10 *)
        (grade-problem 1
          (grade-htdf find-tree
            (let ()
              (ensure-unchanged '((@signature Tree String -> Tree or false)
                                  ;; produce tree w/ given name (or fail)
                                  (check-expect (find-tree L1 "L1") L1)
                                  (check-expect (find-tree L1 "L2") false)
                                  (check-expect (find-tree L2 "L2") L2)
                                  (check-expect (find-tree M1 "L1") L1)
                                  (check-expect (find-tree TOP "L3") L3)))
              (grade-submitted-tests))))


        (grade-problem 2
          (grade-htdf find-tree/tr
            (let ()
              (ensure-unchanged '((@signature Tree String -> Tree or false)
                                  ;; produce tree w/ given name (or fail)
                                  (check-expect (find-tree/tr L1 "L1") L1)
                                  (check-expect (find-tree/tr L1 "L2") false)
                                  (check-expect (find-tree/tr L2 "L2") L2)
                                  (check-expect (find-tree/tr M1 "L1") L1)
                                  (check-expect (find-tree/tr TOP "L3") L3)))
              
              (weights (.2 *) ;(.2 .2 *);!!!
                (grade-submitted-tests)
               ;(grade-template-origin (Tree (listof Tree) accumulator)) ;!!!
                (grade-tail-recursive 1)))))

        (if (not (andmap (lambda (n)
                           (get-by-pred (lambda (x) (and (@problem? x) (= (problem-num x) n)))))
                         '(3 4 5)))
            (rubric-item 'other 1 #f "The revised starter has optional problems you can download.")

            (weights (*)

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
                (grade-submitted-tests 1)))))))))))

  
