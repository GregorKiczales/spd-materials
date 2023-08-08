;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname l14-clickers) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

;; Problem 1 [45 seconds]
;;
;; If we take the (listof X) template and turn it into an
;; abstract function by replacing ... with parameters and
;; renaming we get this.

#;
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















;; Problem 2 [45 seconds]
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




