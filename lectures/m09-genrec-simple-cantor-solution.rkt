;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname m09-genrec-simple-cantor-solution) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #t)))
(require 2htdp/image)
(require spd/tags)
(@assignment lectures/m09-genrec-simple-cantor)

(@problem 1)

;; Design a function that consumes a width in pixels and produces a simple
;; cantor image of the given width.

(define BAR-HEIGHT 20)
(define BAR-COLOR  "blue")

(define GAP-HEIGHT 4)

(define SPACER-COLOR "transparent")

(define CUTOFF 4)

(@htdf cantor)
(@signature Number -> Image)
;; Produce cantor set image of given width
;; CONSTRAINT: w >= 0
(check-expect (cantor 0)
              (rectangle 0             BAR-HEIGHT "solid" BAR-COLOR))
(check-expect (cantor (sub1 CUTOFF))
              (rectangle (sub1 CUTOFF) BAR-HEIGHT "solid" BAR-COLOR))
(check-expect (cantor CUTOFF)    
              (rectangle CUTOFF        BAR-HEIGHT "solid" BAR-COLOR))

(check-expect (cantor (* 3 CUTOFF))
              (above (rectangle (* 3 CUTOFF) BAR-HEIGHT "solid" BAR-COLOR)
                     (rectangle (* 3 CUTOFF) GAP-HEIGHT "solid" SPACER-COLOR)
                     (beside (cantor CUTOFF)     
                             (rectangle CUTOFF BAR-HEIGHT "solid" SPACER-COLOR)
                             (cantor CUTOFF))))

(@template-origin genrec)

(define (cantor w)
  ;; base case:  w <= CUTOFF, (note CUTOFF is > 0)
  ;; reduction:  w / 3
  ;; argument:   repeated division by 3 approaches 0, so will get below CUTOFF 
  
  (cond [(<= w CUTOFF) (rectangle w BAR-HEIGHT "solid" BAR-COLOR)]
        [else      
         (local [(define w/3 (/ w 3))
                 (define top (rectangle w BAR-HEIGHT "solid" BAR-COLOR))
                 (define gap (rectangle w GAP-HEIGHT "solid" SPACER-COLOR))
                 (define l&r (cantor w/3))      
                 (define spc (rectangle w/3 BAR-HEIGHT "solid" SPACER-COLOR))]
           (above top    
                  gap
                  (beside l&r spc l&r)))]))
