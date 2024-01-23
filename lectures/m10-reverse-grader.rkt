#lang racket
(require spd-grader/grader)
(require spd-grader/walker)
(provide grader)


(define grader
  (lambda ()
    (grade-submission
      (grade-problem 1
        (grade-htdf rev
          (let* ([sexps  (map elt-sexp (elts))]
                 [local-defines (cdr (defines rev))]
                 [fn-for-lox (car local-defines)]
                 [params (cadr fn-for-lox)]
                 [cond-exp (caddr fn-for-lox)]
                 [produces-value-of-param? (and (rest params)
                                                (symbol? (cadr (cadr  cond-exp)))            ;(cond [... rsf
                                                (member  (cadr (cadr  cond-exp))
                                                         (remove 'lox params)))])
            (ensure-unchanged SIG)
            (ensure-unchanged TESTS)
            (weights (*)
              (rubric-item 'template produces-value-of-param?
                           "Has accumulator parameter and produce its result in base case")
              (grade-tail-recursive))))))))

(define SIG
  '((@signature (listof X) -> (listof X))))

(define TESTS
  '((check-expect (rev empty) empty)
    (check-expect (rev (list 1)) (list 1))
    (check-expect (rev (list "a" "b" "c")) (list "c" "b" "a"))))

  
