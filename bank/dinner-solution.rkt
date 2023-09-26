;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname dinner-solution) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require spd/tags)

(@assignment bank/htdd-p9)
(@cwl ???)

;; =================
;; Data definitions:

(@problem 1)
;; You are working on a system that will automate delivery for 
;; YesItCanFly! airlines catering service. 
;; There are three dinner options for each passenger, chicken, pasta 
;; or no dinner at all. 
;;
;; Design a data definition to represent a dinner order. Call the type 
;; DinnerOrder.


(@htdd DinnerOrder)
;; DinnerOrder is one of:
;;  - "No dinner"
;;  - "Chicken"
;;  - "Pasta"
;; interp. "No dinner" means the passenger does not want dinner, 
;;         the other values are dinner options
;; <examples are redundant for enumerations>

(@dd-template-rules one-of           ;3 cases
                    atomic-distinct  ;"No dinner"
                    atomic-distinct  ;"Chicken"
                    atomic-distinct) ;"Pasta"


(define (fn-for-dinner-order d)
  (cond [(string=? d "No dinner") (...)]
        [(string=? d "Chicken") (...)]
        [(string=? d "Pasta") (...)]))



;; =================
;; Functions:

(@problem 2)
;; Design the function dinner-order-to-msg that consumes a dinner order 
;; and produces a message for the flight attendants saying what the
;; passenger ordered. 
;;
;; For example, calling dinner-order-to-msg for a chicken dinner would
;; produce "The passenger ordered chicken."


(@htdf dinner-order-to-msg)
(@signature DinnerOrder -> String)
;; produce message to describe what passenger ordered
(check-expect (dinner-order-to-msg "No dinner")
              "The passenger did not order dinner.")
(check-expect (dinner-order-to-msg "Chicken")
              "The passenger ordered chicken.")
(check-expect (dinner-order-to-msg "Pasta")
              "The passenger ordered pasta.")

;(define (dinner-order-to-msg d) "d")  ;stub

(@template-origin DinnerOrder)

(@template
 (define (dinner-order-to-msg d)
   (cond [(string=? d "No dinner") (...)]
         [(string=? d "Chicken") (...)]
         [(string=? d "Pasta") (...)])))

(define (dinner-order-to-msg d)
  (cond [(string=? d "No dinner") "The passenger did not order dinner."]
        [(string=? d "Chicken") "The passenger ordered chicken."]
        [(string=? d "Pasta") "The passenger ordered pasta."]))
