;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname sum-n-solution) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require spd/tags)

(@assignment bank/abstraction-p7)
(@cwl ???)

(@problem 1)
;; Complete the design of the following function, by writing out 
;; the final function definition. Use at least one built in abstract 
;; function.


(@htdf sum-n-odds)
(@signature Natural -> Natural)
;; produce the sume of the first n odd numbers
(check-expect (sum-n-odds 0) 0)
(check-expect (sum-n-odds 1) (+ 0 1))
(check-expect (sum-n-odds 3) (+ 0 1 3 5))

;(define (sum-n-odds n) 0)  ;stub


;; HINT: The first n odd numbers are contained in the first 2*n naturals. 
;; For example (list 0 1 2 3) contains the first 4 naturals and the first 
;; 2 odd numbers. Also remember that DrRacket has a build in predicate 
;; function called odd?


;; SOLUTION CHOICE ONE:

(@template-origin use-abstract-fn fn-composition)

(define (sum-n-odds n)
  (foldr + 0 (filter odd? (build-list (* 2 n) identity))))

;; SOLUTION CHOICE TWO:

(@template-origin use-abstract-fn fn-composition)

#;
(define (sum-n-odds n)
  (local [(define (multiply i)
            (+ (* 2 i) 1))]
    (foldr + 0 (build-list n multiply))))
