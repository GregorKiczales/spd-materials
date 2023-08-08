;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname tuition-graph-v3) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/image)
(require spd/tags)

(@assignment bank/ref-l1)
(@cwl ???)

;;   tuition-graph-starter.rkt  (just the problem statements)
;;   tuition-graph-v1.rkt       (includes constants)
;;   tuition-graph-v2.rkt       (includes complete School and
;;                               ListOfSchool type comment)
;; > tuition-graph-v3.rkt       (includes both complete data definitions)
;;   tuition-graph-v4.rkt       (includes complete chart function)
;;   tuition-graph-v5.rkt       (includes partial cheapest function)
;;   tuition-graph-v6.rkt       (complete)

(@problem 1)
;; Eva is trying to decide where to go to university. One important factor for
;; her is tuition costs. Eva is a visual thinker, and has taken Systematic 
;; Program Design, so she decides to design a program that will help her 
;; visualize the costs at different schools. She decides to start simply, 
;; knowing she can revise her design later.
;;
;; The information she has so far is the names of some schools as well as their 
;; international student tuition costs. She would like to be able to represent
;; that information in bar charts like the one at this link:
;;
;; https://cs110.students.cs.ubc.ca/bank/graph.png
;;        
;; (A) Design data definitions to represent the information Eva has.
;; (B) Design a function that consumes information about schools and their
;;     tuition and produces a bar chart.
;; (C) Design a function that consumes information about schools and produces
;;     the school with the lowest international student tuition.


;; =================
;; Constants:

(define FONT-SIZE 24)
(define FONT-COLOR "black")

(define Y-SCALE   1/200)
(define BAR-WIDTH 30)
(define BAR-COLOR "lightblue")



;; =================
;; Data definitions:

(@htdd School)
(define-struct school (name tuition))
;; School is (make-school String Natural)
;; interp. name is the school's name,
;;         tuition is international-students tuition in USD

(define S1 (make-school "School1" 27797)) ;We encourage you to look up real 
(define S2 (make-school "School2" 23300)) ;schools of interest to you -- or any
(define S3 (make-school "School3" 28500)) ;similar data.

(@dd-template-rules compound) ;2 fields

#;
(define (fn-for-school s)
  (... (school-name s)      ;String
       (school-tuition s))) ;Natural


(@htdd ListOfSchool)
;; ListOfSchool is one of:
;;  - empty
;;  - (cons School ListOfSchool)
;; interp. a list of schools
(define LOS1 empty)
(define LOS2 (cons S1 (cons S2 (cons S3 empty))))

(@dd-template-rules one-of           ;2 cases
                    atomic-distinct  ;empty
                    compound         ;(cons School ListOfSchool)
                    ref              ;(first los) is School
                    self-ref)        ;(rest los) is ListOfSchool

#;
(define (fn-for-los los)
  (cond [(empty? los) (...)]
        [else
         (... (fn-for-school (first los))
              (fn-for-los (rest los)))]))



;; =================
;; Functions:

