;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname naturals-starter) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require spd/tags)

(@assignment bank/naturals-l1)
(@cwl ???)

;; Now that we understand how to form data definitions for abitrary-sized data
;; we can look at how to design functions that "count down" on natural numbers. 
;; Here's the key insight - ask yourself how many natural numbers are there?
;;
;; A lot, many... an arbitrary number:
;;
;; 0                      ;0
;; (add1 0)               ;1
;; (add1 (add1 0))        ;2
;; (add1 (add1 (add1 0))) ;3
;;
;; and so on
;;
;; What that is saying is that (add1 <some natural>) produces a natural, 
;; similarly (sub1 <some natural other than 0>) produces a natural.
;;
;; So add1 is kind of like cons, it takes a natural and makes a bigger one 
;; (cons makes a longer list). And sub1 is kind of like rest it takes a natural
;; (other than 0) and gives the next smallest one (rest gives shorter list).
;;                                                                      
;;
;; Consider this type comment:


(@htdd Natural)
;; Natural is one of:
;;  - 0
;;  - (add1 Natural)
;; interp. a natural number
(define N0 0)         ;0
(define N1 (add1 N0)) ;1
(define N2 (add1 N1)) ;2

(@dd-template-rules one-of           ;2 cases
                    atomic-distinct  ;0
                    compound         ;(add1 Natural)
                    self-ref)        ;(sub1 n) is Natural

#;
(define (fn-for-natural n)
  (cond [(zero? n) (...)]
        [else
         (... n   ;template rules don't put this in
              ;   ;but it seems to be used a lot so
              ;   ;we added it
              (fn-for-natural (sub1 n)))]))


(@problem 1)
;; Design a function that consumes a Natural number n and produces the sum of
;; all the naturals in [0, n].
    




(@problem 2)
;; Design a function that consumes a Natural number n and produces a list of all
;; the naturals of the form (cons n (cons n-1 ... empty)) not including 0.


