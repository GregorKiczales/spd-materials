;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname graphs-gen-v2) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require spd/tags)

(@assignment bank/graphs-l1)
(@cwl ???)

(@problem 1)
;; Imagine you are suddenly transported into a mysterious house, in which all
;; you can see is the name of the room you are in, and any doors that lead OUT
;; of the room.  One of the things that makes the house so mysterious is that
;; the doors only go in one direction. You can't see the doors that lead into
;; the room.
;;
;; Here are some examples of such a house:
;;
;; https://cs110.students.cs.ubc.ca/bank/H1.png
;; https://cs110.students.cs.ubc.ca/bank/H2.png
;; https://cs110.students.cs.ubc.ca/bank/H3.png
;; https://cs110.students.cs.ubc.ca/bank/H4.png
;;
;; In computer science, we refer to such an information structure as a directed
;; graph. Like trees, in directed graphs the arrows have direction. But in a
;; graph it is  possible to go in circles, as in the second example above. It
;; is also possible for two arrows to lead into a single node, as in the fourth
;; example.
;;
;;   
;; Design a data definition to represent such houses. Also provide example data
;; for the four houses above.

;; =================
;; Data Definitions: 

;; Images corresponding to the example data are in the links above each example

(@htdd Room)
(define-struct room (name exits))
;; Room is (make-room String (listof String))
;; interp. the room's name, and list of names of rooms that the exits lead to
