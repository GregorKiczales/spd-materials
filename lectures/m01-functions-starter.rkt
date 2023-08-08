;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname m01-functions-starter) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #t)))
(require 2htdp/image)
(require spd/tags)


(@assignment lectures/m01-functions);Do not edit or remove this tag

(@cwl ???) ;replace ??? by your CWL


;; *****************************************************************************
;; NOTE:
;;
;; Your AUTOGRADER RESULTS will be found at the following address:
;;
;;    https://cs110.students.cs.ubc.ca/handback/12345678/
;;
;; Where you must replace 12345678 with your UBC student number.  You will need
;; to login with your CWL and CWL password.
;;
;;  For lecture starters you can get some feedback from the autograder during
;;  lecture, provided you can submit a file that passes the Check Syntax button
;;  at the top right of the Dr Racket window.
;;
;;  Especially at first it can be hard to get all your ( ) and "  " properly
;;  balanced, and so you might not be able to pass the Check Syntax.  If that
;;  happens then first start by getting the gist of the problem right.  You
;;  can (and should) go back after lecture to work the problem until you
;;  get autograder feedback saying it is 100% correct.
;;
;;  But for problem sets, labs, and exams you should not submit your file if
;;  Check Syntax produces an error.  Fix the error first, then submit.
;; *****************************************************************************


;;
;; Already we can start to build up complex results, such as:
;;

(above (circle 40 "solid" "red")         
       (circle 40 "solid" "yellow")
       (circle 40 "solid" "green"))





(@problem 1)
;; 
;; Write a function called area that will help eliminate the
;; redundancy in the following expressions:
;; 

(* 3.14 (sqr 3))
(* 3.14 (sqr 6))
(* 3.14 (sqr 2.5))









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



