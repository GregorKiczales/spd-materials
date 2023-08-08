;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname abstract-sum-solution) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require spd/tags)

(@assignment bank/abstraction-p3)
(@cwl ???)

(@problem 1)
;; Design an abstract function (including signature, purpose, and tests) to 
;; simplify the two sum-of functions. 


(@htdf abstract-sum)
(@signature (X -> Number) (listof X) -> Number)
;; Produce sum of calling fn on every element of lox.
(check-expect (abstract-sum string-length empty) 0)
(check-expect (abstract-sum string-length (list "a" "bc" "def")) 6)
(check-expect (abstract-sum sqr (list 2 4)) (+ 4 16))

(@template-origin (listof X))

(define (abstract-sum fn lox)
  (cond [(empty? lox) 0]
        [else
         (+ (fn (first lox))
            (abstract-sum fn (rest lox)))]))


(@problem 2)
;; Now re-define the original functions to use the new abstract function. 
;;
;; Remember, the signature and tests should not change from the original 
;; functions.


(@htdf sum-of-squares)
(@signature (listof Number) -> Number)
;; produce the sum of the squares of the numbers in lon
(check-expect (sum-of-squares empty) 0)
(check-expect (sum-of-squares (list 2 4)) (+ 4 16))

(@template-origin use-abstract-fn)

(define (sum-of-squares lon) (abstract-sum sqr lon))


(@htdf sum-of-lengths)
(@signature (listof String) -> Number)
;; produce the sum of the lengths of the strings in los
(check-expect (sum-of-lengths empty) 0)
(check-expect (sum-of-lengths (list "a" "bc")) 3)

(@template-origin use-abstract-fn)

(define (sum-of-lengths los) (abstract-sum string-length los))


;; For reference, here are the function definitions for the two original 
;; functions.

;; (@htdf sum-of-squares)
;; (@signature (listof Number) -> Number)
;; ;; produce the sum of the squares of the numbers in lon
;; (check-expect (sum-of-squares empty) 0)
;; (check-expect (sum-of-squares (list 2 4)) (+ 4 16))
;;
;; (@template-origin (listof Number))
;;
;; (define (sum-of-squares lon)
;;   (cond [(empty? lon) 0]
;;         [else
;;          (+ (sqr (first lon))
;;             (sum-of-squares (rest lon)))]))
;;
;;
;; (@htdf sum-of-lengths)
;; (@signature (listof String) -> Number)
;; ;; produce the sum of the lengths of the strings in los
;; (check-expect (sum-of-lengths empty) 0)
;; (check-expect (sum-of-lengths (list "a" "bc")) 3)
;;
;; (@template-origin (listof String))
;;
;; (define (sum-of-lengths los)
;;   (cond [(empty? los) 0]
;;         [else
;;          (+ (string-length (first los))
;;             (sum-of-lengths (rest los)))]))

