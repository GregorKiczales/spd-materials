;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname countdown-starter) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require spd/tags)

(@assignment bank/htdd-l5)
(@cwl ???)

(@problem 1)
;; Consider designing the system for controlling a New Year's Eve
;; display. Design a data definition to represent the current state 
;; of the countdown, which falls into one of three categories: 
;;
;;  - not yet started
;;  - from 10 to 1 seconds before midnight
;;  - complete (Happy New Year!)
