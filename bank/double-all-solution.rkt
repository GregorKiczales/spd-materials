;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname double-all-solution) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require spd/tags)

(@assignment bank/self-ref-p2)
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

(@dd-template-rules one-of          ;2 cases
                    atomic-distinct ;empty
                    compound        ;(cons Number ListOfNumber)
                    self-ref)       ;(rest lon) is ListOfNumber

#;
(define (fn-for-lon lon)
  (cond [(empty? lon) (...)]
        [else
         (... (first lon)
              (fn-for-lon (rest lon)))]))



;; =================
;; Functions:

(@problem 1)
;; Design a function that consumes a list of numbers and doubles every number 
;; in the list. Call it double-all.


(@htdf double-all)
(@signature ListOfNumber -> ListOfNumber)
;; double every number in the given list
(check-expect (double-all empty) empty)
(check-expect (double-all LON2) (cons  120 (cons 84 empty)))
(check-expect (double-all (cons 10 (cons 20 (cons 50 empty))))
              (cons 20 (cons 40 (cons 100 empty))))

;(define (double-all lon) empty) ;stub

(@template-origin ListOfNumber)

(@template
 (define (double-all lon)
   (cond [(empty? lon) (...)]
         [else
          (... (first lon)
               (double-all (rest lon)))])))

(define (double-all lon)
  (cond [(empty? lon) empty]
        [else
         (cons (* 2 (first lon))
               (double-all (rest lon)))]))

