;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname m01-functions-solution) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #t)))
(require 2htdp/image)
(require spd/tags)

(@assignment lectures/m01-functions);Do not edit or remove this tag



;;
;; Already we can start to build up complex results, such as:
;;
;;
;; (above (circle 40 "solid" "red")         
;;       (circle 40 "solid" "yellow")
;;       (circle 40 "solid" "green"))
;;


(define (bulb c)
  (circle 40 "solid" c)) ;body

(above (bulb "red")
       (bulb "yellow")
       (bulb "green"))

       



(@problem 1)
;; 
;; Write a function that will help eliminate the
;; redundancy in the following expressions:
;; 

;(* 3.14 (sqr 3))
;(* 3.14 (sqr 6))
;(* 3.14 (sqr 2.5))

(define (area r)
  (* 3.14 (sqr r)))

(area 3)
(area 6)
(area 2.5)





(@problem 2)
;;
;; Consider this function:
;;

(define (silly x)
  (* 2 (sqr x)))

;;
;; Write out the step-by-step evaluation of: 
;;
(silly (* 1 3))

(silly 3)
(* 2 (sqr 3))
(* 2 9)
18




