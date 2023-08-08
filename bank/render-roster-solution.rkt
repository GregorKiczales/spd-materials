;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname render-roster-solution) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
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

(@htdf select-players)
(@signature ListOfPlayer Natural -> ListOfPlayer)
;; produce the list of given players who are on a given team
(check-expect (select-players empty 1) empty)
(check-expect (select-players empty 2) empty)
(check-expect (select-players 
               (cons (make-player "Samael" 1)
                     (cons (make-player "Georgia" 2)
                           (cons (make-player "John" 1) empty))) 2)
              (cons (make-player "Georgia" 2) empty))
 
;(define (select-players lop t) empty) ; stub

(@template-origin ListOfPlayer)

#;
(define (select-players lop t) ; template
  (cond [(empty? lop) (... t)]
        [else
         (... t (fn-for-player (first lop))
              (select-players (rest lop) t))]))

(define (select-players lop t)
  (cond [(empty? lop) empty]
        [else
         (if (on-team? (first lop) t)
             (cons (first lop) (select-players (rest lop) t))             
             (select-players (rest lop) t))]))


(@htdf on-team?)
(@signature Player Natural -> Boolean)
;; produce true if the given player is on the given team, otherwise false.
(check-expect (on-team? (make-player "Georgia" 1) 1) true)
(check-expect (on-team? (make-player "Samael" 2) 1) false)

;(define (on-team? p t) false) ; stub 

(@template-origin Player)

#;
(define (on-team? p t) ; template
  (... t (player-name p)
         (player-team p)))

(define (on-team? p t) ; template
  (= t (player-team p)))


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

;(define (render-roster lop) empty-image) ; stub

(@template-origin fn-composition)

(define (render-roster lop)
  (beside/align "top"
                (render-team (select-players lop 1) 1)
                (render-team (select-players lop 2) 2)))


(@htdf render-team)
(@signature ListOfPlayer Natural -> Image)
;; given a list of players lop on team t, render an image of the roster.
;; ASSUME: All the players in lop are on team t
(check-expect (render-team empty 1) (render-cell "Team 1"))
(check-expect (render-team 
               (cons (make-player "Samael" 2)
                     (cons (make-player "John" 2) empty)) 2)
              (above (render-cell "Team 2")
                     (render-cell "Samael")
                     (render-cell "John")))

;(define (render-team lop t) empty-image) ; stub

(@template-origin fn-composition)

(define (render-team lop t)
  (above (render-cell (string-append "Team " (number->string t)))
         (render-los (player-names lop))))


(@htdf player-names)
(@signature ListOfPlayer -> ListOfString)
;; produce a list of the names of the given players.
(check-expect (player-names empty) empty)
(check-expect (player-names (cons (make-player "Samael" 2)
                                  (cons (make-player "John" 2) empty)))
              (cons "Samael" (cons "John" empty)))

;(define (player-names lop) empty) ; stub

(@template-origin ListOfPlayer)

#;
(define (player-names lop)
  (cond [(empty? lop) (...)]
        [else
         (... (fn-for-player (first lop))
              (player-names (rest lop)))]))

(define (player-names lop)
  (cond [(empty? lop) empty]
        [else
         (cons (player-name (first lop))
               (player-names (rest lop)))]))


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
  


