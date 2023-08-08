;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname render-roster-starter) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/image)
(require spd/tags)

(@assignment bank/helpers-p1)
(@cwl ???)

;; You are running a dodgeball tournament and are given a list of all
;; of the players in a particular game as well as their team numbers.  
;; You need to build a game roster like the one in the link below. We've given
;; you some constants and data definitions for Player, ListOfPlayer 
;; and ListOfString to work with. 
;;
;; While you're working on these problems, make sure to keep your 
;; helper rules in mind and use helper functions when necessary.
;;
;; https://cs110.students.cs.ubc.ca/bank/roster.png


;; =================
;; Constants:

(define CELL-WIDTH 200)
(define CELL-HEIGHT 30)

(define TEXT-SIZE 20)
(define TEXT-COLOR "black")



;; =================
;; Data Definitions:

(@htdd Player)
(define-struct player (name team))
;; Player is (make-player String Natural)
;; interp. a dodgeball player. 
;;   (make-player s t) represents the player named s 
;;   who plays on team t, either 1 or 2
;; 
(define P0 (make-player "Samael" 1))
(define P1 (make-player "Georgia" 2))

(@dd-template-rules compound) ;2 fields

#;
(define (fn-for-player p)
  (... (player-name p)
       (player-team p)))


(@htdd ListOfPlayer)
;; ListOfPlayer is one of:
;; - empty
;; - (cons Player ListOfPlayer)
;; interp.  A list of players.
(define LOP0 empty)                     ;; no players
(define LOP2 (cons P0 (cons P1 empty))) ;; two players

(@dd-template-rules one-of          ;2 cases
                    atomic-distinct ;empty
                    compound        ;(cons Player ListOfPlayer)
                    ref             ;(first lop) is Player
                    self-ref)       ;(rest lop) is ListOfPlayer

#;
(define (fn-for-lop lop)
  (cond [(empty? lop) (...)]
        [else
         (... (fn-for-player (first lop))
              (fn-for-lop (rest lop)))]))


(@htdd ListOfString)
;; ListOfString is one of:
;; - empty
;; - (cons String ListOfString)
;; interp. a list of strings
(define LOS0 empty)
(define LOS2 (cons "Samael" (cons "Georgia" empty)))

(@dd-template-rules one-of              ;2 cases
                    atomic-distinct     ;empty
                    compound            ;(cons String ListOfString)
                    self-ref)           ;(rest los) is ListOfString

#;
(define (fn-for-los los)
  (cond [(empty? los) (...)]
        [else
         (... (first los)
              (fn-for-los (rest los)))]))



;; =================
;; Functions:

(@problem 1)
;; Design a function called select-players that consumes a list 
;; of players and a team t (Natural, either 1 or 2) and produces a list of 
;; players that are on team t.



(@problem 2)
;; Complete the design of render-roster. We've started you off with 
;; the signature, purpose, stub and examples. You'll need to use
;; the function that you designed in Problem 1.
;;
;; Note that we've also given you a full function design for render-los
;; and its helper, render-cell. You will need to use these functions
;; when solving this problem.


(@htdf render-roster)
(@signature ListOfPlayer -> Image)
;; Render a game roster from the given list of players

(check-expect (render-roster empty)
              (beside/align 
               "top"
               (overlay
                (text "Team 1" TEXT-SIZE TEXT-COLOR)
                (rectangle CELL-WIDTH CELL-HEIGHT "outline" TEXT-COLOR))
               (overlay
                (text "Team 2" TEXT-SIZE TEXT-COLOR)
                (rectangle CELL-WIDTH CELL-HEIGHT "outline" TEXT-COLOR))))
                
(check-expect (render-roster LOP2)
              (beside/align 
               "top"
               (above
                (overlay
                 (text "Team 1" TEXT-SIZE TEXT-COLOR)
                 (rectangle CELL-WIDTH CELL-HEIGHT "outline" TEXT-COLOR))
                (overlay
                 (text "Samael" TEXT-SIZE TEXT-COLOR)
                 (rectangle CELL-WIDTH CELL-HEIGHT "outline" TEXT-COLOR)))
               (above
                (overlay
                 (text "Team 2" TEXT-SIZE TEXT-COLOR)
                 (rectangle CELL-WIDTH CELL-HEIGHT "outline" TEXT-COLOR))
                (overlay
                 (text "Georgia" TEXT-SIZE TEXT-COLOR)
                 (rectangle CELL-WIDTH CELL-HEIGHT "outline" TEXT-COLOR)))))

(define (render-roster lop) empty-image) ; stub








(@htdf render-los)
(@signature ListOfString -> Image)
;; Render a list of strings as a column of cells.
(check-expect (render-los empty) empty-image)
(check-expect (render-los (cons "Samael" empty))
              (above 
               (overlay
                (text "Samael" TEXT-SIZE TEXT-COLOR)
                (rectangle CELL-WIDTH CELL-HEIGHT "outline" TEXT-COLOR))
                     empty-image))
(check-expect (render-los (cons "Samael" (cons "Brigid" empty)))
              (above
                (overlay
                (text "Samael" TEXT-SIZE TEXT-COLOR)
                (rectangle CELL-WIDTH CELL-HEIGHT "outline" TEXT-COLOR))
               (overlay
                (text "Brigid" TEXT-SIZE TEXT-COLOR)
                (rectangle CELL-WIDTH CELL-HEIGHT "outline" TEXT-COLOR))))

;(define (render-los lon) empty-image) ; stub

(@template-origin ListOfString)

(define (render-los los)
  (cond [(empty? los) empty-image]
        [else
         (above (render-cell (first los))
                (render-los (rest los)))]))


(@htdf render-cell)
(@signature String -> Image)
;; Render a cell of the game table
(check-expect (render-cell "Team 1") 
              (overlay
                 (text "Team 1" TEXT-SIZE TEXT-COLOR)
                 (rectangle CELL-WIDTH CELL-HEIGHT "outline" TEXT-COLOR)))

;(define (render-cell s) empty-image) ; stub

(@template-origin String)

(define (render-cell s)
  (overlay
   (text s TEXT-SIZE TEXT-COLOR)
   (rectangle CELL-WIDTH CELL-HEIGHT "outline" TEXT-COLOR)))

