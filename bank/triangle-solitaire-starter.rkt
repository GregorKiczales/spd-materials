;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname triangle-solitaire-starter) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/image)
(require spd/tags)

(@assignment bank/search-p2)
(@cwl ???)

(@problem 1)
;; The game of trianguar peg solitaire is described at a number of web sites,
;; including http://www.mathsisfun.com/games/triangle-peg-solitaire/#. 
;;
;; We would like you to design a program to solve triangular peg solitaire
;; boards. Your program should include a function called solve that consumes
;; a board and produces a solution for it, or false if the board is not
;; solvable. Read the rest of this problem box VERY CAREFULLY, it contains
;; both hints and additional constraints on your solution.
;;
;; The key elements of the game are:
;;
;;   - there is a BOARD with 15 cells, each of which can either
;;     be empty or contain a peg (empty or full).
;;    
;;   - a potential JUMP whenever there are 3 holes in a row
;;  
;;   - a VALID JUMP  whenever from and over positions contain
;;     a peg (are full) and the to position is empty
;;    
;;   - the game starts with a board that has a single empty
;;     position
;;    
;;   - the game ends when there is only one peg left - a single
;;     full cell                                                       
;;    
;; Here is one sample sequence of play, in which the player miraculously does
;; not make a single incorrect move. (A move they have to backtrack from.) No
;; one is actually that lucky! Use the link below to view an image of the
;; sequence.
;;
;; https://cs110.students.cs.ubc.ca/bank/tsolitaire.png


