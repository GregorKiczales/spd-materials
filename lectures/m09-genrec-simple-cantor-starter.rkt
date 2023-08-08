;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname m09-genrec-simple-cantor-starter) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #t)))

(require 2htdp/image)
(require spd/tags) 
(@assignment lectures/m09-genrec-simple-cantor)

(@cwl ???) ;replace ??? with your cwl

(@problem 1)

;;
;; Design a function that consumes a width in pixels and produces a simple
;; cantor image of the given width.  For example, (cantor 400) might produce
;; an image like the one in:
;; https://cs110.students.cs.ubc.ca/lectures/m09-genrec-simple-cantor-image.png
;; (Ignore the pale grey areas if they show up in your browser.)



(define BAR-HEIGHT 20)
(define BAR-COLOR  "blue")

(define GAP-HEIGHT 4)

(define SPACER-COLOR "transparent")

(define CUTOFF 4)

(@htdf cantor)
(@signature Number -> Image)
;; Produce cantor set image of given width
;; CONSTRAINT: w >= 0








(define (cantor w) empty-image)







(@template-origin genrec)
#;
(define (genrec-fn d)
  ;; base case:
  ;; reduction:
  ;; argument: 
  
  (cond [(trivial? d) (trivial-answer d)]        
        [else         
         (... d              
              (genrec-fn (next-problem d)))]))
