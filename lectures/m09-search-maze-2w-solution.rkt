;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname m09-search-maze-2w-solution) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #t)))
(require spd/tags)
(@assignment lectures/m09-search-maze-2w)
(@problem 1)
;; maze-2w-solution.rkt

;; Solve simple square mazes


;; Constants:


;; Data definitions:

(@htdd Maze)
;; Maze is (listof Boolean)
;; interp. a square maze
;;         each side length is (sqrt (length <maze>))
;;         true  (aka #t) means open, can move through this
;;         false (aka #f) means a wall, cannot move into or through a wall
;; CONSTRAINT: maze is square, so (sqrt (length <maze>)) is a Natural
;;

(define O true)  ;Open
(define W false) ;Wall

(define M0
  (list O W W W
        W W W W
        W W W W
        W W W W))

(define M1
  (list O W W W W
        O O W O O
        W O W W W 
        O O W W W
        O O O O O))

(define M2
  (list O O O O O
        O W W W O
        O W W W O
        O W W W O
        O W W W O))

(define M3             ;forces backtracking in this solver
  (list O O O O O
        O W W W W
        O W W W W
        O W W W W 
        O O O O O))

(define M4
  (list O O O O O
        O W W W O
        O W O O O
        O W O W W
        W W O O O))

(@htdd Position)

(define-struct pos (x y))
;; Position is (make-pos Natural Natural)
;; interp. an x, y position in the maze.
;;         0, 0 is upper left.
;;         a position is only valid for a given maze if:
;;            - (<= 0 x (sub1 <size>))
;;            - (<= 0 y (sub1 <size>))
;;            - there is a true in the given cell
;;
(define P0 (make-pos 0 0)) ;upper left  in 4x4 maze
(define P1 (make-pos 3 0)) ;upper right  "  "   "
(define P2 (make-pos 0 3)) ;lower left   "  "   "
(define P3 (make-pos 3 3)) ;lower right  "  "   "

(define (fn-for-pos p)
  (... (pos-x p)
       (pos-y p)))

;; Functions:
(@problem 2)
(@htdf solvable?)
(@signature Maze -> Boolean)
;; produce true if maze is solvable, false otherwise
;; CONSTRAINT: maze has an empty square at least in the upper left
(check-expect (solvable? M1) #t)
(check-expect (solvable? M2) #t)
(check-expect (solvable? M3) #t) 
(check-expect (solvable? M4) #f)

(@template-origin encapsulated genrec arb-tree try-catch)

#|
YOU WOULD NOT NORMALLY LEAVE THIS STEP BY STEP BLENDING OF THE
TEMPLATES IN YOUR WORK, BUT I AM PUTTING IT HERE TO HELP UNDERSTAND
HOW WE GOT THERE.

(define (solvable? m)              ;encapsulated
  (local []

    (... (make-pos 0 0))))

(define (solvable? m)              ;+arb-tree
  (local [(define (fn-for-pos p)
            (... (pos-x p)
                 (pos-y p)
                 (fn-for-lop (pos-sub-poses p)))) ;this selector doesn't exist

          (define (fn-for-lop lop)
            (cond [(empty? lop) (...)]
                  [else
                   (... (fn-for-pos (first lop))
                        (fn-for-lop (rest lop)))]))]

    (... (make-pos 0 0))))


(define (solvable? m)              ;+genrec
  ;; trivial:
  ;; reduction:
  ;; argument:
  (local [(define (fn-for-pos p)
            (if (solved? p)
                true
                (fn-for-lop (valid-next-positions p))))


          (define (fn-for-lop lop)
            (cond [(empty? lop) (...)]
                  [else
                   (... (fn-for-pos (first lop))
                        (fn-for-lop (rest lop)))]))]

    (... (make-pos 0 0))))

|#
(define (solvable? m)            ;+try-catch
  ;; trivial:   reaches lower right
  ;; reduction: moves down and right when possible
  ;; argument:  maze is finite, so moving will eventually
  ;;            reach trivial case or run out of moves
  (local [(define (fn-for-pos p)
            (if (solved? p)
                true
                (fn-for-lop (valid-next-positions p))))
          (define (fn-for-lop lop)
            (cond [(empty? lop) false]
                  [else
                   (local [(define try (fn-for-pos (first lop)))]
                     (if (not (false? try))
                         try		       
                         (fn-for-lop (rest lop))))]))

          (define MAX-X/Y (sub1 (sqrt (length m))))  ;width and height

          ;; (@signature Position -> Boolean)
          ;; produce true if p represents the lower right corner of a maze
          ;; (@template-origin Position)
          (define (solved? p)
            (= (pos-x p) (pos-y p) MAX-X/Y))

          ;; (@signature Position -> (listof Position))
          ;; Produce a list of up to two valid next positions (right and down)
          ;; (@template-origin fn-composition)
          (define (valid-next-positions p)
            (filter valid? (all-next-positions p)))

          ;; (@template-origin Position)
          (define (all-next-positions p)
            (local [(define x (pos-x p))
                    (define y (pos-y p))]
              (list (make-pos (add1 x)      y)
                    (make-pos       x (add1 y)))))

          ;; (@template-origin Position)
          (define (valid? p)
            (and (<= 0 (pos-x p) MAX-X/Y)
                 (<= 0 (pos-y p) MAX-X/Y)
                 (mref m p)))]

    (fn-for-pos (make-pos 0 0))))



(@htdf mref)
(@signature Maze Position -> Boolean)
;; produce contents of given square in given maze
(check-expect (mref (list #t #f #f #f) (make-pos 0 0)) #t)
(check-expect (mref (list #t #t #f #f) (make-pos 0 1)) #f)

(@template-origin Position)

(define (mref m p)
  (local [(define s (sqrt (length m))) ;each side length
          (define x (pos-x p))
          (define y (pos-y p))]
    (cond [(not (<= 0 x (sub1 s)))
           (error 'mref "x value " x " must be within [0, " (sub1 s) "].")]
          [(not (<= 0 y (sub1 s)))
           (error 'mref "y value " y " must be within [0, " (sub1 s) "].")]
          [else
           (list-ref m (+ x (* y s)))])))



(require 2htdp/image)

(define SQUARE-SZ 20)
(define GOAL-SZ 8)
(define DOT-SZ 6)

(define DOT (circle DOT-SZ "solid" "black"))
(define RED (circle DOT-SZ "solid" "red"))

(define OS (square SQUARE-SZ "outline" "white"))
(define WS (square SQUARE-SZ "solid" "black"))

(@htdf render-maze-w/path)
(@signature Maze -> Image)
;; produce simple rendering of MAZE using above constants
(check-expect
 (render-maze-w/path (list O W O O)      
                     (list (make-pos 0 0) (make-pos 0 1)))
 (place-image
  RED (* .5 SQUARE-SZ) (* .5 SQUARE-SZ)
  (place-image
   OS (* .5 SQUARE-SZ) (* .5 SQUARE-SZ)
   (place-image     
    WS (* 1.5 SQUARE-SZ) (* 0.5 SQUARE-SZ)
    (place-image
     RED (* 0.5 SQUARE-SZ) (* 1.5 SQUARE-SZ)     
     (place-image
      OS (* 0.5 SQUARE-SZ) (* 1.5 SQUARE-SZ)
      (place-image       
       OS (* 1.5 SQUARE-SZ) (* 1.5 SQUARE-SZ)
       (square (* 2 SQUARE-SZ) "outline" "black"))))))))
                           

(define (render-maze-w/path m path)
  (local [(define rank (sqrt (length m)))

          (define bkgrd (square (* rank SQUARE-SZ) "outline" "black"))

          ;; foldr w/ extra accumulator
          ;; i is Integer; index number of (first lov) in original m
          (define (fold lov i img)
            (cond [(empty? lov) img]
                  [else
                   ;; be prepared to put RED over wall because the path
                   ;; might be buggy
                   (place-image (if (member (make-pos (remainder i rank)
                                                      (quotient i rank))
                                            path)
                                    (overlay RED (if (first lov) OS WS))
                                    (if (first lov) OS WS))
                                (i->x i)
                                (i->y i)
                                (fold (rest lov) (add1 i) img))]))

          (define (i->x i)
            (floor (+ (* (remainder i rank) SQUARE-SZ) (/ SQUARE-SZ 2))))
          (define (i->y i)
            (floor (+ (* (quotient  i rank) SQUARE-SZ) (/ SQUARE-SZ 2))))]
    
    (fold m 0 bkgrd)))
