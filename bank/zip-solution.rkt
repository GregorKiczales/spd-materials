;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname zip-solution) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require spd/tags)

(@assignment bank/zip)
(@cwl ???)

(@problem 1)

;; =================
;; Data Definitions:

(@htdd Entry)
(define-struct entry (k v))
;; Entry is (make-entry Number Number)
;; Interp. an entry maps a key to a value
(define E1 (make-entry 3 12))


(@htdd ListOfEntry)
;; ListOfEntry is one of:
;;  - empty
;;  - (cons Entry ListOfEntry)
;; interp. a list of key value entries
(define LOE1 (list E1 (make-entry 1 11)))


(@htdd ListOfNumber)
;; ListOfNumber is one of:
;;  - empty
;;  - (cons Number ListOfNumber)
;; interp. a list of numbers
(define LON0 empty)
(define LON1 (list 1 4 6 2))



;; =================
;; Functions:


(@htdf zip)
(@signature ListOfNumber ListOfNumber -> ListOfEntry)
;; given (list a0...) (list b0...) produce (list (make-entry a0 b0) ...)
;; CONSTRAINT: lsta and lstb have the same length
(check-expect (zip empty empty) empty)
(check-expect (zip (list 1 2) (list 11 12))
              (list (make-entry 1 11) (make-entry 2 12)))

#|
 CROSS PRODUCT OF TYPE COMMENTS TABLE   

                       lstb  empty         (cons Number ListOfNumber)

 lsta

 empty                       empty (1)         IMPOSSIBLE              

 (cons Number ListOfNumber)  IMPOSSIBLE       (cons (make-entry <firsts>) (2)
                                                    (zip (rest lsta)
                                                         (rest lstb)))

|#

;(define (zip lsta lstb) empty)

(@template-origin 2-one-of)

(define (zip lsta lstb)
  (cond [(empty? lsta) empty] ;(1)
        [else                 ;(2)
         (cons (make-entry (first lsta) (first lstb))
               (zip (rest lsta) (rest lstb)))]))
