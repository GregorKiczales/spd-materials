#lang racket
(require spd-grader/grader
         spd-grader/check-template)

(provide grader)


(define grader
  (lambda ()
    (grade-submission

      (define (%%topple img)
        (rotate 90 img))

      (define (%%tall? i)
        (> (image-height i) (image-width i)))

      (define (%%image>? i1 i2)
        (> (* (image-width i1) (image-height i1))
           (* (image-width i2) (image-height i2))))
      
      (weights (*)

        (grade-problem 1
          (grade-htdf checkbox-line
            (weights (*)
              (grade-signature (String -> Image))
              (grade-tests-validity (s) r
                (image? r)
                (string? s))
              (grade-argument-thoroughness
                (per-args (str)
                  (string=? str "") 
                  (not (string=? str ""))))
              
              (grade-template-origin (String))
              (grade-template 1 (str) String)
              
              (grade-submitted-tests))))))))
                

