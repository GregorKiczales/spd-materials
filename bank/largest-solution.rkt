;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname largest-solution) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require spd/tags)

(@assignment bank/self-ref-p5)
(@cwl ???)

;; =================
;; Data definitions:

;; Recall the data definition for a list of numbers:
;; (if this data definition does not look familiar, please review it)


(@htdd ListOfNumber)
;; ListOfNumber is one of:
;;  - empty
;;  - (cons Number ListOfNumber)
;; interp. a list of numbers
(define LON1 empty)
(define LON2 (cons 60 (cons 42 empty)))

(@dd-template-rules one-of               ;2 cases
                    atomic-distinct      ;empty
                    compound             ;(cons Number ListOfNumber)
                    self-ref)            ;(rest lon) is ListOfNumber
                    
#;
(define (fn-for-lon lon)
  (cond [(empty? lon) (...)]
        [else
         (... (first lon)
              (fn-for-lon (rest lon)))]))



;; =================
;; Functions:

(@problem 1)
;; Design a function that consumes a list of numbers and produces the largest 
;; number in the list. You may assume that all numbers in the list are greater
;;  than 0. If the list is empty, produce 0.


(@htdf largest)
(@signature ListOfNumber -> Number)
;; produce the largest number in the given list, or 0 if empty
;; ASSUMES that every element of lon is > 0
(check-expect (largest empty) 0)
(check-expect (largest LON2) 60)
(check-expect (largest (cons 10 (cons 20 (cons 50 empty)))) 50)

;(define (largest lon) 0) ;stub

(@template-origin ListOfNumber)

(@template
 (define (largest lon)
   (cond [(empty? lon) (...)]
         [else
          (... (first lon)
               (largest (rest lon)))])))

(define (largest lon)
  (cond [(empty? lon) 0]
        [else
         (if (> (first lon) (largest (rest lon)))
             (first lon)
             (largest (rest lon)))]))
