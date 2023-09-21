;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname m01-htdf-solution) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #t)))
(require 2htdp/image)
(require spd/tags)

(@assignment bank/checkbox-line);Do not edit or remove this tag

(@problem 1)
;;
;; Design a function that consumes the name of something and produces a
;; "checkbox line" image that allows someone to check off that item.  For 
;; example (checkbox-line "apples") would produce an image with a small
;; check box next to the word apples.
;;

(@htdf checkbox-line)
(@signature String -> Image)
;; produce image of box next to text
(check-expect (checkbox-line "")
              (beside (square 20 "outline" "black")
                      (text "" 20 "black")))
(check-expect (checkbox-line "apples")
              (beside (square 20 "outline" "black")
                      (text "apples" 20 "black")))
(check-expect (checkbox-line "oranges")
              (beside (square 20 "outline" "black")
                      (text "oranges" 20 "black")))
              
;(define (checkbox-line s) empty-image) ;stub

(@template-origin String)

(@template
 (define (checkbox-line s)
   (... s)))
 
(define (checkbox-line s)
  (beside (square 20 "outline" "black")
          (text s 20 "black")))

