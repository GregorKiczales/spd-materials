;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname m11-maze-4-way-path-starter) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #t)))
(require spd/tags)

(@assignment lectures/m11-maze-4-way-distance-from)

(@cwl ???) ;replace ??? with your cwl


#|

 Jump down to problem 1 for more details.

|#


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


(@problem 1)

#|

In the following partially complete function design:

 - The next-ps function has been updated so to produce all valid
   moves chosen from up, down, left, and right of the given position.

 - ONE set of templates for fn-for-p and fn-for-lop uses ordinary recursion.

 - ONE set of templates for fn-for-p and fn-for-lop uses tail recursion.

 - Neither set of templates have accumulators to prevent cycling.

Complete the design of the function below. Note carefully that this 
function produces a natural if there is a path starting at 0,0 that first
passes through start, and then passes through end. The natural is the number
of steps from from start to end.  If there is no such path it fails.

Start by figuring out what addtional accumulator(s) you need and then
choose normal or tail recursion. Work with the right set of templates
and delete or comment out the others.

NOTE THAT WE HAVE PUT A USEFUL DATA DEFINITION AND A HELPER FUNCTION
CALLED distance-add1 in for you.

|#



(@htdf distance-from)
(@signature Maze Pos Pos -> Natural or false)
;; if can start at 0,0, reach start, and then end, produce distance between them
;; CONSTRAINT: maze has a true at least in the upper left
(check-expect (distance-from M1 (make-pos 1 1) (make-pos 1 4)) 3)
(check-expect (distance-from M1 (make-pos 1 1) (make-pos 4 1)) #f)

(check-expect (distance-from M2 (make-pos 0 0) (make-pos 4 4)) 8)

(check-expect (distance-from M7 (make-pos 2 2) (make-pos 3 3)) 2)
(check-expect (distance-from M7 (make-pos 2 0) (make-pos 7 2)) 11)

(define (distance-from m start end) false) ;stub

(@template-origin encapsulated try-catch genrec arb-tree accumulator)

#;
(define (distance-from m start end)
  (local [(define rank (sqrt (length m)))	  

          ;; trivial:   
          ;; reduction: 
          ;; argument:
          
          (define (fn-for-p p)
            (cond [(solved? p) true]
                  [else
                   (fn-for-lop (next-ps p))]))

          (define (fn-for-lop lop)
            (cond [(empty? lop) false]
                  [else
                   (local [(define try (fn-for-p (first lop)))]
                     (if (not (false? try))
                         try
                         (fn-for-lop (rest lop))))]))


          ;; trivial:   
          ;; reduction: 
          ;; argument:
          
          (define (fn-for-p p p-wl)
            (cond [(solved? p) true]
                  [else
                   (fn-for-lop (append (next-ps p) p-wl))]))

          (define (fn-for-lop p-wl)
            (cond [(empty? p-wl) false]
                  [else
                   (fn-for-p (first p-wl) (rest p-wl))]))

          

          ;; Distance is one of:
          ;;  - false   (have not yet passed start)
          ;;  - Natural (distance from start including start)
          
          (define (distance-add1 dist)
            (cond [(false? dist) false]
                  [else (add1 dist)]))
          
          
          
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
    
    (fn-for-p (make-pos 0 0) ...)))

