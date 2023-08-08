;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname direction-solution) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require spd/tags)

(@assignment bank/htdd-p8)
(@cwl ???)

(@problem 1)
;; Given the data definition below, design a function named left 
;; that consumes a compass direction and produces the direction 
;; that results from making a 90 degree left turn.


;; =================
;; Data definitions:

(@htdd Direction)
;; Direction is one of:
;;  - "N"
;;  - "S"
;;  - "E"
;;  - "W"
;; interp. a compass direction that a player can be facing
;; <examples are redundant for enumerations>

(@dd-template-rules one-of           ;4 cases
                    atomic-distinct  ;"N"
                    atomic-distinct  ;"S"
                    atomic-distinct  ;"E"
                    atomic-distinct) ;"W"

#;
(define (fn-for-direction d)
  (cond [(string=? d "N") (...)]
        [(string=? d "S") (...)]
        [(string=? d "E") (...)]
        [(string=? d "W") (...)]))



;; =================
;; Functions:

(@htdf left)
(@signature Direction -> Direction)
;; direction resulting from facing d and turning 90 degrees left
(check-expect (left "N") "W")
(check-expect (left "S") "E")
(check-expect (left "E") "N")
(check-expect (left "W") "S")

;(define (left d) "N") ; stub

(@template-origin Direction)

(@template
 (define (left d)
   (cond [(string=? d "N") (...)]
         [(string=? d "S") (...)]
         [(string=? d "E") (...)]
         [(string=? d "W") (...)])))

(define (left d)
  (cond [(string=? d "N") "W"]
        [(string=? d "S") "E"]
        [(string=? d "E") "N"]
        [(string=? d "W") "S"]))
