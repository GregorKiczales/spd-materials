#lang racket

(require spd-grader/grader spd-grader/check-steps)

(provide grader)


(define grader
  (lambda ()
    (grade-submission
      (weights (*)
 
        (grade-problem 1 
          (grade-steps
            (define (foo s)
              (if (string=? (substring s 0 1) "a")
                  (string-append s "a")
                  s))
            
            (foo (substring "abcde" 0 3))))

        (grade-problem 2
          (grade-steps
            (define (bee s)
              (substring s 0 1))

            (define (bar s t)
              (if (> (string-length s) (string-length t))
                  (bee s)
                  (bee t)))
           
            (bar "def" "hij")))

        (grade-problem 3
          (grade-steps
            (define (farfle s)
              (string-append s s))

            (farfle (substring "abcdef" 0 2))))))))
