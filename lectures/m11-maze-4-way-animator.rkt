;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname m11-maze-4-way-animator) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #t)))
(require spd/tags)
(require 2htdp/image)
(require 2htdp/universe)

(require racket/port)  ;this is not normally ok in a 110 program!
(require racket/pretty);

(@problem 1)


;; Animate maze solving.
;;
;; Start with (main M4) then move on to (main M7) or (main M8)
;;
;;

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
  (list O O O O O
        O W W W O
        O W O O O
        O W O W W
        W O O O O))

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

(define M8
  (list O O O O O O O O W O
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


;; The accumulators in the solver are:
;;
;; p-wl is    (listof Pos); worklist
;; path-wl is (listof (listof Pos)); tandem path worklist
;; visited is (listof Pos); every position ever visited
;;
;; 
;;
(define-struct solve/p-args   (p p-wl path path-wl visited))
(define-struct solve/lop-args (  p-wl      path-wl visited))
;; WS is one of:
;;  (make-solve/p-args     ..) same types and interp as args to solve/p
;;  (make-solve/lopp-args  ..) same types and interp as args to solve/lop
;;
;; interp. args to solve/p or solve/lop
;;


;; Functions

(@htdf main)
(@signature Maze -> Maze)
;; run maze solving animation, start with (main <some-maze>)
;; <no tests for main functions>

(@template-origin encapsulated genrec arb-tree accumulator htdw-main)

(define (main m)
  (local [(define R (sqrt (length m)))
          ;; ----
          ;; tail recursion, with visited accumulator and tandem worklists

          ;; trivial:   reaches lower right, previously seen position
          ;; reduction: move up, down, left, right if possible
          ;; argument:  maze is finite, so moving will eventually
          ;;            reach trivial case or run out of moves
          
          ;; Here we just package up accumulators into a world state
          ;; and produce that world state for big-bang. When the
          ;; user presses space we get called back at solve/p-2
          (define (solve/p p p-wl path path-wl visited)
            (make-solve/p-args p p-wl path path-wl visited))
          
          (define (solve/p-2 ws)
            (local [(define p       (solve/p-args-p ws))        
                    (define p-wl    (solve/p-args-p-wl ws))
                    (define path    (solve/p-args-path ws))
                    (define path-wl (solve/p-args-path-wl ws))
                    (define visited (solve/p-args-visited ws))]
              (cond [(solved? p)
                     ;; nothing more to do
                     (make-solve/lop-args empty empty (cons p visited))]
                    [(member p visited)
                     (solve/lop p p-wl path path-wl visited)]
                    [else
                     (local [(define nexts    (next-ps p))
                             (define npath    (cons p path))
                             (define nvisited (cons p visited))]
                       (solve/lop p
                                  (append nexts
                                          p-wl)
                                  path
                                  (append (make-list (length nexts) npath)
                                          path-wl)
                                  nvisited))])))
          
          ;; Here we just package up accumulators into a world state
          ;; and produce that world state for big-bang. When the
          ;; user presses space we get called back at solve/lop-2
          (define (solve/lop p p-wl path path-wl visited)
            (make-solve/lop-args p-wl path-wl visited))

          
          (define (solve/lop-2 ws)
            (local [(define p-wl    (solve/lop-args-p-wl ws))
                    (define path-wl (solve/lop-args-path-wl ws))
                    (define visited (solve/lop-args-visited ws))]
              (cond [(empty? p-wl) ws]
                    [else
                     (solve/p (first p-wl) (rest p-wl)
                              (first path-wl) (rest path-wl)
                              visited)])))


          ;; WS -> Image
          (define (render ws)
            (local [(define S (sqrt (length m)))          
                    (define BKGRD  (square (* S SQUARE-SZ) "solid" "white"))
                    (define BORDER (square (* S SQUARE-SZ) "outline" "black"))
                    (define SPACER (square SQUARE-SZ "outline" "transparent"))]
              (above (overlay BORDER
                              (foldr (lambda (fn img) (fn m ws img))
                                     BKGRD
                                     DECORATORS))
                     SPACER
                     (overlay/align "left" "top"
                                    (render-call ws)
                                    (rectangle TEXT-WIDTH TEXT-HEIGHT
                                               "solid" "white")))))
          

          ;; Helpers
          
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
            (list-ref m (+ (pos-x p) (* R (pos-y p)))))

          (define INIT-WS
            (make-solve/p-args (make-pos 0 0)
                               (list)
                               (list)
                               (list)
                               (list)))]

    
    (big-bang INIT-WS
      (name "showing args to solve/p alternating with solve/lop...")
      (to-draw render)
      (on-key  (lambda (ws ke)
                 (cond [(key=? ke " ")
                        (cond [(solve/p-args? ws) (solve/p-2 ws)]
                              ;; nothing happens once wl is empty at solve/lop
                              [(empty? (solve/lop-args-p-wl ws)) ws]
                              [else (solve/lop-2 ws)])]
                       [(key=? ke "r") INIT-WS]
                       [else ws]))))))


                 
(define TEXT-WIDTH  800)
(define TEXT-HEIGHT 300)
(define TEXT-SIZE 20)

(define SQUARE-SZ 50)
(define MARK-SZ   20)
(define DOT-SZ    10)

(define OS (square SQUARE-SZ "outline" "light grey"))
(define WS (square SQUARE-SZ "solid" "black"))
(define TS (square SQUARE-SZ "outline" "transparent"))

(define C "center")
(define L "left")
(define R "right")
(define T "top")
(define B "bottom")

;; No conflict position is black
(define POS   (overlay/align C C (circle DOT-SZ "outline" "black") TS))

;; Path and path conflict are red
(define PATH  (overlay/align L T (text "P"  MARK-SZ       "red")  TS))
(define XPATH (overlay/align C C (text "X"  MARK-SZ       "red")  TS))

;; Visited and visited conflict are grey
(define VIS   (overlay/align R T (text "V"  MARK-SZ       "grey") TS))
(define XVIS  (overlay/align C C (text "X"  MARK-SZ       "grey") TS))

;; worklist is green
(define (render-wl-index i)
  (overlay/align C C (text (number->string i) MARK-SZ "green")  TS))


(define (decorate-p m ws img)
  (if (solve/p-args? ws)
      (local [(define p       (solve/p-args-p ws))
              (define path    (solve/p-args-path ws))
              (define visited (solve/p-args-visited ws))]
        (decorate-maze m
                       (lambda (p1 v)
                         (if (equal? p1 p)
                             (cond [(member? p1 path) XPATH]
                                   [(member? p1 visited) XVIS]
                                   [else POS])
                             TS))
                       img))
      img))

(define (decorate-on-p-wl m ws img)
  (local [(define p-wl (if (solve/p-args? ws)
                           (solve/p-args-p-wl ws)
                           (solve/lop-args-p-wl ws)))]
    (decorate-maze m
                   (lambda (p v)
                     (let [(index (position-of p p-wl))]
                       (if (false? index)
                           TS
                           (render-wl-index index))))
                   img)))

(define (decorate-on-path m ws img)
  (if (solve/p-args? ws)
      (local [(define path (solve/p-args-path ws))]
        (decorate-maze m
                       (lambda (p v)
                         (if (member? p path) PATH TS))
                       img))
      img))

(define (decorate-on-visited m ws img)
  (local [(define visited (if (solve/p-args? ws)
                              (solve/p-args-visited ws)
                              (solve/lop-args-visited ws)))]
    (decorate-maze m
                   (lambda (p v)
                     (if (member? p visited) VIS TS))
                   img)))


(define (decorate-wall/open m ws img)
  (decorate-maze m
                 (lambda (p v)
                   (if (wall? v) WS OS))
                 img))

(define (position-of p lop)
  (local [(define (fn-for-lox lox i)
            (cond [(empty? lox) false]
                  [else
                   (if (equal? (first lox) p)
                       i
                       (fn-for-lox (rest lox) (add1 i)))]))]
    (fn-for-lox lop 0)))
;;
;; Each of the "decorators" adds some kind of highlighting to the maze.
;; You can turn them on/off by uncommenting/commenting the line, then
;; pressing the Run button, and then doing (main <some maze>) again
;; 
(define DECORATORS  
  (list decorate-p          ;highlight current position and
        ;;                  ;whether it it is a member of path or visited
        
        decorate-on-path    ;highlight positions that are in path
        
        decorate-on-visited ;highlight positions that are in visited
        
        decorate-on-p-wl    ;highlight positions in the primary worklist (p-wl)
        
        decorate-wall/open));highlight walls (leave on!)




;; foldr w/ extra index accumulator
(define (decorate-maze m fn img)
  (local [(define S (sqrt (length m)))
          ;; i is Integer; index number of (first lov) in original m          
          (define (fold lov i img)
            (cond [(empty? lov) img]
                  [else
                   (place-image (fn (i->pos i) (first lov))
                                (i->x i)
                                (i->y i)
                                (fold (rest lov) (add1 i) img))]))
          (define (i->pos i) (make-pos  (remainder i S) (quotient  i S)))
          (define (i->x i) (+ (* (remainder i S) SQUARE-SZ) (/ SQUARE-SZ 2)))
          (define (i->y i) (+ (* (quotient  i S) SQUARE-SZ) (/ SQUARE-SZ 2)))]
    
    (fold m 0 img)))

(define (render-call ws)
  (local [
          (define TRIM-LISTS-TO 3)
          
          ;; if list is longer than n0 replace everything after n w/ ....
          ;; Any -> Any
          (define (convert-all-lists x top?)
            (cond [(and (list? x) top?)
                   (map (lambda (x1) (convert-all-lists x1 false)) x)]
                  [(and (list? x) (false? top?))
                   (cons 'list
                         (trim-list
                          (map (lambda (x1) (convert-all-lists x1 false)) x)
                          TRIM-LISTS-TO))]
                  [else x]))

          ;; (listof Any) -> (listof Any)
          (define (trim-list lox n)
            (cond [(empty? lox) '()]
                  [(zero? n) (list '....)]                  
                  [else
                   (cons (first lox)
                         (trim-list (rest lox) (sub1 n)))]))

          ;; (listof Any) -> (listof Any)
          (define (convert-all-pos x)
            (cond [(pos? x) (list 'make-pos (pos-x x) (pos-y x))]
                  [(empty? x) '()]
                  [(list? x)
                   (cons (convert-all-pos (first x))
                         (convert-all-pos (rest x)))]
                  [else x]))]


    (if (and (solve/lop-args? ws)
             (empty? (solve/lop-args-p-wl ws)))
        empty-image
        (text (call-with-output-string
               (lambda (out)
                 (pretty-display
                  (convert-all-pos
                   (convert-all-lists
                    (if (solve/p-args? ws)
                        (list 'solve/p
                              (solve/p-args-p ws)
                              (solve/p-args-p-wl ws)
                              (solve/p-args-path ws)
                              (solve/p-args-path-wl ws)
                              (solve/p-args-visited ws))
                        (list 'solve/lop
                              (solve/lop-args-p-wl ws)
                              (solve/lop-args-path-wl ws)
                              (solve/lop-args-visited ws)))
                    true))
                  out)))
              TEXT-SIZE
              "black"))))
                  
            
    
