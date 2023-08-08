;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname tuition-graph-c-solution) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/image)
(require spd/tags)

(@assignment bank/ref-p3)
(@cwl ???)

;; Remember the constants and data definitions we created to help Eva decide
;; where to go to university:


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
;; interp. name is the school's name
;;         tuition is international-students tuition in USD

(define S1 (make-school "School1" 27797)) ;We encourage you to look up real 
(define S2 (make-school "School2" 23300)) ;schools of interest to you
(define S3 (make-school "School3" 28500)) ;-- or any similar data.

(@dd-template-rules compound) ;(make-school String Natural)

#;
(define (fn-for-school s)
  (... (school-name s)
       (school-tuition s)))


(@htdd ListOfSchool)
;; ListOfSchool is one of:
;;  - empty
;;  - (cons School ListOfSchool)
;; interp. a list of schools
(define LOS1 empty)
(define LOS2 (cons S1 (cons S2 (cons S3 empty))))

(@dd-template-rules one-of          ;2 cases
                    atomic-distinct ;empty
                    compound        ;(cons School ListOfSchool)
                    ref             ;(first los) is School
                    self-ref)       ;(rest los) is ListOfSchool

#;
(define (fn-for-los los)
  (cond [(empty? los) (...)]
        [else
         (... (fn-for-school (first los))
              (fn-for-los (rest los)))]))


(@htdd ListOfNumber)
;; ListOfNumber is one of:
;;  - empty
;;  - (cons Number ListOfNumber)
;; interp. a list of numbers
(define LON1 empty)
(define LON2 (cons 60 (cons 42 empty)))

(@dd-template-rules one-of              ;2 cases
                    atomic-distinct     ;empty
                    compound            ;(cons Number ListOfNumber)
                    self-ref)           ;(rest lon) is ListOfNumber

#;
(define (fn-for-lon lon)
  (cond [(empty? lon) (...)]
        [else
         (... (first lon)
              (fn-for-lon (rest lon)))]))


(@htdd ListOfString)
;; ListOfString is one of: 
;;  - empty
;;  - (cons String ListOfString)
;; interp. a list of strings
(define LS0 empty) 
(define LS1 (cons "a" empty))
(define LS2 (cons "a" (cons "b" empty)))
(define LS3 (cons "c" (cons "b" (cons "a" empty))))

(@dd-template-rules one-of              ;2 cases
                    atomic-distinct     ;empty
                    compound            ;(cons String ListOfString)
                    self-ref)           ;(rest los) is ListOfString

#;
(define (fn-for-los los) 
  (cond [(empty? los) (...)]
        [else
         (... (first los)
              (fn-for-los (rest los)))]))



;; =================
;; Functions:

(@problem 1)
;; Design a function that consumes information about schools and produces 
;; the school with the lowest international student tuition.
;; 
;; The function should consume a ListOfSchool. Call it cheapest.
;; 
;; ;; ASSUME the list includes at least one school or else
;; ;;        the notion of cheapest doesn't make sense
;;
;; Also note that the template for a function that consumes a non-empty 
;; list is:
;;
;; (define (fn-for-nelox nelox)
;;   (cond [(empty? (rest nelox)) (...  (first nelox))] 
;;         [else
;;           (... (first nelox) 
;;                (fn-for-nelox (rest nelox)))]))
;;
;; And the template for a function that consumes two schools is: 
;;
;; (define (fn... s1 s2)
;; (... (school-name s1)
;;      (school-tuition s1)
;;      (school-name s2)
;;      (school-tuition s2)))


(@htdf cheapest)
(@signature ListOfSchool -> School)
;; produce the school with the lowest tuition
;; ASSUME the list includes at least one school or else
;;        the notion of cheapest doesn't make sense
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


(@problem 2)
;; Design a function that consumes a ListOfSchool and produces a list of the 
;; school names. Call it get-names.
;;
;;  Do you need to define a new helper function?

;; NOTE: ListOfString should be added to the data definitions above.


(@htdf get-names)
(@signature ListOfSchool -> ListOfString)
;; produce a list of the names of the schools in the given list
(check-expect (get-names LOS1) empty)
(check-expect (get-names LOS2)
              (cons "School1" (cons "School2" (cons "School3" empty))))

;(define (get-names los) empty)  ;stub

(@template-origin ListOfSchool)

(@template
 (define (get-names los)
   (cond [(empty? los) (...)]
         [else
          (... (fn-for-school (first los))
               (get-names (rest los)))])))

(define (get-names los)
  (cond [(empty? los) empty]
        [else
         (cons (school-name (first los))
               ;; NOTE: No separate helper function required
               ;; because there is already an existing function  
               ;; that operates on a School and does what we need.
               (get-names (rest los)))]))
