;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname maze-2w-solution) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/image)
(require spd/tags)

(@assignment bank/search-p1)
(@cwl ???)

(@problem 1)
;; Solve simple square mazes

;; =================
;; Constants:

(define CELL-SIZE 30)
(define OPEN (square CELL-SIZE "solid" "light gray"))
(define WALL (square CELL-SIZE "solid" "black"))



;; =================
;; Data definitions:

(@htdd Maze)
;; Maze is (listof Boolean)
;; interp. a square maze
;;         each side length is (sqrt (length <maze>)) units long
;;         true  (aka #t) means open, can move through this
;;         false (aka #f) means a wall, cannot move into or through a wall
;;

(define O #t) ;Open
(define W #f) ;Wall

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


(@htdd Pos)
(define-struct pos (x y))
;; Pos is (make-pos Integer Integer)
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
(define P3 (make-pos 3 3)) ;lower left   "  "   "

#;
(define (fn-for-pos p)
  (... (pos-x p)
       (pos-y p)))



;; =================
;; Functions:

(@htdf solvable?)
(@signature Maze -> Boolean)
;; produce true if maze is solvable, false otherwise
;; CONSTRAINT: maze has a true at least in the upper left
(check-expect (solvable? M1) #t)
(check-expect (solvable? M2) #t)
(check-expect (solvable? M3) #t)
(check-expect (solvable? M4) #f)

(@template-origin encapsulated try-catch genrec arb-tree)

(define (solvable? m)
  ;; Termination argument:
  ;; Trivial case: bd is solved or there are no more possible positions
  ;;
  ;; Reduction step: (solve/lop (next-ps m p)) will explore the next possible
  ;;                 positions
  ;;
  ;; As the maze has only a finite number of positions, there are only a finite
  ;; number of paths through the maze, and by continually moving right or down,
  ;; each path will eventually lead to a solved maze or a dead end
  
  (local [(define (solve/one p)
            (cond [(solved? p m) true]
                  [else
                   (solve/lop (next-ps m p))]))
          
          (define (solve/lop lop)
            (cond [(empty? lop) false]
                  [else
                   (local [(define try (solve/one (first lop)))]
                     (if (not (false? try))
                         try
                         (solve/lop (rest lop))))]))]
    
    (solve/one (make-pos 0 0))))


(@htdf solved?)
(@signature Pos Maze -> Boolean)
;; produce true if p represents the lower right corner of a maze
(check-expect (solved? P0 M0) false)
(check-expect (solved? P1 M0) false)
(check-expect (solved? P2 M0) false)
(check-expect (solved? P3 M0) true)

(@template-origin Pos)

(define (solved? p m)
  (= (pos-x p) (pos-y p) (sub1 (sqrt (length m)))))


(@htdf next-ps)
(@signature Maze Pos -> (listof Pos))
;; Given maze and position, produce a list of up to two valid next positions
(check-expect (next-ps M1 (make-pos 0 0)) (list (make-pos 0 1)))
(check-expect (next-ps M1 (make-pos 1 0)) (list (make-pos 1 1)))

(@template-origin fn-composition encapsulated) ;could also add use-abstract-fn and Pos

(define (next-ps m p)
  (local [(define SIZE (sqrt (length m)))
          (define (new-ps p)
            (local [(define x (pos-x p))
                    (define y (pos-y p))]
              (list (make-pos (add1 x)      y)
                    (make-pos       x (add1 y)))))
          
          (define (valid-only m lop)
            (filter valid? lop))
          
          (define (valid? p)
            (and (<= 0 (pos-x p) (- SIZE 1))
                 (<= 0 (pos-y p) (- SIZE 1))
                 (mref m p)))]
    
    (valid-only m (new-ps p))))


(@htdf mref)
(@signature Maze Pos -> Boolean)
;; produce contents of given square in given maze
(check-expect (mref (list #t #f #f #f) (make-pos 0 0)) #t)
(check-expect (mref (list #t #t #f #f) (make-pos 0 1)) #f)

(@template-origin Pos)

(define (mref m p)
  (local [(define s (sqrt (length m))) ;each side length
          (define x (pos-x p))
          (define y (pos-y p))]
    
    (list-ref m (+ x (* y s)))))


(@htdf render)
(@signature Maze -> Image)
;; produce simple rendering of a square maze.
(check-expect (render empty) empty-image)
(check-expect (render (list #t #f
                            #f #t))
              (above (beside (square 30 "solid" "light gray")
                             (square 30 "solid" "black"))
                     (beside (square 30 "solid" "black")
                             (square 30 "solid" "light gray"))))

(@template-origin encapsulated fn-composition use-abstract-fn)

(define (render m)
  (local [(define SIZE (sqrt (length m)))          ;for 4x4 this is 4
          (define IDXS (build-list SIZE identity)) ;for 4x4 this is
                                                   ;(list 0 1 2 3)
          (define CELL-SIZE 30)
          (define T (square CELL-SIZE "solid" "light gray"))
          (define F (square CELL-SIZE "solid" "black"))
          
          (define (cv->image cv)
            (cond [cv   OPEN]
                  [else WALL]))]
    
    (foldr (lambda (i img)
             (above (foldr (lambda (j img)
                             (beside (cv->image (list-ref m (+ (* i SIZE) j)))
                                     img))
                           empty-image
                           IDXS)
                    img))
           empty-image
           IDXS)))
