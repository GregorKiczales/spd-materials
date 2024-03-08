#lang racket
(require spd-grader/grader
         spd-grader/design-abstract-fold
         spd-grader/check-signature-by-constraints)

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

      (define (%%to-string x y)
        (string-append (number->string x) y))

      
      (grade-problem 1
        (grade-htdf foldr2
          (weights (*)
            (grade-signature-by-constraints 1
                                            ((X Y -> Y) Y (listof X) -> Y))
            (grade-thoroughness-by-faulty-functions 1
              (define (foldr2 fn b lox)
                (cond [(empty? lox) b]
                      [else
                       (fn (first lox)
                         b)]))
              (define (foldr2 fn b lox)
                b))
            (grade-template-origin 1 ((listof X)))
            (grade-submitted-tests 1 2)
            (grade-additional-tests 1
              (check-expect (foldr2 + 0 (list 1 2 3)) 6)
              (check-expect (foldr2 * 1 (list 2 3 4)) 24)
              (check-expect (foldr2 %%to-string "" (list 1 37 65))
                            "13765")))))
      
      (grade-problem 2
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
              
              (fn-for-course c0))))))))
