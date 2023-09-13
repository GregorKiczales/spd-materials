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

      (define (%%image> i1 i2)
        (> (* (image-width i1) (image-height i1))
           (* (image-width i2) (image-height i2))))
      
      (weights (*)

        (grade-problem 1
          (grade-htdf topple
            (weights (*)
              (grade-signature (Image -> Image))
              (grade-tests-validity (img) r
                (image? img)
                (equal? r (%%topple img)))
              (grade-argument-thoroughness
                (per-args (img)
                  (not (= (image-width img) (image-height img)))))
              #; ;too early for this
              (grade-thoroughness-by-faulty-functions 1
                (define (topple img)
                  (rotate 0 img)))
              (grade-template-origin (Image))
              (grade-template 1 (img) Image)
              (grade-submitted-tests)
              (grade-additional-tests 1
                (check-expect (topple (rectangle 10 20 "solid" "red"))
                              (rectangle 20 10 "solid" "red"))
                (check-expect (topple (triangle 20 "solid" "red"))
                              (rotate 90 (triangle 20 "solid" "red")))))))

        (grade-problem 2
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
              
              (grade-submitted-tests))))

        (grade-problem 3        
          (grade-htdf tall?
            (weights (*)
              (grade-signature (Image -> Boolean))
              (grade-tests-validity (img) r
                (image? img)
                (equal? r (%%tall? img)))
              (grade-argument-thoroughness
                (per-args (img)
                  (< (image-height img) (image-width img))
                  (> (image-height img) (image-width img))
                  (= (image-height img) (image-width img))))
              #; ;too early for this
              (grade-thoroughness-by-faulty-functions 1
                (define (tall? i)
                  (>= (image-height i) (image-width i)))
                (define (tall? i)
                  (< (image-height i) (image-width i)))
                (define (tall? i)
                  (= (image-height i) (image-width i))))
              
              (grade-template-origin (Image))
              (grade-template 1 (img) Image)
              (grade-submitted-tests)
              (grade-additional-tests 1
                (check-expect (tall? (rectangle 10 20 "outline" "black")) true)
                (check-expect (tall? (rectangle 30 20 "outline" "black")) false)))))

        (grade-problem 4
          (grade-htdf image>
            (weights (*)
              (grade-signature (Image Image -> Boolean))
              (grade-tests-validity (i1 i2) r
                (image? i1)
                (image? i2)
                (equal? r (%%image> i1 i2)))
              (grade-argument-thoroughness
                (per-args (i1 i2)
                  (not (= (image-height i1) (image-width i1)))
                  (not (= (image-height i2) (image-width i2)))
                  (> (* (image-height i1) (image-width i1)) (* (image-width i2) (image-height i2)))
                  (< (* (image-height i1) (image-width i1)) (* (image-width i2) (image-height i2)))
                  (= (* (image-height i1) (image-width i1)) (* (image-width i2) (image-height i2)))))
              #;
              (grade-thoroughness-by-faulty-functions 1
                (define (image> i1 i2)
                  (< (* (image-width i1) (image-height i1))
                     (* (image-width i2) (image-height i2))))
                (define (image> i1 i2)
                  (>= (* (image-width i1) (image-height i1))
                      (* (image-width i2) (image-height i2)))))
              
              (grade-template-origin (Image))
              (grade-template 1 (i1 i2) Image)
              (grade-submitted-tests)
              (grade-additional-tests 1
                (check-expect (image> empty-image empty-image) false)
                (check-expect (image> (rectangle 10 21 "outline" "black")
                                      (rectangle 10 20 "outline" "black"))
                              true)
                (check-expect (image> (rectangle 10 20 "outline" "black")
                                      (rectangle 10 20 "outline" "black"))
                              false)
                (check-expect (image> (rectangle 10 19 "outline" "black")
                                      (rectangle 10 20 "outline" "black"))
                              false)))))))))
                

