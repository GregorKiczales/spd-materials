#lang racket

(require spd-grader/grader
         spd-grader/walker
         spd-grader/check-template
         spd-grader/templates)

(provide grader)

(define Tree
  (compound (Number (mref ListOfTree fn-for-lot))
            make-node node?
            (node-number node-subs)))

(define ListOfTree (make-listof-type 'ListOfTree 'fn-for-lot 'Tree 'fn-for-tree))

(define grader
  (lambda ()
    (grade-submission
      (weights (*)
        
        (grade-problem 1
          (grade-htdf top->bot-sorted?
            (begin (ensure-unchanged '((@signature Tree -> Boolean)
                                       ;; produce true if every num is greater than any node above it
                                       (check-expect (top->bot-sorted? L1) true)
                                       (check-expect (top->bot-sorted? M1) true)
                                       (check-expect (top->bot-sorted? TOP1) true)
                                       (check-expect (top->bot-sorted? TOP2) false)
                                       (check-expect (top->bot-sorted? TOP3) true)))

                   (grade-tree-template-and-tests))))
        
        (grade-problem 2
          (grade-htdf top/left->bot/right-sorted?
            (begin (ensure-unchanged '((@signature Tree -> Boolean)
                                       ;; produce true if every num is greater than any node above or left of it
                                       (check-expect (top/left->bot/right-sorted? L1) true)
                                       (check-expect (top/left->bot/right-sorted? M1) true)
                                       (check-expect (top/left->bot/right-sorted? TOP1) true)
                                       (check-expect (top/left->bot/right-sorted? TOP2) false)
                                       (check-expect (top/left->bot/right-sorted? TOP3) false)))
                   
                   (grade-tree-template-and-tests/tr))))
        
        (grade-problem 3
          (grade-htdf count-nodes
            (begin (ensure-unchanged '((@signature Tree -> Natural)
                                       ;; produce count of all nodes in the given tree
                                       (check-expect (count-nodes L1) 1)
                                       (check-expect (count-nodes M1) 2)
                                       (check-expect (count-nodes TOP1) 6)
                                       (check-expect (count-nodes TOP2) 6)
                                       (check-expect (count-nodes TOP3) 7)))
                   
                   (grade-tree-template-and-tests/tr))))
        
        (grade-problem 4
          (grade-htdf all-numbers
            (begin (ensure-unchanged '((@signature Tree -> (listof String))
                                       ;; produce list of names of all nodes in the given tree
                                       (check-expect (all-numbers L1) (list 30))
                                       (check-expect (all-numbers M1) (list 20 30))
                                       (check-expect (all-numbers TOP1) (list 10 20 30 40 50 60))
                                       (check-expect (all-numbers TOP2) (list 100 20 30 40 50 60))
                                       (check-expect (all-numbers TOP3) (list 10 100 20 30 40 50 60))))
                   
                   (grade-tree-template-and-tests/tr))))
        
        (grade-problem 5
          (grade-htdf all-leaves
            (begin (ensure-unchanged '((@signature Tree -> (listof Tree))
                                       ;; produce list of all leaf nodes in the given tree
                                       (check-expect (all-leaves L1) (list L1))
                                       (check-expect (all-leaves M1) (list L1))
                                       (check-expect (all-leaves TOP1) (list L1 L2 L3))
                                       (check-expect (all-leaves TOP2) (list L1 L2 L3))
                                       (check-expect (all-leaves TOP3) (list (make-node 100 empty) L1 L2 L3))))
                   
                   (grade-tree-template-and-tests/tr))))))))


(define (grade-tree-template-and-tests)
  (weights (*)
    (grade-template-origin (encapsulated* Tree (listof Tree) accumulator))    
    (grade-accumulator-intact top->bot-sorted? (fn-for-t fn-for-lot) 1 1)
    (grade-encapsulated-template-fns (fn-for-t fn-for-lot)
      (weights (*)        
        (grade-mr-intact        fn-for-t fn-for-lot)        
        (grade-questions-intact fn-for-lot ListOfTree)
        (grade-mr-intact        fn-for-lot fn-for-t)
        (grade-nr-intact        fn-for-lot)))    
    (grade-submitted-tests)))

(define (grade-tree-template-and-tests/tr)
  (weights (*)
    (grade-template-origin (encapsulated* Tree (listof Tree) accumulator))    
    (grade-accumulator-intact top->bot-sorted? (fn-for-t fn-for-lot) 2 2)
    (grade-encapsulated-template-fns (fn-for-t fn-for-lot)
      (weights (*)        
        (grade-mr-intact        fn-for-t fn-for-lot)
        (grade-questions-intact fn-for-lot ListOfTree)
        (grade-mr-intact        fn-for-lot fn-for-t)))
    (grade-tail-recursive)
    (grade-submitted-tests)))
