;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname fractals-starter) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/image)
(require spd/tags)

(@assignment bank/genrec-l1)
(@cwl ???)

(@problem 1)
;; Design a function that consumes a number and produces a Sierpinski
;; triangle of that size. Your function should use generative recursion.
;;
;; One way to draw a Sierpinski triangle is to:
;; 
;;  - start with an equilateral triangle with side length s
;;
;; https://cs110.students.cs.ubc.ca/bank/stri1.png
;;     
;;  - inside that triangle are three more Sierpinski triangles
;;
;; https://cs110.students.cs.ubc.ca/bank/stri2.png
;;     
;;  - and inside each of those... and so on
;; 
;; So that you end up with something that looks like this:
;;
;; https://cs110.students.cs.ubc.ca/bank/stri3.png
;;   
;; Note that in the 2nd picture above the inner triangles are drawn in 
;; black and slightly smaller just to make them clear. In the real
;; Sierpinski triangle they should be in the same color and of side
;; length s/2. Also note that the center upside down triangle is not
;; an explicit triangle, it is simply formed from the other triangles.


(@problem 2)
;; Design a function to produce a Sierpinski carpet of size s.
;;
;; Here is an example of a larger Sierpinski carpet.
;;
;; https://cs110.students.cs.ubc.ca/bank/scarpet.png



