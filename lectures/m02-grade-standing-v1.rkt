;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname m02-grade-standing-solution) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #t)))

(require spd/tags)

(@assignment lectures/m02-grade-standing)


(@problem 1)
(@htdd GradeStanding)
;; GradeStanding is one of:       MIXED DATA ITEMIZATION
;;  - Natural
;;  - "H"
;;  - "P"
;;  - "F"
;;  - "T"
;; interp. a percent grade OR standing
;; CONSTRAINT: If natural is in [0, 100]
(define GS1 10)
(define GS2 "H")

(@dd-template-rules one-of               ;5 cases
                    atomic-non-distinct  ;Natural
                    atomic-distinct      ;"H"
                    atomic-distinct      ;"P"
                    atomic-distinct      ;"T"
                    atomic-distinct)     ;"F"

;; initial template, w/ all guarding
;(define (fn-for-grade-standing gs)
;  (cond;[                  (<= 0 gs 100)  (... gs)] ;NO!
;       ;[(and (number? gs) (<= 0 gs 100)) (... gs)] ;OK, not needed this term
;        [     (number? gs)                (... gs)] ;can be simpler like this
;        [(and (string? gs) (string=? gs "H")) (...)]
;        [(and (string? gs) (string=? gs "P")) (...)]
;        [(and (string? gs) (string=? gs "T")) (...)]
;        [else (...)])) 

;; with guard simplification
(define (fn-for-grade-standing gs)
  (cond [(number? gs) (... gs)] 
        [(string=? gs "H") (...)]
        [(string=? gs "P") (...)]
        [(string=? gs "F") (...)]
        [else (...)]))            ;template rules page asks for else as the
;                                 ;last question in an itemization.  You
;                                 ;might be tempted to use (string=? gs "F")
;                                 ;in this case since the last four subclasses
;                                 ;of the itemization look like they form
;                                 ;an enumeration

;(@htdf excellent?)

(@problem 2)
;(@htdf grade->string)
