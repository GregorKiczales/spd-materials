;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname l13-clickers) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require spd/tags)
(@htdd ListOfNumber)

;;
;; Problems 1 and 2
;;
;; Recall that the map2 definition was:

(define (map2 fn lst)
  (cond [(empty? lst) empty]
        [else
         (cons (fn (first lst))
               (map2 fn (rest lst)))]))

;; We want to use map2 to code the body of the following function:
(@htdf squares)
(@signature ListOfNumber -> ListOfNumber)
;; Produce list of squares of numbers in lst
(check-expect (squares (list 2 3 4)) (list 4 9 16))

(define (squares lon)
  (map2 A B))

;; 1 - What goes in A?  [70 seconds]
;;  (A) (sqr (first lon))  (B) empty  (C) lon  (D) sqr  (E)  (first lon)

;; 2 - What goes in B?  [20 seconds]
;;  (A) (sqr (first lon))  (B) empty  (C) lon  (D) sqr  (E)  (first lon)










 

;;
;; Problem 3  [45 seconds]
;;
;; Recall that the filter2 definition was:

(define (filter2 p lst)
  (cond [(empty? lst) empty]
        [else
         (if (p (first lst))
             (cons (first lst) (filter2 p (rest lst)))
             (filter2 p (rest lst)))]))

;; We want to use filter2 to code the body of the following function:

(@htdf positive-only)
(@signature ListOfNumber -> ListOfNumber)
;; Produce only positive numbers in lst
(check-expect (positive-only (list 2 -3 4)) (list 2 4))

(define (positive-only lon)
  (filter2 A B))

;; What goes in A?
;;   (A) (positive? (first lon)) (B) positive?  (C)  (first lon)




