;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname m01-primitives-solution) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #t)))
(require 2htdp/image)
(require spd/tags)


(@assignment lectures/m01-primitives);Do not edit or remove this tag



(@problem 1)
;; 
;; Remember that the equation for the lengths of the sides in a
;; right triangle is:
;; 
;;   a^2 + b^2 = c^2
;; 
;;   c = sqrt ( a^2  +  b ^2) 
;; 
;; Write an expression to compute the length of side c when a is 3
;; and b is 4.  The name of the primitive that computes the square
;; root of a number is sqrt.  We want an expression that makes it
;; clear how the result was computed from 3 and 4 using the
;; equation above.  Do not just put 5.
;;


(sqrt (+ (sqr 3) (sqr 4)))




(@problem 2)
;; 
;; The background for the Canadian Flag (without the maple leaf) is two
;; red bands on either side of a white band. Write an expression to produce that
;; background. If you want to get the details right, officially the overall flag
;; has proportions 1:2, and the band widths are in the ratio 1:2:1.
;;

(beside (rectangle 100 200 "solid" "red")
	(rectangle 200 200 "solid" "white")
	(rectangle 100 200 "solid" "red"))
