;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-advanced-reader.ss" "lang")((modname new-numerals-starter) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #t #t none #f () #f)))
(require spd/tags)

(@assignment bank/naturals-l1)
(@cwl ???)

(@problem 1)
;; Your friend has just given you a new device, and it runs a prototype version
;; of Racket. 
;;
;; This is great, you can make it do anything. There's just one problem, this
;; version of racket doesn't include numbers as primitive data. There just are
;; no numbers in it!
;;
;; But you need natural numbers to write your next program.
;;
;; No problem you say, because you remember the well-formed self-referential
;; data definition for Natural, as well as the idea that add1 is kind of like
;; cons, and sub1 is kind of like rest. Your idea is to make add1 actually be
;; cons, and sub1 actually be rest...
;;
;; Design a new data definition for natural numbers that does not involve
;; numbers as primitive data and design functions that perform addition,
;; subtraction, multiplication, and factorial.
