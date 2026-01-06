;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname rocket-solution) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require spd/tags)

(@assignment bank/htdd-p3)
(@cwl ???)

;; =================
;; Data definitions:

(@problem 1)
;;
;; You are designing a program to track a rocket's journey as it descends 
;; 100 kilometers to Earth. You are only interested in the descent from 
;; 100 kilometers to touchdown. Once the rocket has landed it is done.
;;
;; Design a data definition to represent the rocket's remaining descent. 
;; Call it RocketDescent.  Use a mixed data itemization to clearly
;; distinguish the case of when has shutdown and the journey is over. 
;;

(@htdd RocketDescent)
;; RocketDescent is one of:
;; - Number
;; - false
;; interp. false if rocket's descent has ended, otherwise number of kilometers
;;         left to Earth
;; CONSTRAINT: Number is in (0, 100]
(define RD1 100)
(define RD2 40)
(define RD3 0.5)
(define RD4 false)

(@dd-template-rules one-of              ;2 cases
                    atomic-non-distinct ;Number
                    atomic-distinct)    ;false

(define (fn-for-rocket-descent rd)
  (cond [(number? rd) (... rd)]
        [else  (...)])) 



;; =================
;; Functions:

(@problem 2)
;; Design a function that will output the rocket's remaining descent distance 
;; in a short string that can be broadcast on Twitter. 
;; When the descent is over, the message should be "The rocket has landed!".
;; Call your function rocket-descent-to-msg.


(@htdf rocket-descent-to-msg)
(@signature RocketDescent -> String)
;; outputs a Twitter update on rocket's descent distance
(check-expect (rocket-descent-to-msg  100) "Altitude is 100 kms.")
(check-expect (rocket-descent-to-msg  40) "Altitude is 40 kms.")
(check-expect (rocket-descent-to-msg  .5) "Altitude is 1/2 kms.")
(check-expect (rocket-descent-to-msg  false) "The rocket has landed!")   

;(define (rocket-descent-to-msg rd) "")  ;stub

(@template-origin RocketDescent)

(@template
 (define (rocket-descent-to-msg rd)
   (cond [(number? rd) (... rd)]
         [else  (...)])))

(define (rocket-descent-to-msg rd)
  (cond [(number? rd)
         (string-append "Altitude is " (number->string rd) " kms.")]
        [else 
         "The rocket has landed!"])) 
