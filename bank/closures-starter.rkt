;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname closures-starter) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/image)
(require spd/tags)

(@assignment bank/abstraction-l3)
(@cwl ???)


;; Some setup data and functions to enable more interesting examples
;; below

(define I1 (rectangle 10 20 "solid" "red"))
(define I2 (rectangle 30 20 "solid" "yellow"))
(define I3 (rectangle 40 50 "solid" "green"))
(define I4 (rectangle 60 50 "solid" "blue"))
(define I5 (rectangle 90 90 "solid" "orange"))

(define LOI1 (list I1 I2 I3 I4 I5))


;; NOTE: Unlike using-built-ins-starter.rkt this file does not define
;; the functions tall? wide? square? and area.


(@problem 1)
;; Complete the design of the following functions by completing the body
;; which has already been templated to use a built-in abstract list function.


(@htdf wide-only)
(@signature (listof Image) -> (listof Image))
;; produce list of only those images that have width > height
(check-expect (wide-only (list I1 I2 I3 I4 I5)) (list I2 I4)) 

(define (wide-only loi) empty) ;stub

#;
(define (wide-only loi) 
  (filter ... loi))


(@htdf wider-than-only)
(@signature Number (listof Image) -> (listof Image))
;; produce list of only those images in loi with width > w
(check-expect (wider-than-only 40 LOI1) (list I4 I5))

(define (wider-than-only w loi) empty) ;stub

#;
(define (wider-than-only w loi)
  (filter ... loi))


(@htdf cube-all)
(@signature (listof Number) -> (listof Number))
;; produce list of each number in lon cubed
(check-expect (cube-all (list 1 2 3)) (list (* 1 1 1) (* 2 2 2) (* 3 3 3)))

(define (cube-all lon) empty) ;stub

#;
(define (cube-all lon)
  (map ... lon))


(@htdf prefix-all)
(@signature String (listof String) -> (listof String))
;; produce list of all elements of los prefixed by p
(check-expect (prefix-all "accio " (list "portkey" "broom"))
              (list "accio portkey" "accio broom"))

(define (prefix-all p los) empty) ;stub

#;
(define (prefix-all p los)
  (map ... los))



