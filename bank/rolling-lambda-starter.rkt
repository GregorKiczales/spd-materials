;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname rolling-lambda-starter) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/image)
(require 2htdp/universe)
(require spd/tags)

(@assignment bank/compound-p7)
(@cwl ???)

(@problem 1)
;; Design a world program as follows:
;; 
;; The world starts off with a lambda on the left hand side of the screen. As 
;; time passes, the lambda will roll towards the right hand side of the screen. 
;; Clicking the mouse changes the direction the lambda is rolling (ie from 
;; left -> right to right -> left). If the lambda hits the side of the window 
;; it should also change direction.
;;
;; Starting display (rolling to the right):
;;
;; https://cs110.students.cs.ubc.ca/bank/lambda.png
;;
;; After a few seconds (rolling to the right):
;;
;; https://cs110.students.cs.ubc.ca/bank/lambda2.png
;;
;; After a few more seconds (rolling to the right):
;;
;; https://cs110.students.cs.ubc.ca/bank/lambda3.png
;;
;; A few seconds after clicking the mouse (rolling to the left):
;;
;; https://cs110.students.cs.ubc.ca/bank/lambda4.png
;; 
;; NOTE 1: Remember to follow the HtDW recipe! Be sure to do a proper domain 
;; analysis before starting to work on the code file.
;;
;; NOTE 2: DO THIS PROBLEM IN STAGES.
;;
;; FIRST
;;
;; Just make the lambda slide back and forth across the screen without rolling.
;;      
;; SECOND
;;  
;; Make the lambda spin as it slides, but don't worry about making the spinning
;; be just exactly right to make it look like its rolling. Just have it 
;; spinning and sliding back and forth across the screen.
;;
;; FINALLY
;;
;; Work out the math you need to in order to make the lambda look like it is
;; actually rolling.  Remember that the circumference of a circle is
;; 2*pi*radius, so that for each degree of rotation the circle needs to move:
;;
;;    2*pi*radius
;;    -----------
;;        360
;;
;; Also note that the rotate function requires an angle in degrees as its 
;; first argument.
;;
;; (rotate ... LAMBDA)
;;
;; where ... can be an expression that produces any number of degrees.
