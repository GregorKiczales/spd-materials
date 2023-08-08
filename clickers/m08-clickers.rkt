;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname m08-clickers) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
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

;; 1 - What goes in A?  [90 seconds]
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
















;; Problem 1 [60 seconds]
;;
;; If we take the (listof X) template and turn it into an
;; abstract function by replacing ... with parameters and
;; renaming we get this.


(define (foldr fn b lox)
  (cond [(empty? lox) b]
        [else
         (fn (first lox)
             (foldr fn b (rest lox)))]))

;; What is the signature for this function?
;;
;;  [A] (X -> Y) Y (listof X) -> Y
;;
;;  [B] (Y X -> Y) Y (listof X) -> Y
;;
;;  [C] (X Y -> Y) Y (listof X) -> Y
;;
;;  [D] (X -> X) X (listof X) -> X















;; Problem 2 [60 seconds]
;;
;; In a world program in which the world state is a list of a non-primitive
;; type, so (listof Egg) or (listof Ball) or something like that, which option
;; below would be the most appropriate on-tick handler tag and template using
;; built in abstract functions?  (Just consider these choices.)
#|

;; [A]
(@template-origin function-composition use-abstract-fn)
(define (tock lox)
  (filter ... (map ... lox)))

;; [B]
(@template-origin use-abstract-fn)
(define (tock lox)
  (foldr ... lox))

;; [C]
(@template-origin use-abstract-fn)
(define (tock lox)
  (filter ... lox))

;; [D]
(@template-origin function-composition use-abstract-fn)
(define (tock lox)
  (map ... (filter ... lox)))

|#


;; Problem 3 [45 seconds]
;;
;; In a world program in which the world state is a list of another type,
;; so (listof Egg) or (listof Ball or something), what built-in abstract
;; functions would you likely use to form the template for the to-draw handler.

;; [A]   map and foldr
;; [B]   build-list and  map
;; [C]   foldr
;; [D]   map
;; [E]   andmap

















;; Problem 4 [20 seconds]
;;
;; Given
;; 
(define (positive-only lon) (filter positive? lon))

;; What does (positive-only (list 1 -2 3 -4)) produce?
;;
;;  [A] false
;;  [B] 1
;;  [C] true
;;  [D] (list 1 3)

















;; Problem 5 [10 seconds]
;;
;; Given
;;
(define (negative-only lon)
  (filter negative? lon))

;; What does (negative-only (list 1 -2 3 -4)) produce?
;;
;;  [A] (list -2 -4)
















;; Problem 6 [10 seconds]
;;
;; Given
;;
(define (foo x lon)
  (local [(define (? n) (= n x))]
    (filter ? lon)))

(foo 3 (list 1 2 3 2 4 3 5 1))


;; What does (foo 3 (list 1 2 3 2 4 3 5 1)) produce?
;;
;;  [A] (list 3 3)






