;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname tuition-graph-v6) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/image)
(require spd/tags)

(@assignment bank/ref-l1)
(@cwl ???)

;;   tuition-graph-starter.rkt  (just the problem statements)
;;   tuition-graph-v1.rkt       (includes constants)
;;   tuition-graph-v2.rkt       (includes complete School and
;;                               ListOfSchool type comment)
;;   tuition-graph-v3.rkt       (includes both complete data definitions)
;;   tuition-graph-v4.rkt       (includes complete chart function)
;;   tuition-graph-v5.rkt       (includes partial cheapest function)
;; > tuition-graph-v6.rkt       (complete)

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

(@htdf chart)
(@signature ListOfSchool -> Image)
;; produce bar chart showing names and tuitions of consumed schools
(check-expect (chart empty) empty-image)
(check-expect (chart (cons (make-school "S1" 8000) empty))
              (beside/align "bottom"
                            (overlay/align "center" "bottom"
                                           (rotate 90 (text "S1"
                                                            FONT-SIZE
                                                            FONT-COLOR))
                                           (rectangle BAR-WIDTH
                                                      (* 8000 Y-SCALE)
                                                      "outline"
                                                      "black")
                                           (rectangle BAR-WIDTH
                                                      (* 8000 Y-SCALE)
                                                      "solid"
                                                      BAR-COLOR))
                            empty-image))
(check-expect (chart (cons (make-school "S2" 12000) 
                           (cons (make-school "S1" 8000) 
                                 empty)))
              (beside/align "bottom"
                            (overlay/align "center" "bottom"
                                           (rotate 90 (text "S2"
                                                            FONT-SIZE
                                                            FONT-COLOR))
                                           (rectangle BAR-WIDTH
                                                      (* 12000 Y-SCALE)
                                                      "outline"
                                                      "black")
                                           (rectangle BAR-WIDTH
                                                      (* 12000 Y-SCALE)
                                                      "solid"
                                                      BAR-COLOR))
                            (overlay/align "center" "bottom"
                                           (rotate 90 (text "S1"
                                                            FONT-SIZE
                                                            FONT-COLOR))
                                           (rectangle BAR-WIDTH
                                                      (* 8000 Y-SCALE)
                                                      "outline"
                                                      "black")
                                           (rectangle BAR-WIDTH
                                                      (* 8000 Y-SCALE)
                                                      "solid"
                                                      BAR-COLOR))
                            empty-image))

;(define (chart los) empty-image) ;stub

(@template-origin ListOfSchool)

(@template
 (define (chart los)
   (cond [(empty? los) (...)]
         [else
          (... (fn-for-school (first los))
               (chart (rest los)))])))

(define (chart los)
  (cond [(empty? los) empty-image]
        [else
         (beside/align "bottom"
                       (make-bar (first los))
                       (chart (rest los)))])) 


(@htdf make-bar)
(@signature School -> Image)
;; produce the bar for a single school in the bar chart
(check-expect (make-bar (make-school "S1" 8000))
              (overlay/align "center" "bottom"
                             (rotate 90 (text "S1" FONT-SIZE FONT-COLOR))
                             (rectangle BAR-WIDTH
                                        (* 8000 Y-SCALE)
                                        "outline"
                                        "black")
                             (rectangle BAR-WIDTH
                                        (* 8000 Y-SCALE)
                                        "solid"
                                        BAR-COLOR)))

;(define (make-bar s) empty-image) ;stub

(@template-origin School)

(@template
 (define (make-bar s)
   (... (school-name s)   
        (school-tuition s))))

(define (make-bar s)
  (overlay/align "center" "bottom"
                 (rotate 90 (text (school-name s) FONT-SIZE FONT-COLOR))
                 (rectangle BAR-WIDTH
                            (* (school-tuition s) Y-SCALE)
                            "outline"
                            "black")
                 (rectangle BAR-WIDTH
                            (* (school-tuition s) Y-SCALE)
                            "solid"
                            BAR-COLOR)))


(@htdf cheapest)
(@signature ListOfSchool -> School)
;; produce the school with the lowest tuition
;; CONSTRAINT: the list includes at least one school
(check-expect (cheapest (cons S1 empty)) S1)
(check-expect (cheapest (cons S1 (cons S2 (cons S3 empty)))) S2)

;(define (cheapest los) (make-school "" 0)) ;stub

(@template-origin ListOfSchool)

(@template
 (define (cheapest los)
   (cond [(empty? los) (...)]
         [else
          (... (fn-for-school (first los))
               (cheapest (rest los)))])))

(define (cheapest los)
  ;; NOTE: Change to base case test here, for this
  ;;       function the base case is when the list
  ;;       has one element.
  (cond [(empty? (rest los)) (first los)]
        [else
         (if (cheaper? (first los) (cheapest (rest los)))
             (first los)
             (cheapest (rest los)))]))


(@htdf cheaper?)
(@signature School School -> Boolean)
;; produce true if tuition of s1 is < tuition of s2
(check-expect (cheaper? (make-school "a" 3) (make-school "b" 4)) true)
(check-expect (cheaper? (make-school "a" 4) (make-school "b" 4)) false)
(check-expect (cheaper? (make-school "a" 5) (make-school "b" 4)) false)

;(define (cheaper? s1 s2) false) ;stub

(@template-origin School)

(@template
 (define (cheaper? s1 s2)
   (... (school-name s1)   
        (school-tuition s1)
        (school-name s2)   
        (school-tuition s2))))

(define (cheaper? s1 s2)
  (< (school-tuition s1) (school-tuition s2)))
