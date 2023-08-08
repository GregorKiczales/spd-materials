;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname alternative-tuition-graph-solution) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
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


;; It is because it has a self-reference case and a base case.


(@problem 2)
;; Complete the data definition making sure to define all the same examples as 
;; for ListOfSchool in the videos.


;; =================
;; Data Definitions:

(@htdd School)
(define-struct school (name tuition next))
;; School is one of:
;;  - false
;;  - (make-school String Natural School)
;; interp. an arbitrary number of schools, where for each school we have its
;;         name and its tuition in USD

(define S1 false)
(define S2 (make-school "School1" 27797 
                        (make-school "School2" 23300 
                                     (make-school "School3" 28500 false))))

(@dd-template-rules one-of              ;2 cases
                    atomic-distinct     ;false
                    compound            ;(make-school String Natural School)
                    self-ref)           ;(school-next s) is School

#;
(define (fn-for-school s)
  (cond [(false? s) (...)]
        [else 
         (...(school-name s)
             (school-tuition s)
             (fn-for-school(school-next s)))]))


(@problem 3)
;; Design the chart function that consumes School. Save yourself time by simply
;; copying the tests over from the original version of chart.


;; =================
;; Constants:

(define FONT-SIZE 24)
(define FONT-COLOR "black")

(define Y-SCALE   1/200)
(define BAR-WIDTH 30)
(define BAR-COLOR "lightblue")



;; =================
;; Functions:

(@htdf chart)
(@signature School -> Image)
;; produce bar chart showing names and tuitions of consumed schools
(check-expect (chart false) empty-image)
(check-expect (chart (make-school "S1" 8000 false))
              (beside/align
               "bottom"
               (overlay/align "center" "bottom"
                              (rotate 90 (text "S1" FONT-SIZE FONT-COLOR))
                              (rectangle BAR-WIDTH (* 8000 Y-SCALE)
                                         "outline" "black")
                              (rectangle BAR-WIDTH (* 8000 Y-SCALE)
                                         "solid" BAR-COLOR))
               empty-image))

(check-expect (chart (make-school "S2" 12000 (make-school "S1" 8000 false))) 
              (beside/align
               "bottom"
               (overlay/align "center" "bottom"
                              (rotate 90 (text "S2" FONT-SIZE FONT-COLOR))
                              (rectangle BAR-WIDTH (* 12000 Y-SCALE)
                                         "outline" "black")
                              (rectangle BAR-WIDTH (* 12000 Y-SCALE)
                                         "solid" BAR-COLOR))
               (overlay/align "center" "bottom"
                              (rotate 90 (text "S1" FONT-SIZE FONT-COLOR))
                              (rectangle BAR-WIDTH (* 8000 Y-SCALE)
                                         "outline" "black")
                              (rectangle BAR-WIDTH (* 8000 Y-SCALE)
                                         "solid" BAR-COLOR))
               empty-image))

;(define (chart s) empty-image) ;stub

(@template-origin School)

(@template
 (define (chart s)
   (cond [(false? s) (...)]
         [else 
          (...(school-name s)
              (school-tuition s)
              (chart (school-next s)))])))

(define (chart s)
  (cond [(false? s) empty-image]
        [else
         (beside/align
          "bottom" 
          (overlay/align "center" "bottom"
                         (rotate 90 (text (school-name s) FONT-SIZE FONT-COLOR))
                         (rectangle BAR-WIDTH (* (school-tuition s) Y-SCALE)
                                    "outline" "black")
                         (rectangle BAR-WIDTH (* (school-tuition s) Y-SCALE)
                                    "solid" BAR-COLOR))
          (chart (school-next s)))])) 


(@problem 4)
;; Compare the two versions of chart. Which do you prefer? Why?


;; We prefer the first solution, because chart is broken into two functions - 
;; one does the bar for each school, the other recurses through the list calling
;; the first function and composing those results into a single chart.
;;
;; For that reason we prefer the first data definition, because it will force 
;; all functions operating  on ListOfSchool to have this 2 part structure.

