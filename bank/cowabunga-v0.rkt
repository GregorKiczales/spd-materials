;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname cowabunga-v0) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/image)
(require 2htdp/universe)
(require spd/tags)

(@assignment bank/compound-l3)
(@cwl ???)

;;   cowabunga-starter.rkt  problem statement
;; > cowabunga-v0.rkt       has constants
;;   cowabunga-v1.rkt       has data definition
;;   cowabunga-v2.rkt       has main function, wish list entries
;;   cowabunga-v3.rkt       has next-cow
;;   cowabunga-v4.rkt       has render-cow
;;   cowabunga-v5.rkt       has handle-key
;;   cowabunga-v6.rkt       waddles

(@problem 1)

;; A cow, meandering back and forth across the screen.

;(@htdw WS)

;; =================
;; Constants:

(define WIDTH  400)
(define HEIGHT 200)


(define CTR-Y (/ HEIGHT 2)) 


(define RCOW
  (bitmap/url
   "https://cs110.students.cs.ubc.ca/bank/rcow.png"))
(define LCOW
  (bitmap/url
   "https://cs110.students.cs.ubc.ca/bank/lcow.png"))


(define MTS (empty-scene WIDTH HEIGHT))



;; =================
;; Data definitions:



;; =================
;; Functions:
