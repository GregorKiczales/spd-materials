#lang racket
(require spd-grader/grader spd-grader/design-abstract-fold)
(provide grader)

(define grader
  (lambda ()
    (grade-submission

      (define %%C1 (make-course 1 2 '()))
      (define %%C2 (make-course 1 2 '()))
      (define %%C3 (make-course 1 2 '()))
      (define %%C4 (make-course 1 2 '()))

      (define %%C5 (make-course 1 2 (list %%C1 %%C2)))
      (define %%C6 (make-course 1 2 (list %%C3)))

      (define %%C7 (make-course 1 2 (list %%C5 %%C6 %%C4)))

      (grade-problem 1
        (grade-htdf fold-course
          (grade-design-abstract-fold fold-course

            (@signature (Natural Natural Y -> X) (X Y -> Y) Y Course -> X)

            (#:copy-test  C110    %%C7)
            (#:count-test C110 20 %%C7 7)
            
            (@template-origin Course (listof Course) encapsulated)

            (define (fold-course c1 c2 b1 c0)
              (local [(define (fn-for-course c)
                        (c1 (course-number c)
                            (course-credits c)
                            (fn-for-loc (course-dependents c))))
                      
                      (define (fn-for-loc loc)
                        (cond [(empty? loc) b1]
                              [else
                               (c2 (fn-for-course (first loc))
                                   (fn-for-loc (rest loc)))]))]
                
                (fn-for-course c0)))))))))
