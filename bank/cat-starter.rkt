;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname cat-starter) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/image)
(require 2htdp/universe)
(require spd/tags)

(@assignment bank/htdw-l1)
(@cwl ???)

(@problem 1)
;; Use the How to Design Worlds recipe to design an interactive
;; program in which a cat starts at the left edge of the display 
;; and then walks across the screen to the right. When the cat
;; reaches the right edge it should just keep going right off 
;; the screen.
;;
;; Once your design is complete revise it to add a new feature,
;; which is that pressing the space key should cause the cat to
;; go back to the left edge of the screen. When you do this, go
;; all the way back to your domain analysis and incorporate the
;; new feature.
;;
;; To help you get started, here is a picture of a cat, which we
;; have taken from the 2nd edition of the How to Design Programs book on which
;; this course is based. You can access it by following the link below.


;; =================
;; Constants:

(define CAT-IMG
  (bitmap/url
   "https://cs110.students.cs.ubc.ca/bank/cat-img.png"))

