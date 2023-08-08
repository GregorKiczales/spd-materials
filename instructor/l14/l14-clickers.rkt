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















;; PROBLEM [45 seconds]
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


;; PROBLEM [45 seconds]
;;
;; In a world program in which the world state is a list of another type,
;; so (listof Egg) or (listof Ball or something), what built-in abstract
;; functions would you likely use to form the template for the to-draw handler.

;; [A]   map and foldr
;; [B]   build-list and  map
;; [C]   foldr
;; [D]   map
;; [E]   andmap


;; PROBLEM [45 seconds]
;;
;; Given the following function definition:
;;

(define (add-all a b c lon)
  (local [(define d (+ b c))
          (define (adder n)
            (+ n a d))]
    (map adder lon)))

;; What does (add-all 1 2 3 (list 6 7 8)) produce? [60 seconds]
;;
;;  [A] (list 7 8 9)
;;  [B] (list 11 12 13)
;;  [C] (list 12 13 14)
;;  [D] causes an error


;; What is the lifted defnition of adder? [45 seconds]
;;
;; [A] (define (adder_0 n) (+ n a d))
;; [B] (define (adder_0 n) (+ n 1 d))
;; [C] (define (adder_0 n) (+ n a d_0))
;; [D] (define (adder_0 n) (+ n 1 d_0))
;; [E] (define (adder_0 n) (+ n 1 5))
















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




