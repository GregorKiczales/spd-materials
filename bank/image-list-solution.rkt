;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname image-list-solution) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/image)
(require spd/tags)

(@assignment bank/self-ref-p6)
(@cwl ???)

;; =================
;; Data definitions:

(@problem 1)
;; Design a data definition to represent a list of images. Call it ListOfImage. 


(@htdd ListOfImage)
;; ListOfImage is one of: 
;;  - empty
;;  - (cons Image ListOfImage)
;; interp. a list of images
(define LI0 empty) 
(define LI1 (cons (circle 20 "solid" "red") empty))
(define LI2 (cons (circle 40 "solid" "blue")
                  (cons (circle 20 "solid" "red") empty)))

(@dd-template-rules one-of          ;2 cases
                    atomic-distinct ;empty
                    compound        ;(cons Image ListOfImage)
                    self-ref)       ;(rest loi) is ListOfImage

#;
(define (fn-for-loi loi) 
  (cond [(empty? loi) (...)]
        [else
         (... (first loi)
              (fn-for-loi (rest loi)))]))



;; =================
;; Functions:

(@problem 2)
;; Design a function that consumes a list of images and produces a number 
;; that is the sum of the areas of each image. For area, just use the image's 
;; width times its height.


(@htdf total-area)
(@signature ListOfImage -> Number) 
;; produce total area of all images
(check-expect (total-area empty) 0)
(check-expect (total-area (cons (rectangle 2 4 "solid" "red")
                                (cons (square 3 "solid" "blue")
                                      empty)))
              17)

;(define (total-area loi) 0)  ;stub

(@template-origin ListOfImage)

(@template
 (define (total-area loi) 
   (cond [(empty? loi) (...)]
         [else
          (... (first loi)
               (total-area (rest loi)))])))

(define (total-area loi) 
  (cond [(empty? loi) 0]
        [else
         (+ (* (image-width (first loi))
               (image-height (first loi)))
            (total-area (rest loi)))]))
