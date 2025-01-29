;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname arrange-images-v5) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/image)
(require spd/tags)

(@assignment bank/helpers-l1)
(@cwl ???)

;;   arrange-images-starter.rkt (problem statement)
;;   arrange-images-v1.rkt      (includes ListOfImage)
;;   arrange-images-v2.rkt      (includes arrange-images and
;;                               2 wish-list entries)
;;   arrange-images-v3.rkt      (includes arrange-images and layout-images,
;;                               stub for sort-images)
;;   arrange-images-v4.rkt      (includes arrange-images, layout-images,
;;                               sort and stub for insert)
;; > arrange-images-v5.rkt      (includes arrange-images, layout-images, sort,
;;                               insert, stub for larger?)
;;   arrange-images-v6.rkt      (complete)

(@problem 1)
;; In this problem imagine you have a bunch of pictures that you would like to 
;; store as data and present in different ways. We'll do a simple version of 
;; that here, and set the stage for a more elaborate version later.
;;
;; (A) Design a data definition to represent an arbitrary number of images.
;;
;; (B) Design a function called arrange-images that consumes an arbitrary number
;;     of images and lays them out left-to-right in increasing order of size.


;; =================
;; Constants:

(define I1 (rectangle 10 20 "solid" "blue"))
(define I2 (rectangle 20 30 "solid" "red"))
(define I3 (rectangle 30 40 "solid" "green"))



;; =================
;; Data definitions:

(@htdd ListOfImage)
;; ListOfImage is one of:
;;  - empty
;;  - (cons Image ListOfImage)
;; interp. an arbitrary number of images
(define LOI1 empty)
(define LOI2 (cons I1
                   (cons I2
                         empty)))

(@dd-template-rules one-of               ;2 cases
                    atomic-distinct      ;empty
                    compound             ;(cons Image ListOfImage)
                    self-ref)            ;(rest loi) is ListOfImage

#;
(define (fn-for-loi loi)
  (cond [(empty? loi) (...)]
        [else
         (... (first loi)
              (fn-for-loi (rest loi)))]))



;; =================
;; Functions:

(@htdf arrange-images)
(@signature ListOfImage -> Image)
;; lay out images left to right in increasing order of size
(check-expect (arrange-images (cons I1 (cons I2 empty)))
              (beside I1 I2  empty-image))
(check-expect (arrange-images (cons I2 (cons I1 empty)))
              (beside I1 I2 empty-image))

;(define (arrange-images loi) empty-image) ;stub

(@template-origin fn-composition)

(define (arrange-images loi)
  (layout-images (sort-images loi)))


(@htdf layout-images)
(@signature ListOfImage -> Image)
;; place images beside each other in order of list
(check-expect (layout-images empty) empty-image)
(check-expect (layout-images (cons I1 (cons I2 empty)))
              (beside I1 I2 empty-image))

;(define (layout-images loi) empty-image) ;stub

(@template-origin ListOfImage)

(define (layout-images loi)
  (cond [(empty? loi) empty-image]
        [else
         (beside (first loi)
                 (layout-images (rest loi)))]))


(@htdf sort-images)
(@signature ListOfImage -> ListOfImage)
;; sort images in increasing order of size (area)
(check-expect (sort-images empty) empty)
(check-expect (sort-images (cons I1 (cons I2 empty)))
              (cons I1 (cons I2 empty)))
(check-expect (sort-images (cons I2 (cons I1 empty)))
              (cons I1 (cons I2 empty)))
(check-expect (sort-images (cons I3 (cons I1 (cons I2 empty))))
              (cons I1 (cons I2 (cons I3 empty))))

;(define (sort-images loi) loi) ;stub

(@template-origin ListOfImage)

(define (sort-images loi)
  (cond [(empty? loi) empty]
        [else
         (insert (first loi)
                 (sort-images (rest loi)))])) ;result of natural recursion
                                              ;will be sorted


(@htdf insert)
(@signature Image ListOfImage -> ListOfImage)
;; insert img in proper place in loi (in increasing order of size)
;; CONSTRAINT: loi is already sorted
(check-expect (insert I1 empty) (cons I1 empty))
(check-expect (insert I1 (cons I2 (cons I3 empty)))
              (cons I1 (cons I2 (cons I3 empty))))
(check-expect (insert I2 (cons I1 (cons I3 empty)))
              (cons I1 (cons I2 (cons I3 empty))))
(check-expect (insert I3 (cons I1 (cons I2 empty)))
              (cons I1 (cons I2 (cons I3 empty))))

;(define (insert img loi) loi) ;stub

(@template-origin ListOfImage)

(define (insert img loi)
  (cond [(empty? loi) (cons img empty)]
        [else
         (if (larger? img (first loi))
             (cons (first loi)
                   (insert img
                           (rest loi)))
             (cons img loi))]))


(@htdf larger?)
(@signature Image Image -> Boolean)
;; produce true if img1 is larger than img2 (by area)
;; !!!
(define (larger? img1 img2) true) ;stub
