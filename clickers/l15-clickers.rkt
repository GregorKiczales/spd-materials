;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname l15-clickers) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require spd/tags)










(@htdf silly)
(@signature (listof Number) -> (listof Number))
;; a silly little function on lists of numbers
(check-expect (silly empty) empty)
(check-expect (silly (list 8 4 12 9 10 1 2 3 4))
              (list 8 4 1))

(define (silly lon)
  (if (empty? lon)
      empty
      (local [(define f (first lon))
              (define (<f? x) (< x f))]
        (cons f
              (silly (filter <f? (rest lon)))))))

;; PROBLEM 1 [100 seconds]
;;
;; Does silly always terminate?  Meaning for any list we call it with,
;; does it always produce a result?
;;  (A) YES   (B) NO
;;
;;
;; PROBLEM 2 [20 seconds]
;;
;; What is the base case test for silly?
;;  (A) filter    (B) (rest lon)  (C) lon is empty  (D) 1
;;
;;
;; PROBLEM 3 [30 seconds]
;;
;; What is the reduction step for silly?
;;  (A) (rest lon)    (B) (first lon)  (C) elements of (rest lon) < (first lon)
;;

















(@htdf hailstones)
(@signature Integer -> (listof Integer))
;; produce hailstone sequence for n
;; CONSTRAINT integers in argument and result are >=1
(check-expect (hailstones 1) (list 1))
(check-expect (hailstones 2) (list 2 1))
(check-expect (hailstones 4) (list 4 2 1))
(check-expect (hailstones 5) (list 5 16 8 4 2 1))

(define (hailstones n)
  (if (= n 1) 
      (list 1)
      (cons n 
            (if (even? n)
                (hailstones (/ n 2))
                (hailstones (add1 (* n 3)))))))

;; PROBLEM 4
;;
;; What is the base case test for hailstones?
;;  (A) (even? n)    (B) (add1 (* n 3))  (C) (= n 1)  (D) (/ n 2)
;;
;;
;; PROBLEM 5
;;
;; The reduction step for hailstones is:
;;   if n is even  then  n/2
;;   if n is odd   then  n*3 + 1
;;
;; does hailstones terminate?
;;  (A) Yes   (B) No
;;