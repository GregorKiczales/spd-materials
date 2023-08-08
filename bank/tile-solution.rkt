;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname tile-solution) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/image)
(require spd/tags)

(@assignment bank/bsl-p3)
(@cwl ???)

(@problem 1)
;; Use the DrRacket square, beside and above functions to create an image
;; like the one in this link:
;;
;; https://cs110.students.cs.ubc.ca/bank/tile.png
;;
;; If you prefer to be more creative feel free to do so. You can use other
;; DrRacket image functions to make a more interesting or more attractive image.

(above (beside (square 20 "solid" "blue")
               (square 20 "solid" "yellow"))
       (beside (square 20 "solid" "yellow")
               (square 20 "solid" "blue")))
