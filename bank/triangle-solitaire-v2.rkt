;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname triangle-solitaire-v2) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
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


;; ================================
;; Data defininitions and constants

(@htdd Board)
;; Board is (listof Boolean) of length 15
;; interp.
;;   true  means a peg is in the hole
;;   false means the hole is empty


(@htdd Position)
;; Position is Natural
;; interp. 0 based indexes into a board in [0, 14]


(@htdd Jump)
(define-struct jump (from over to))
;; Jump is (make-jump Position Position Position)
;; interp.
;;  a jump on the board, with the from, to and
;;  jumped over positions

(define POSITIONS
  ;; (list         0
  ;;              1 2
  ;;            3  4  5
  ;;          6  7  8  9
  ;;        10 11 12 13 14))
  (list 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14))


(define MTB  (build-list 15 (lambda (n) false)))


(define BD1  (build-list 15 (lambda (p) (not (= p 0))))) ;top spot open
(define BD2  (build-list 15 (lambda (p) (not (= p 4))))) ;center spot open

(define BD3  (build-list 15                              ;almost solved
                         (lambda (p)  
                           (or (= p 13)
                               (= p 14)))))

(define BD4  (build-list 15                              ;0 and 3 have pegs
                         (lambda (p)                     ;this board is
                           (or (= p 0)                   ;unsolvable
                               (= p 3)))))



(define BD1a (build-list 15                              ;possible next board
                         (lambda (p)                     ;after BD1
                           (not (or (= p 1)  
                                    (= p 3))))))

(define BD1b (build-list 15                              ;possible next board
                         (lambda (p)                     ;after BD1
                           (not (or (= p 2)  
                                    (= p 5))))))

(define BD1s (build-list 15 (lambda (p) (= p 12))))
(define BD2s (build-list 15 (lambda (p) (= p 12))))
(define BD3s (build-list 15 (lambda (p) (= p 12))))


;; The raw possible jumps given the shape of the board. 
;; For a given board these are only valid if the from and
;; over are full and the to is empty.

(define JUMPS
  (list
   (make-jump  0 1  3) (make-jump  0  2  5)
   (make-jump  1 3  6) (make-jump  1  4  8)
   (make-jump  2 4  7) (make-jump  2  5  9)
   
   (make-jump  3 1  0) (make-jump  3  4  5) (make-jump  3  6 10)
   (make-jump  3  7 12)
   
   (make-jump  4 7 11) (make-jump  4  8 13)
   
   (make-jump  5 2  0) (make-jump  5  4  3) (make-jump  5  8 12)
   (make-jump  5  9 14)
   
   (make-jump  6 3  1) (make-jump  6  7  8)
   (make-jump  7 4  2) (make-jump  7  8  9)
   (make-jump  8 4  1) (make-jump  8  7  6)
   (make-jump  9 5  2) (make-jump  9  8  7)
   (make-jump 10 6  3) (make-jump 10 11 12)
   (make-jump 11 7  4) (make-jump 11 12 13)
   
   (make-jump 12 7  3) (make-jump 12  8  5) (make-jump 12 11 10)
   (make-jump 12 13 14)
   
   (make-jump 13 8  4) (make-jump 13 12 11)
   (make-jump 14 9  5) (make-jump 14 13 12)))


(define RENDER-MAP
  (list (list      0)
        (list     1  2)
        (list    3  4  5)
        (list   6  7  8  9)
        (list 10 11 12 13 14)))

(define HOLE (circle 10 "outline" "black"))
(define PEG  (overlay (circle 8 "solid" "blue") HOLE))



;; =================
;; Functions:

(@htdf solve)
(@signature Board -> (listof Board) or false)
;; If bd is solvable, produce list of boards to solution. Else produce false.
(check-expect (solve MTB) false)
(check-expect (solve BD4) false)
(check-expect (solve BD3) (list BD3 BD3s))
(check-expect (solve BD1)
              (local [(define T true)
                      (define F false)]
                (list
                 (list F T T T T T T T T T T T T T T)
                 (list T F T F T T T T T T T T T T T)
                 (list T F T T F F T T T T T T T T T)
                 (list F F F T F T T T T T T T T T T)
                 (list F T F F F T F T T T T T T T T)
                 (list F T T F F F F T T F T T T T T)
                 (list F T T F T F F F T F T F T T T)
                 (list F T T F T T F F F F T F F T T)
                 (list F F T F F T F F T F T F F T T)
                 (list F F F F F F F F T T T F F T T)
                 (list F F F F F T F F T F T F F T F)
                 (list F F F F F F F F F F T F T T F)
                 (list F F F F F F F F F F T T F F F)
                 (list F F F F F F F F F F F F T F F))))
;; !!!
(define (solve bd) false) ;stub


(@htdf get-cell)
(@signature Board Position -> Boolean)
;; produce contents of position p on bd
(check-expect (get-cell BD1 0) false)
(check-expect (get-cell BD1 3) true)

(@template-origin 2-one-of)

(define (get-cell bd p)
  ;;      bd>>            empty    (cons Position Board)
  ;; p
  ;; v
  ;; v
  ;; 
  ;; 0                     N/A      (first bd)
  ;; 
  ;; (add1 Position)       N/A      <natural recursion>
  
  (cond [(zero? p) (first bd)]
        [else
         (get-cell (rest bd) (sub1 p))]))


(@htdf set-cell)
(@signature Board Position Boolean -> Board)
;; produce new board with v at position p
(check-expect (set-cell BD1 3 false)
              (build-list 15 
                          (lambda (p) 
                            (not (or (= p 0)  
                                     (= p 3))))))
(check-expect (set-cell BD1 5 false)
              (build-list 15 
                          (lambda (p) 
                            (not (or (= p 0)  
                                     (= p 5))))))
(check-expect (set-cell BD1 0 true)
              (build-list 15 
                          (lambda (p) true)))

(check-expect (set-cell MTB 5 true) 
              (build-list 15 (lambda (p) (= p 5))))
(check-expect (set-cell MTB 5 false) 
              (build-list 15 (lambda (p) false)))
(check-expect (set-cell BD2 12 false) 
              (build-list 15 (lambda (p) (not (or (= p 4)
                                                  (= p 12))))))

(@template-origin 2-one-of)

(define (set-cell bd p v)
  ;;      bd>>             empty    (cons Position Board)
  ;; p
  ;; v
  ;; v
  ;; 
  ;; 0                     N/A      (cons v (rest bd))
  ;; 
  ;; (add1 Position)       N/A      (cons (first bd)
  ;;                                      <natural recursion>)
 
  (cond [(zero? p) (cons v (rest bd))]
        [else
         (cons (first bd)
               (set-cell (rest bd) (sub1 p) v))]))


(@htdf render-board)
(@signature Board -> Image)
;; render an image of the given board
(check-expect (render-board BD1)
              (above
               HOLE
               (beside PEG PEG)
               (beside PEG PEG PEG)
               (beside PEG PEG PEG PEG)
               (beside PEG PEG PEG PEG PEG)))
(check-expect (render-board BD2)
              (above
               PEG
               (beside PEG PEG)
               (beside PEG HOLE PEG)
               (beside PEG PEG PEG PEG)
               (beside PEG PEG PEG PEG PEG)))

(@template-origin use-abstract-fn fn-composition)

(define (render-board bd)
  (foldr above
         empty-image
         (map (lambda (row)
                (foldr (lambda (p img)
                         (beside (if (get-cell bd p) PEG HOLE)
                                 img))
                       empty-image
                       row))
              RENDER-MAP)))
