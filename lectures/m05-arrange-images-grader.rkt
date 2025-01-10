#lang racket

(require 2htdp/image
         spd-grader/grader
         spd-grader/check-template)

(provide grader)

(define grader
  (lambda ()
    (grade-submission

      (define (%%arrange-images loi)
        (%%layout-images (%%sort-images loi)))

      (define (%%layout-images loi)
        (cond [(empty? loi) empty-image]
              [else
               (beside (first loi)
                       (%%layout-images (rest loi)))]))

      (define (%%sort-images loi)
        (cond [(empty? loi) empty]
              [else
               (%%insert (first loi)
                         (%%sort-images (rest loi)))]))

      (define (%%insert img loi)
        (cond [(empty? loi) (cons img empty)]
              [else
               (if (%%larger? img (first loi))
                   (cons (first loi)
                         (%%insert img
                                   (rest loi)))
                   (cons img loi))]))

      (define (%%larger? img1 img2)
        (> (* (image-width img1) (image-height img1))
           (* (image-width img2) (image-height img2))))
      
      (weights (*)
        (grade-problem 1
          (weights (*)

            (grade-htdf arrange-images
              (weights (*)
                (grade-signature (ListOfImage -> Image))
                (grade-tests-validity (loi) r
                  (list? loi)
                  (andmap image? loi)
                  (equal? r (%%arrange-images loi)))

                (grade-argument-thoroughness ()
                  (per-args (loi)
                    (> (length loi) 1)
                    ;(%%smaller-then-larger loi)  ;!!!
                    ;(%%larger-then-smaller loi)  ;!!!
                    ))
                
                (grade-thoroughness-by-faulty-functions 1
                  (define (arrange-images loi) empty-image)
                  (define (arrange-images loi) (foldr beside empty-image loi))
                  (define (arrange-images loi) (foldr beside empty-image (reverse loi))))
                
                (grade-template-origin (fn-composition))

                (grade-submitted-tests)
                (grade-additional-tests 1
                  (check-expect (arrange-images (cons I1 (cons I2 empty)))
                                (beside I1 I2 empty-image))
                  (check-expect (arrange-images (cons I2 (cons I1 empty)))
                                (beside I1 I2 empty-image)))))

            (grade-htdf layout-images
              (weights (*)
                (grade-signature (ListOfImage -> Image))
                (grade-tests-validity (loi) r
                  (list? loi)
                  (andmap image? loi)
                  (equal? r (%%layout-images loi)))
                (grade-argument-thoroughness ()
                  (per-args (loi)
                    (empty? loi)
                    (> (length loi) 1)))
                (grade-thoroughness-by-faulty-functions 1
                  (define (layout-images loi) empty-image)
                  (define (layout-images loi) (if (empty? loi) empty-image (first loi))))

                (grade-template-origin (ListOfImage))
                (grade-template         ListOfImage)
                
                (grade-submitted-tests)
                (grade-additional-tests 1
                  (check-expect (layout-images empty) empty-image)
                  (check-expect (layout-images (cons I1 (cons I2 empty)))
                                (beside I1 I2 empty-image)))))

            (grade-htdf sort-images
              (weights (*)
                (grade-signature (ListOfImage -> ListOfImage))
                (grade-tests-validity (loi) r
                  (list? loi)
                  (andmap image? loi)
                  (equal? r (%%sort-images loi)))
                (grade-argument-thoroughness ()
                  (per-args (loi)
                    (empty? loi)
                    (> (length loi) 1)
                    ;(%%smaller-then-larger loi)  ;!!!
                    ;(%%larger-then-smaller loi)  ;!!!
                    ))
                (grade-thoroughness-by-faulty-functions 1
                  (define (sort-images loi) loi)
                  (define (sort-images loi) (reverse loi)))

                (grade-template-origin (ListOfImage))
                (grade-template         ListOfImage)
                
                (grade-submitted-tests)
                (grade-additional-tests 1
                  (check-expect (sort-images (cons I1 (cons I2 empty)))
                                (cons I1 (cons I2 empty)))
                  (check-expect (sort-images (cons I2 (cons I1 empty)))
                                (cons I1 (cons I2 empty)))
                  (check-expect (sort-images (cons I3 (cons I1 (cons I2 empty))))
                                (cons I1 (cons I2 (cons I3 empty))))
                  (check-expect (sort-images (cons I3 (cons I2 (cons I1 empty))))
                                (cons I1 (cons I2 (cons I3 empty)))))))

            (grade-htdf insert
              (weights (*)
                (grade-signature (Image ListOfImage -> ListOfImage))

                (grade-tests-validity (img loi) r
                  (image? img)
                  (list? loi)
                  (andmap image? loi)
                  (equal? r (%%insert img loi)))
                
                (grade-argument-thoroughness ()
                  (per-args (img loi)
                    (empty? loi)
                    (> (length loi) 1)))
                
                (grade-thoroughness-by-faulty-functions 1
                  (define (insert img loi) (cons img loi))
                  (define (insert img loi) (append loi (list img))))

                (grade-template-origin (ListOfImage))
                (grade-template         Image ListOfImage)
                
                (grade-submitted-tests)
                
                (grade-additional-tests 1
                  (check-expect (insert I1 empty) (list I1))
                  (check-expect (insert I1 (list I2 I3)) (list I1 I2 I3))
                  (check-expect (insert I2 (list I1 I3)) (list I1 I2 I3))
                  (check-expect (insert I3 (list I1 I2)) (list I1 I2 I3)))))

            (grade-htdf larger?
              (weights (*)
                (grade-signature (Image Image -> Boolean))
                (grade-tests-validity (img1 img2) r
                  (and (image? img1)
                       (image? img2))
                  (equal? r (%%larger? img1 img2)))
                (grade-argument-thoroughness ()
                  (per-args (img1 img2)
                    (not (= (image-width  img1) (image-width  img2)))
                    (not (= (image-width  img1) (image-height img1)))
                    (not (= (image-width  img1) (image-height img2)))
                    
                    (not (= (image-width  img2) (image-height img1)))
                    (not (= (image-width  img2) (image-height img2)))

                    (not (= (image-height img1) (image-height img2)))

                    (> (* (image-width img1) (image-height img1))
                       (* (image-width img2) (image-height img2)))
                    (< (* (image-width img1) (image-height img1))
                       (* (image-width img2) (image-height img2)))
                    (= (* (image-width img1) (image-height img1))
                       (* (image-width img2) (image-height img2)))))
                
                (grade-thoroughness-by-faulty-functions 1
                  (define (larger? img1 img2)
                    (< (* (image-width img1) (image-height img1))
                       (* (image-width img2) (image-height img2))))
                  (define (larger? img1 img2)
                    (>= (* (image-width img1) (image-height img1))
                        (* (image-width img2) (image-height img2))))
                  (define (larger? img1 img2)
                    (- (* (image-width img1) (image-height img1))
                       (* (image-width img2) (image-height img2)))))

                (grade-template-origin (Image))
                (grade-template         Image Image)
                
                (grade-submitted-tests)
                (grade-additional-tests 1
                  (check-expect (larger? (rectangle 10 20 "solid" "black")
                                         (rectangle 10 20 "solid" "black"))
                                false)
                  (check-expect (larger? (rectangle 11 20 "solid" "black")
                                         (rectangle 10 20 "solid" "black"))
                                true)
                  (check-expect (larger? (rectangle 10 21 "solid" "black")
                                         (rectangle 10 20 "solid" "black"))
                                true)
                  (check-expect (larger? (rectangle 10 20 "solid" "black")
                                         (rectangle 11 20 "solid" "black"))
                                false)
                  (check-expect (larger? (rectangle 10 20 "solid" "black")
                                         (rectangle 10 21 "solid" "black"))
                                false))))))))))
