;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname lec23-accs-and-python-loops-solution) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require spd/tags)
(require 2htdp/image)


(@htdf sum)
(@signature (listof Number) -> Number)
;; produces the sum of a list of numbers
(check-expect (sum empty) 0)
(check-expect (sum (list 1 2 3 4)) 10)

(@template (listof X) accumulator)

(define (sum lon0)
  ;; rsf is: Number; sum of numbers so far
  
  (local [(define (fn-for-lon lon rsf)      ;(listof X) template fn
            (cond [(empty? lon) rsf]        ;at end of list produce rsf
                  [else
                   (fn-for-lon (rest lon)
                               (+ rsf (first lon)))]))] ;update accumulator
    (fn-for-lon lon0 0)))

#|
// In Python this is

def sum(lon):
    res = 0              // initialize accumulator
    for n in lon:        // template for operating on list elements
        res = res+ n     // update accumulator
    return res           // produce accumulator value as result of function

|#



(@problem 1)

(@htdf doubles)
;; (listof Number) -> (listof Number)
;; produce a list of each number in lon times 2
(check-expect (doubles empty) empty)
(check-expect (doubles (list 1 2 3)) (list 2 4 6))

;(define (doubles lon) empty)

(@template (listof X) accumulator)

(define (doubles lon0)
  ;; acc is: (listof Number); all numbers passed so far * 2 
  (local [(define (fn-for-lon lon acc)
            (cond [(empty? lon) acc]
                  [else
                   (fn-for-lon (rest lon)
                               (append acc (list (* 2 (first lon)))))]))]
    (fn-for-lon lon0 empty)))

#|
// write the definition of the function in Python

def doubles(lox):
    res = []
    for x in lox:
        res = res+[2*x]
    return res

|#



(@problem 2)

(@htdf rev)
;; (listof X) -> (listof X)
;; produce the elements of lox in reverse order

(check-expect (rev empty) empty)
(check-expect (rev (list 1 2 3)) (list 3 2 1))

;(define (rev los) empty)

(@template (listof X) accumulator)

(define (rev lox0)
  ;; acc is: (listof x); list of all elements passed till now in reverse order
  (local [(define (fn-for-lox lox acc)
            (cond [(empty? lox) acc]
                  [else
                   (fn-for-lox (rest lox)
                               (cons (first lox) acc))]))]
    (fn-for-lox lox0 empty)))


#|
// write the definition of the function in Python

def rev(lox):
    acc = []
    for x in lox:
        acc = [x]+acc
    return acc

|#


(@problem 3)

(@htdf average)
(@signature(listof Number) -> Number)
;; produce average of numbers in lon
;; CONSTRAINT: lon has at least one element
(check-expect (average (list 1 2 3 4 5)) 3)

;(define (average lon) 0)

(@template (listof X) accumulator)

(define (average lon0)
  ;; sum, count are: Number, Number; sum of numbers, number of numbers
  (local [(define (fn-for-lon lon sum count)
            (cond [(empty? lon) (/ sum count)]
                  [else
                   (fn-for-lon (rest lon)
                               (+ sum (first lon))
                               (add1 count))]))]
    (fn-for-lon lon0 0 0)))

#|
// write the definition of the function in Python

def avg(lon):
    sum = 0
    count = 0
    for n in lon:
        sum = sum + n
        count = count + 1
    return sum / count

|#




