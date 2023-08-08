;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname cflag-solution) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/image)
(require spd/tags)

(@assignment bank/bsl-p8)
(@cwl ???)

(@problem 1)
;; You can see the background for the Canadian Flag (without the maple leaf)
;; by using this link:
;;
;; https://cs110.students.cs.ubc.ca/bank/cflag.png
;;
;; Write an expression to produce that background. (If you want to get the
;; details right, officially the overall flag has proportions 1:2, and the 
;; band widths are in the ratio 1:2:1.)



(beside (rectangle 20 40 "solid" "red")
        (rectangle 40 40 "solid" "white")
        (rectangle 20 40 "solid" "red"))

