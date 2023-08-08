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
                 [htdf   (car (context))]
                 [defn   (htdf-defns htdf)]
                 [local-defines (cdr (defines defn))]
                 [fn-for-lox (car local-defines)]
                 [params (cadr fn-for-lox)]
                 [cond-exp (caddr fn-for-lox)]
                 [produces-value-of-param? (and (rest params)
                                                (symbol? (cadr (cadr  cond-exp)))            ;(cond [... rsf
                                                (member  (cadr (cadr  cond-exp))
                                                         (remove 'lox params)))]
                 [tail-recursive?          (and (list?   (cadr (caddr cond-exp)))            ;      [... (fn-for-lox
                                                         (eqv? (car (cadr (caddr cond-exp)))
                                                               'fn-for-lox))])
            (weights (*)
              (rubric-item 'signature 1 (unchanged? REV-SIG-TESTS sexps)
                           "the supplied signature and check-expects must not be changed")
              (grade-submitted-tests)
              (rubric-item 'template 1 produces-value-of-param?
                           "has accumulator parameter and produce its result in base case")
              (rubric-item 'template 1 tail-recursive?
                           "is tail recursive in non base case"))))))))

(define REV-SIG-TESTS
  '((@signature (listof X) -> (listof X))
    ;; produce list of same elements in the opposite order
    (check-expect (rev empty) empty)
    (check-expect (rev (list 1)) (list 1))
    (check-expect (rev (list "a" "b" "c")) (list "c" "b" "a"))))

  
