;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname graphs-gen-v1) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
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
;; Here is an exampls of such a house:
;;
;; https://cs110.students.cs.ubc.ca/bank/H4.png
;;
;; In computer science, we refer to such an information structure as a directed
;; graph. Like trees, in directed graphs the arrows have direction. But in a
;; graph it is  possible to go in circles, as in rooms B and C. It is also
;; possible for two arrows to lead into a single node, as in room E.
;;
;;   
;; Design a data definition to represent such houses. Also provide example data
;; for the house above.

