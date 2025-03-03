;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname triangle-solution) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/image)
(require spd/tags)

(@assignment bank/bsl-p10)
(@cwl ???)

(@problem 1)
;; Write an expression that uses triangle, overlay, and rotate to produce an
;; image similar to the one at this link:
;;
;; https://cs110.students.cs.ubc.ca/bank/triangle.png
;;                                  
;; You can consult the DrRacket help desk for information on how to use
;; triangle and overlay. Don't worry about the exact size of the triangles.


(overlay (triangle 50 "solid" "green")
         (rotate 180 
                 (triangle 50 "solid" "yellow")))
