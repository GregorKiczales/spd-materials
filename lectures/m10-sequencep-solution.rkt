;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname m10-sequencep-solution) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #t)))
(require spd/tags)
(@assignment lectures/m10-sequencep)


(@problem 1)

(@htdf sequence?)

(@signature (listof Natural) -> Boolean)
;; produces true if the list is a strict sequence
(check-expect (sequence? (list))       true)
(check-expect (sequence? (list 2))     true)
(check-expect (sequence? (list 2 3 4)) true)
(check-expect (sequence? (list 3 5 6)) false)

(@template-origin (listof Natural) accumulator)

(define (sequence? lon0)
  ;; prev is  Natural
  ;; invariant: the element of lon0 immediately before (first lon)
  ;; (sequence? (list 2 3 4 5 6))      
  
  ;; (sequence? (list   3 4 5 6) 2)  
  ;; (sequence? (list     4 5 6) 3)
  ;; (sequence? (list       5 6) 4)
  (local [(define (sequence? lon prev)
            (cond [(empty? lon) true]     
                  [else           
                   (if (= (first lon) (+ 1 prev)) ;exploit
                       (sequence? (rest lon)
                                  (first lon))    ;preserve
                       false)]))]

    (if (empty? lon0)                ;if original list is empty, we can't
        true                         ;initialize accumulator, so special case
        (sequence? (rest lon0)     
                   (first lon0)))))  ;initialize

