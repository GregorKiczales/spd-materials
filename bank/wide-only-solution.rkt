;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname wide-only-solution) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/image)
(require spd/tags)

(@assignment bank/abstraction-p1)
(@cwl ???)

(@problem 1)
;; Use the built in version of filter to design a function called wide-only 
;; that consumes a list of images and produces a list containing only those 
;; images that are wider than they are tall.


(@htdf wide-only)
(@signature (listof Image) -> (listof Image))
;; produce list containing only the images in loi for which wide? produces true

(check-expect (wide-only empty) empty)
(check-expect (wide-only (list (rectangle 40 20 "outline" "black")
                               (rectangle 20 40 "outline" "black")))
              (list (rectangle 40 20 "outline" "black")))

(@template-origin use-abstract-fn)

(define (wide-only loi)
  (filter wide? loi))


(@htdf wide?)
(@signature Image -> Boolean)
;; Produce true if image-width is > image-height.
(check-expect (wide? (rectangle 10 20 "solid" "blue")) false)
(check-expect (wide? (rectangle 20 20 "solid" "blue")) false)
(check-expect (wide? (rectangle 20 10 "solid" "blue")) true)

(@template-origin Image)

(define (wide? img)
  (> (image-width img)
     (image-height img)))
