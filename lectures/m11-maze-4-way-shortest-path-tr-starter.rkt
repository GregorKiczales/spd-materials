;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname m11-maze-4-way-shortest-path-tr-starter) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #t)))
(require spd/tags)
(@assignment lectures/m11-maze-4-way-shortest-path-tr)
(@cwl ???) ;replace ??? with your cwl

(@problem 1)
;;
;; Convert this function to produce the shortest path if possible.
;; False otherwise. Your function must be tail recursive.
;;

;; Solve simple square mazes

;; Data definitions:

(@htdd Maze)
;; Maze is (listof Boolean)
;; interp. a square maze
;;         each side length is (sqrt (length <maze>))
;;         true  (aka #t) means open, can move through this
;;         false (aka #f) means a wall, cannot move into or through a wall
;;
(define (open? v) v)
(define (wall? v) (not v))

(define O #t) ;Open
(define W #f) ;Wall

(define M1
  (list O W W W W
        O O W O O
        W O W W W 
        W O W W W
        W O O O O))

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


(define M5
  (list O O O O O
        O W O W O
        O O O O O
        O W O W O
        W O O W W))

(define M6
  (list O O O O O O O O O O
        W W O W W O W W W O
        O O O W W O W O O O
        O W O O W O W O W W
        O W W O W O W O O O
        O W W O W O W W W O
        O W W O W O W O O O
        O W W O O O W O W W
        O O O O W W W O O O
        W W W W W O O W W O))


(define M7
  (list O O O O O O O O O O
        W W O W W W W W W O
        O O O W W W W O O O
        O W O O W W W O W W
        O W W O O O W O O O
        O W W O W O W W W O
        O W W O W O W O O O
        O W W O O O W O W W
        O O O O W W W O O O
        W W W W W O O W W O))



(@htdd Pos)
(define-struct pos (x y))
;; Pos is (make-pos Integer Integer)
;; interp. an x, y position in the maze.
;;         0, 0 is upper left.
;;         the SIZE of a maze is (sqrt (length m))
;;         a position is only valid for a given maze if:
;;            - (<= 0 x (sub1 SIZE))
;;            - (<= 0 y (sub1 SIZE))
;;            - there is a true in the given cell
;;                         ;in a 5x5 maze:
(define P0 (make-pos 0 0)) ;upper left
(define P1 (make-pos 4 0)) ;upper right
(define P2 (make-pos 0 4)) ;lower left
(define P3 (make-pos 4 4)) ;lower right

;; Functions

;;
;; Your solution:
;;   - must be tail recursive
;;

(@htdf solve)
(@signature Maze -> ???)
;; produce ??? if maze is solvable, false otherwise
;; CONSTRAINT: maze has a true at least in the upper left
(check-expect (solve M1) #t)
(check-expect (solve M2) #t)
(check-expect (solve M3) #t) 
(check-expect (solve M4) #t)
(check-expect (solve M5) #f)
(check-expect (solve M6) #t)
(check-expect (solve M7) #t)


(@template-origin encapsulated try-catch genrec arb-tree accumulator)

(define (solve m)
  (local [(define rank (sqrt (length m)))

          ;; trivial:   reaches lower right, previously seen position
          ;; reduction: move up, down, left, right if possible
          ;; argument:  maze is finite, so moving will eventually
          ;;            reach trivial case or run out of moves
          
          ;; path is (listof Pos); positions before p on this path through data
          ;;                       in reverse order
          (define (solve/p p path)
            (cond [(solved? p)     true]
                  [(member p path) false]
                  [else
                   (solve/lop (next-ps p)
                              (cons p path))]))

          (define (solve/lop lop path)
            (cond [(empty? lop) false]
                  [else
                   (local [(define try (solve/p (first lop) path))]
                     (if (not (false? try))
                         try
                         (solve/lop (rest lop) path)))]))
          

          
          ;; Pos -> Boolean          
          ;; produce true if pos is at the lower right
          (define (solved? p)
            (and (= (pos-x p) (sub1 rank))
                 (= (pos-y p) (sub1 rank))))


          ;; Pos -> (listof Pos)
          ;; produce next possible positions based on maze geometry
          (define (next-ps p)
            (local [(define x (pos-x p))
                    (define y (pos-y p))]
              (filter (lambda (p1)
                        (and (<= 0 (pos-x p1) (sub1 rank)) ;legal x
                             (<= 0 (pos-y p1) (sub1 rank)) ;legal y
                             (open? (maze-ref m p1))))     ;open?
                      (list (make-pos x (sub1 y))          ;up
                            (make-pos x (add1 y))          ;down
                            (make-pos (sub1 x) y)          ;left
                            (make-pos (add1 x) y)))))      ;right

          ;; Maze Pos -> Boolean
          ;; produce contents of maze at location p
          ;; CONSTRAINT: p is within bounds of maze
          (define (maze-ref m p)
            (list-ref m (+ (pos-x p) (* rank (pos-y p)))))]
    
    (solve/p (make-pos 0 0) empty)))

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
