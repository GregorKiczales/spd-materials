;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname m05-arrange-images-v2) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #t)))
(require spd/tags)
(require 2htdp/image)

(@assignment lectures/m05-arrange-images)
;; arrange-images-starter.rkt (problem statement)
;; arrange-images-v1.rkt      (includes ListOfImage)
;; arrange-images-v2.rkt      (+ arrange-images and 2 wish-list entries)

(@cwl ???) ;replace ??? with your cwl



(@problem 1)
#|

In this problem imagine you have a bunch of pictures that you would like to 
store as data and present in different ways. We'll do a simple version of that 
here, and set the stage for a more elaborate version later.

(A) Design a data definition to represent an arbitrary number of images.

(B) Design a function called arrange-images that consumes an arbitrary number
    of images and lays them out left-to-right in increasing order of size.

|#

;; Constants:



;; for testing:
(define I1 (rectangle 10 20 "solid" "blue"))
(define I2 (rectangle 20 30 "solid" "red"))
(define I3 (rectangle 30 40 "solid" "green"))


;; Data definitions:

(@htdd ListOfImage)
;; ListOfImage is one of:
;;  - empty
;;  - (cons Image ListOfImage)
;; interp. An arbitrary number of images
(define LOI1 empty)
(define LOI2 (cons I1
                   (cons I2
                         empty)))

(@dd-template-rules   one-of             ; 2 cases
                      atomic-distinct    ; empty
                      compound           ; (cons Image ListOfImage)
                      self-ref)          ; (rest ListOfImage) is ListOfImage

(define (fn-for-loi loi)
  (cond [(empty? loi) (...)]
        [else
         (... (first loi)
              (fn-for-loi (rest loi)))]))


;; Functions:

(@htdf arrange-images)
(@signature ListOfImage -> Image)
;; lay out images left to right in increasing order of size
(check-expect (arrange-images (cons I1 (cons I2 empty)))
              (beside I1 I2 empty-image))
(check-expect (arrange-images (cons I2 (cons I1 empty)))
              (beside I1 I2 empty-image))

(define (arrange-images loi) empty-image) ;stub

