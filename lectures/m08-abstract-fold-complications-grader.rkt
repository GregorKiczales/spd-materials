#lang racket
(require spd-grader/grader)
(require spd-grader/walker)
(provide grader)


(define grader
  (lambda ()
    (grade-submission
      (weights (*)
        (grade-problem 1
          (grade-htdf courses-w-credits
            (let* ([htdf   (car (context))]
                   [defns  (htdf-defns htdf)]
                   [called (called-fn-names (caddr (car defns)))])
              (begin (ensure (not (ormap (lambda (f) (member f '(foldr foldl fold-course))) called))
                             "must not call abstract functions in the body of defined function")
                     (ensure-unchanged '((@signature Course Natural -> (listof Course))
                                         (check-expect (courses-w-credits C100 4) empty)
                                         (check-expect (courses-w-credits C100 3) (list C100))
                                         (check-expect (courses-w-credits C100 2) (list C100))
                                         (check-expect (courses-w-credits C110 3)
                                                       (list C110 C203 C210 C213 C313 C317 C221 C304 C313 C314 C317 C320
                                                             C322 C310 C319 C311 C312 C302 C303))))
                     (weights (*)
                       (grade-submitted-tests 1 4)
                       (grade-template-origin 1 (Course (listof Course) encapsulated)))))))))))
          
            
