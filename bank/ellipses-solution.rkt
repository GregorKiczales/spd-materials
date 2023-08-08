;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname ellipses-solution) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/image)
(require spd/tags)

(@assignment bank/abstraction-p5)
(@cwl ???)


;; =================
;; Constants:



;; =================
;; Functions:

(@problem 1)
;; Use build-list to write an expression (an expression, not a function) to 
;; produce a list of 20 ellipses ranging in width from 0 to 19.
;;
;; NOTE: Assuming n refers to a number, the expression 
;; (ellipse n (* 2 n) "solid" "blue") will produce an ellipse twice as tall 
;; as it is wide.


(local [(define (produce-one-ellipse n)
          (ellipse n (* 2 n) "solid" "blue"))]
  (build-list 20 produce-one-ellipse))


(@problem 2)
;; Write an expression using one of the other built-in abstract functions
;; to put the ellipses beside each other in a single image like this:
;;
;; https://cs110.students.cs.ubc.ca/bank/ellipses-f.png
;;
;; HINT: If you are unsure how to proceed, first do part A, and then design a 
;; traditional function operating on lists to do the job. Then think about 
;; which abstract list function to use based on that.


(local [(define (produce-one-ellipse n)
          (ellipse n (* 2 n) "solid" "blue"))]
  (foldr beside empty-image (build-list 20 produce-one-ellipse)))


(@problem 3)
;; By just using a different built in list function write an expression 
;; to put the ellipses beside each other in a single image like this:
;;
;; https://cs110.students.cs.ubc.ca/bank/ellipses-b.png


(local [(define (produce-one-ellipse n)
          (ellipse n (* 2 n) "solid" "blue"))]
  (foldl beside empty-image (build-list 20 produce-one-ellipse)))
