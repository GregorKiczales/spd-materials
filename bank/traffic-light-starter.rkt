;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname traffic-light-starter) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/image)
(require 2htdp/universe)
(require spd/tags)

(@assignment bank/htdw-p2)
(@cwl ???)

(@problem 1)
;; Design an animation of a traffic light. 
;; 
;; Your program should show a traffic light that is red, then green, 
;; then yellow, then red etc. For this program, your changing world 
;; state data definition should be an enumeration.
;;
;; The link below shows what your program might look like if the initial world 
;; state was the red traffic light:
;;
;; https://cs110.students.cs.ubc.ca/bank/r-traffic.png
;;
;; Next:
;;
;; https://cs110.students.cs.ubc.ca/bank/g-traffic.png
;
;; Next:
;; 
;; https://cs110.students.cs.ubc.ca/bank/y-traffic.png
;;
;; Next is red, and so on.
;;
;; To make your lights change at a reasonable speed, you can use the 
;; rate option to on-tick. If you say, for example, (on-tick next-color 1) 
;; then big-bang will wait 1 second between calls to next-color.
;;
;; Remember to follow the HtDW recipe! Be sure to do a proper domain 
;; analysis before starting to work on the code file.
;; 
;; Note: If you want to design a slightly simpler version of the program,
;; you can modify it to display a single circle that changes color, rather
;; than three stacked circles. 


