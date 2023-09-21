;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname m01-htdf-starter) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #t)))
(require 2htdp/image)
(require spd/tags)

(@assignment lectures/m01-htdf)

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


(@problem 1)
;;
;; Design a function, called topple, that takes an image and rotates it 
;; by 90 degrees.
;;




(@problem 2)
;;
;; Design a function, that consumes an image and determines whether it is tall.
;;



(@problem 3)
;;
;; Design a function, called image>?, that takes two images and determines 
;; whether the first is larger than the second.
;; For this function we are giving you the htdf tag, signature, template-origin
;; and template below.
;;

;(@htdf image>?) ;UNCOMMENT THIS LINE WHEN YOU START THIS PROBLEM
(@signature Image Image -> Boolean)

(@template-origin Image)

(@template
 (define (image>? i1 i2)
   (... i1 i2)))





