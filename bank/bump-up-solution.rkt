;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname bump-up-solution) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require spd/tags)

(@assignment bank/htdd-l7)
(@cwl ???)

(@problem 1)
;; Using the LetterGrade data definition below design a function that
;; consumes a letter grade and produces the next highest letter grade. 
;; Call your function bump-up.


;; =================
;; Data definitions:

(@htdd LetterGrade)
;; LetterGrade is one of: 
;;  - "A"
;;  - "B"
;;  - "C"
;; interp. the letter grade in a course
;; <examples are redundant for enumerations>

(@dd-template-rules one-of           ;3 cases
                    atomic-distinct  ;"A"
                    atomic-distinct  ;"B"
                    atomic-distinct) ;"C"
#;
(define (fn-for-letter-grade lg)
  (cond [(string=? lg "A") (...)]
        [(string=? lg "B") (...)]
        [(string=? lg "C") (...)]))



;; =================
;; Functions:

(@htdf bump-up)
(@signature LetterGrade -> LetterGrade)
;; produce next highest letter grade (no change for A)
(check-expect (bump-up "A") "A")
(check-expect (bump-up "B") "A")
(check-expect (bump-up "C") "B")

;(define (bump-up lg) "A") ;stub

(@template-origin LetterGrade)

(@template
 (define (bump-up lg)
   (cond [(string=? lg "A") (...)]
         [(string=? lg "B") (...)]
         [(string=? lg "C") (...)])))

(define (bump-up lg)
  (cond [(string=? lg "A") "A"]
        [(string=? lg "B") "A"]
        [(string=? lg "C") "B"]))
