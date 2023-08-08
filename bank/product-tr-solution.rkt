;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-advanced-reader.ss" "lang")((modname product-tr-solution) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require spd/tags)

(@assignment bank/accumulators-p5)
(@cwl ???)

(@problem 1)
;; (A) Consider the following function that consumes a list of numbers and
;;     produces the product of all the numbers in the list. Use the stepper 
;;     to analyze the behavior of this function as the list gets larger and
;;     larger.
;;    
;; (B) Use an accumulator to design a tail-recursive version of product.


(@htdf product)
(@signature (listof Number) -> Number)
;; produce product of all elements of lon
(check-expect (product empty) 1)
(check-expect (product (list 2 3 4)) 24)

(@template-origin (listof Number))

#;
(define (product lon)
  (cond [(empty? lon) 1]
        [else
         (* (first lon)
            (product (rest lon)))]))

(@template-origin (listof Number) accumulator)

(define (product lon0)
  ;; acc: Number; the product of the elements of lon0 seen so far ;? is
  ;; (product (list 2 3 4))
  ;; 
  ;; (product (list 2 3 4) 1)
  ;; (product (list   3 4) 2)
  ;; (product (list     4) 6)
  ;; (product (list      ) 24)  
  (local [(define (product lon acc)
            (cond [(empty? lon) acc]
                  [else
                   (product (rest lon)
                            (* acc (first lon)))]))]
    (product lon0 1))) 
