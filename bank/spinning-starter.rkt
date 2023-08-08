;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname spinning-starter) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/image)
(require 2htdp/universe)
(require spd/tags)

(@assignment bank/compound-p2)
(@cwl ???)

(@problem 1)
;; Design a world program as follows:
;;
;; The world starts off with a small square at the center of the screen. As
;; time passes, the square stays fixed at the center, but increases in size and
;; rotates at a constant speed. Pressing the spacebar resets the world so that
;; the square is small and unrotated.
;;
;; Starting display:
;; https://cs110.students.cs.ubc.ca/bank/spinning-start.png
;;
;; After a few seconds:
;; https://cs110.students.cs.ubc.ca/bank/spinning-after.png
;;
;; After a few more seconds:
;; https://cs110.students.cs.ubc.ca/bank/spinning-more.png
;;
;; Immediately after pressing the spacebar:
;; https://cs110.students.cs.ubc.ca/bank/spinning-press.png
;;
;; NOTE 1: Remember to follow the HtDW recipe! Be sure to do a proper domain 
;; analysis before starting to work on the code file.
;;
;; NOTE 2: The rotate function requires an angle in degrees as its first 
;; argument. By that it means Number[0, 360). As time goes by the box may end
;; up spinning more than once, for example, you may get to a point where it has
;; spun 362 degrees, which rotate won't accept. One solution to that is to use
;; the remainder function as follows:
;;
;; (rotate (remainder ... 360) (text "hello" 30 "black"))
;;
;; where ... can be an expression that produces any positive number of degrees 
;; and remainder will produce a number in [0, 360).
;;
;; Remember that you can lookup the documentation of rotate if you need to know 
;; more about it.
;;
;; NOTE 3: There is a way to do this without using compound data. But you
;; should design the compound data based solution.

