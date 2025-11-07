#lang racket
(require spd-grader/grader)
(require spd-grader/walker)
(provide grader)

(define grader
  (lambda ()
    (grade-submission
      (weights (*)
        (grade-problem 1
          (grade-htdf all-course-numbers
            (let* ([htdf   (car (context))]
                   [defns  (htdf-defns htdf)]
                   [called (called-fn-names (caddr (car defns)))])
              (begin (ensure-unchanged '((@signature Course -> (listof Natural))
                                         (check-expect (all-course-numbers C100) (list 100))
                                         (check-expect (all-course-numbers C213) (list 213 313 317))
                                         (check-expect (all-course-numbers C210)
                                                       (list 210 213 313 317 221 304 313
                                                             314 317 320 322 310 319 311 312))))
                     (ensure (member 'fold-course called)
                             "must call fold-course")
                     (weights (*)
                       (grade-submitted-tests 1 3)
                       (grade-template-origin 1 (use-abstract-fn)))))))
        (grade-problem 2
          (grade-htdf total-credits
            (let* ([htdf   (car (context))]
                   [defns  (htdf-defns htdf)]
                   [called (called-fn-names (caddr (car defns)))])
              (begin (ensure-unchanged '((@signature Course -> Natural)
                                         (check-expect (total-credits C100) 3)
                                         (check-expect (total-credits C110) 64)))
                     (ensure (member 'fold-course called)
                             "must call fold-course")
                     (weights (*)
                       (grade-submitted-tests 1)
                       (grade-template-origin 1 (use-abstract-fn)))))))))))
          
