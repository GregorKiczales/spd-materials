;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname m11-maze-4-way-distance-from-solution) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #t)))
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

(@htdf distance-from)
(@signature Maze Pos Pos -> Natural or false)
;; if path exists from start to end produce distance between
;; CONSTRAINT maze has a true at least in the upper left
(check-expect (distance-from M1 (make-pos 1 1) (make-pos 1 4)) 3)
(check-expect (distance-from M1 (make-pos 1 1) (make-pos 4 1)) #f)

(check-expect (distance-from M2 (make-pos 0 0) (make-pos 4 4)) 8)

(check-expect (distance-from M7 (make-pos 2 2) (make-pos 3 3)) 2)
(check-expect (distance-from M7 (make-pos 2 0) (make-pos 7 2)) 11)


(@template-origin encapsulated try-catch genrec arb-tree accumulator)

(define (distance-from m start end)
  (local [(define R (sqrt (length m)))	  

          ;; trivial:   
          ;; reduction: 
          ;; argument:
           
          (define (fn-for-p p path passed-start?)
            (cond [(equal? p end)   (add1 (position-of start path))]
                 ;[(solved? p)      false]
                  [(member? p path) false]
                  [else
                   (if (equal? p start)
                       (fn-for-lop (next-ps p) (cons p path) true)                       
                       (fn-for-lop (next-ps p) (cons p path) passed-start?))]))

          (define (fn-for-lop lop path dist)
            (cond [(empty? lop) false]
                  [else
                   (local [(define try (fn-for-p (first lop) path dist))]
                     (if (not (false? try))
                         try
                         (fn-for-lop (rest lop) path dist)))]))

          ;; CONSTRAINT: p is in lop
          (define (position-of p lop)
            (cond [(empty? p) (error "p was not in lop")]
                  [else
                   (if (equal? p (first lop))
                       0
                       (add1 (position-of p (rest lop))))]))
          
          ;; Pos -> Boolean          
          ;; produce true if pos is at the lower right
          (define (solved? p)
            (and (= (pos-x p) (sub1 R))
                 (= (pos-y p) (sub1 R))))


          ;; Pos -> (listof Pos)
          ;; produce next possible positions based on maze geometry
          (define (next-ps p)
            (local [(define x (pos-x p))
                    (define y (pos-y p))]
              (filter (lambda (p1)
                        (and (<= 0 (pos-x p1) (sub1 R))  ;legal x
                             (<= 0 (pos-y p1) (sub1 R))  ;legal y
                             (open? (maze-ref m p1))))   ;open?
                      (list (make-pos x (sub1 y))        ;up
                            (make-pos x (add1 y))        ;down
                            (make-pos (sub1 x) y)        ;left
                            (make-pos (add1 x) y)))))    ;right

          ;; Maze Pos -> Boolean
          ;; produce contents of maze at location p
          ;; assume p is within bounds of maze
          (define (maze-ref m p)
            (list-ref m (+ (pos-x p) (* R (pos-y p)))))]
    
    (fn-for-p (make-pos 0 0) empty false)))

