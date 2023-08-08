;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname demolish-solution) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require spd/tags)

(@assignment bank/htdd-p2)
(@cwl ???)

;; =================
;; Data definitions:

(@problem 1)
;; You are assigned to develop a system that will classify 
;; buildings in downtown Vancouver based on how old they are. 
;; According to city guidelines, there are three different classification
;; levels: new, old, and heritage.
;;
;; Design a data definition to represent these classification levels. 
;; Call it BuildingStatus.


(@htdd BuildingStatus)
;; BuildingStatus is one of:
;; - "new"
;; - "old"
;; - "heritage"
;; interp. classification of a building based on age
;; examples redundant in enumeration

(@dd-template-rules one-of           ;3 cases
                    atomic-distinct  ;"new"
                    atomic-distinct  ;"old"
                    atomic-distinct) ;"heritage"

#;
(define (fn-for-building-status bs)
  (cond [(string=? "new" bs) (...)]
        [(string=? "old" bs) (...)]
        [(string=? "heritage" bs) (...)]))



;; =================
;; Functions:

(@problem 2)
;; The city wants to demolish all buildings classified as "old". 
;; You are hired to design a function called demolish? 
;; that determines whether a building should be torn down or not.

(@htdf demolish?)
(@signature BuildingStatus -> Boolean)
;; produces true if building is "old" and should be demolished
(check-expect (demolish? "new") false)
(check-expect (demolish? "old") true)
(check-expect (demolish? "heritage") false)

; (define (demolish? bs) true)

(@template-origin BuildingStatus)

(@template
 (define (demolish? bs)
   (cond [(string=? "new" bs) (...)]
         [(string=? "old" bs) (...)]
         [(string=? "heritage" bs) (...)])))

(define (demolish? bs)
  (cond [(string=? "new" bs) false]
        [(string=? "old" bs) true]
        [(string=? "heritage" bs) false]))
