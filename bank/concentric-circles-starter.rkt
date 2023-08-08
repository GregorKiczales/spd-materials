;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname concentric-circles-starter) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/image)
(require spd/tags)

(@assignment bank/naturals-p4)
(@cwl ???)

(@problem 1)
;; Design a function that consumes a natural number n and a color c, and
;; produces n concentric circles of the given color.
;;
;; So (concentric-circles 5 "black") should produce the image here:
;; https://cs110.students.cs.ubc.ca/bank/con-circ.png
