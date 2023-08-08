;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname cartesian-starter) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require spd/tags)

(@assignment bank/htdf-p9)
(@cwl ???)

(@problem 1)
;; In interactive games it is often useful to be able to determine the distance
;; between two points on the screen. We can describe those points using
;; Cartesian coordinates as four numbers: x1, y1 and x2, y2. 
;; The formula for the distance between those points is found in this link:
;;
;; https://s3.amazonaws.com/edx-course-spdx-kiczales/HTC/
;;  problems/cartesian-formula.png
;;
;; Use the How to Design Functions (HtDF) recipe to design a function called
;; distance that consumes four numbers representing two points and produces the
;; distance between the two points. Use (distance 3 0 0 4), which should
;; produce 5 as your first example/test. Once your function works with that
;; test, try (distance 1 0 0 1) which should produce (sqrt 2). Read the error
;; message carefully and use the help desk to figure out how to use check-within
;; for this case.
;;
;; Remember, when we say DESIGN, we mean follow the recipe.
;; 
;; Leave behind a commented out version of the stub.
;;
;; NOTE:
;;
;; The signature for such a function is:
;;
;; (@signature Number Number Number Number -> Number)
;;
;; The template-origin and template tags for such a function are:
;;
;; (@template-origin Number)
;;
;; (@template (define (distance x1 y1 x2 y2)
;;              (... x1 y1 x2 y2)))
