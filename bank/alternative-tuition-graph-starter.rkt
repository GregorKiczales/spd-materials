;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname alternative-tuition-graph-starter) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/image)
(require spd/tags)

(@assignment bank/ref-p1)
(@cwl ???)

;; Consider the following alternative type comment for Eva's school tuition 
;; information program. Note that this is just a single type, with no reference,
;; but it captures all the same information as the two types solution in the 
;; videos.
;;
;; (define-struct school (name tuition next))
;; ;; School is one of:
;; ;;  - false
;; ;;  - (make-school String Natural School)
;; ;; interp. an arbitrary number of schools, where for each school we have its
;; ;;         name and its tuition in USD

(@problem 1)
;; Confirm for yourself that this is a well-formed self-referential data 
;; definition.


(@problem 2)
;; Complete the data definition making sure to define all the same examples as 
;; for ListOfSchool in the videos.


(@problem 3)
;; Design the chart function that consumes School. Save yourself time by simply
;; copying the tests over from the original version of chart.


(@problem 4)
;; Compare the two versions of chart. Which do you prefer? Why?

