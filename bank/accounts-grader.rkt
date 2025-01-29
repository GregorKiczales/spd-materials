#lang racket

(require spd-grader/grader
         spd-grader/style
         spd-grader/design-abstract-fold)

(provide grader)

(define grader
  (lambda ()
    (grade-submission

      (define %%A1
        (make-node 10 "A" 84
                   (make-node 3 "B" 600
                              false
                              (make-node 4 "D" -3
                                         (make-node 7 "E" 13 false false)
                                         false))
                   (make-node 42 "F" -79
                              (make-node 27 "G" 40
                                         (make-node 14 "H" -9 false false)
                                         (make-node 14 "I"  9 false false))
                              (make-node 50 "H" 16 false false))))

      

      (grade-problem 3

        (check-2-semi-comments)
        #;
        (grade-design-abstract-fold fold-accounts


          (@signature (Natural String Integer X X -> X) X Accounts -> X)

          (#:copy-test  ACT10      %%A1)
          (#:count-test ACT10 684  %%A1 (+ 84 600 -3 13 -79 40 -9 9 16))

          (@template-origin Accounts)

          (define (fold-accounts c1 b1 act)
            (cond [(false? act) b1]
                  [else
                   (c1 (node-id act)
                       (node-name act)
                       (node-bal act)
                       (fold-accounts c1 b1 (node-l act))
                       (fold-accounts c1 b1 (node-r act)))])))))))
