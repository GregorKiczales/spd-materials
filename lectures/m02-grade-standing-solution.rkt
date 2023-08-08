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


(@htdf excellent?)
(@signature GradeStanding -> Boolean)
;; produce true if percentage mark is 90 or greater
(check-expect (excellent? 91) true)
(check-expect (excellent? 90) true) 
(check-expect (excellent? 89) false) 
(check-expect (excellent? 80) false) 
(check-expect (excellent? 0) false)
(check-expect (excellent? "H") false)
(check-expect (excellent? "P") false)
(check-expect (excellent? "F") false)
(check-expect (excellent? "T") false)


;(define (excellent? gs) false) ;stub

(@template-origin GradeStanding)

(@template
 (define (excellent? gs)
   (cond [(number? gs) (... gs)] 
         [(string=? gs "H") (...)]
         [(string=? gs "P") (...)]
         [(string=? gs "F") (...)]
         [else (...)])))

;; when working with a template that has a cond from a one-of type
;; not allowed to reduce number of questions or edit questions
(define (excellent? gs)
  (cond [(number? gs) (>= gs 90)] 
        [(string=? gs "H") false]
        [(string=? gs "P") false]
        [(string=? gs "F") false]
        [else false]))

;; Here's a good example of the danger of editing the cond questions
;; this code seems right, but because the questions have been edited
;; the code is no longer type safe -- that means it can call primitive
;; operations on the wrong kind of data.
;(define (excellent? gs)
;  (cond [(and (number? gs) (>= gs 90)) true]
;        [(string=? gs "H") false]
;        [(string=? gs "P") false]
;        [(string=? gs "F") false]
;        [else false]))

;; This runs properly but is not allowed.
;(define (excellent? gs)
;  (cond [(number? gs) (>= gs 90)]
;        [else false]))

;; Neither is this.
;(define (excellent? gs)
;  (and (number? gs) (>= gs 90)))

(@problem 2)
(@htdf grade->string)
(@signature GradeStanding -> String)
;; produce string form of grade
(check-expect (grade->string 90) "90%")
(check-expect (grade->string 80) "80%")
(check-expect (grade->string "H") "H")
(check-expect (grade->string "P") "P")
(check-expect (grade->string "F") "F")
(check-expect (grade->string "T") "T")


;(define (grade->string gs) "") ;stub

(@template-origin GradeStanding)

(@template
 (define (grade->string gs)
   (cond [(number? gs) (... gs)] 
         [(string=? gs "H") (...)]
         [(string=? gs "P") (...)]
         [(string=? gs "F") (...)]
         [else (...)]))) 

(define (grade->string gs)
  (cond [(number? gs) (string-append (number->string gs) "%")] 
        [(string=? gs "H") "H"]
        [(string=? gs "P") "P"]
        [(string=? gs "F") "F"]
        [else "T"]))
