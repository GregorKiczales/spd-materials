;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname mt2-p3-solution) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #t)))
(require spd/tags)

(@assignment bank/evaluate-local-3)
(@cwl ???)

(@problem 1)


;;
;; Given the following definition:
;;

(define (foo x y)
  (local [(define (bar x z)
            (list x y z))
          (define (baz x y)
            (local [(define (bar z)
                      (list x y z))]
              (* 2 x y)))]
    (bar x (baz x y))))

(foo 1 2)

;; write THE LIFTED DEFINITIONS BELOW HERE

(define (bar_0 x z)
  (list x 2 z))

(define (baz_0 x y)
  (local [(define (bar z)
            (list x y z))]
    (* 2 x y)))

(define (bar_1 z)
  (list 1 2 z))



;; write the LIFTED DEFINITIONS ABOVE HERE



#| ;DO ANY SCRATCH WORK BELOW THIS LINE


|# ;DO ANY SCRATCH WORK ABOVE THIS LINE
