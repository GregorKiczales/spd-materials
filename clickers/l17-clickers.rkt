;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname l17-clickers) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #t)))
(require spd/tags)


;; PROBLEM 1 [1:45]
;;
;; Here are just the first two local function definitions from the maze solver
;; in the last lecture:

(define (solvable? m)
  ;; base case test: solved? is is pos lower right
  ;; reduction: down and right but within maze and no walls
  ;; argument: maze is finite, so moving only down or right
  ;;           must run into walls, edge of maze, or solved
  (local [(define (fn-for-pos p)
            (cond [(solved? p) true]
                  [else
                   (fn-for-lop (valid-next-positions p))]))

          (define (fn-for-lop lop)
            (cond [(empty? lop) false]
                  [else
                   (local [(define try (fn-for-pos (first lop)))]
                     (if (not (false? try))
                         try
                         (fn-for-lop (rest lop))))]))
          ...
          ]))

;; What is the most correct template tag for this code:

;; A. (@template-origin encapsulated Pos (listof Pos))
;; B. (@template-origin encapsulated Pos (listof Pos) try-catch)
;; C. (@template-origin encapsulated genrec Pos (listof Pos) try-catch)
;; D. (@template-origin encapsulated genrec arb-tree try-catch)
;; E. (@template-origin encapsulated genrec arb-tree Pos try-catch)




;; PROBLEM 2 [45 seconds]
;;
;; Here is the same code, in which some part of the code are now in UPPERCASE.
;; Please ignore the fact that making it uppercase means it will no longer
;; run.  

(define (solvable? m)
  ;; base case test: solved? is is pos lower right
  ;; reduction: down and right but within maze and no walls
  ;; argument: maze is finite, so moving only down or right
  ;;           must run into walls, edge of maze, or solved
  (local [(define (fn-for-pos p)
            (COND [(SOLVED? p) true]
                  [else
                   (fn-for-lop (VALID-NEXT-POSITIONS P))]))

          (define (fn-for-lop lop)
            (cond [(empty? lop) false]
                  [else
                   (local [(define try (fn-for-pos (first lop)))]
                     (if (not (false? try))
                         try
                         (fn-for-lop (rest lop))))]))
          ...
          ]))

;; Which template origins does the UPPERCASE code come from?

;; A. try-catch
;; B. genrec
;; C. arb-tree


;; PROBLEM 2 [45 seconds]
;;
;; Here is the same code, in which some parts of the code are now in UPPERCASE.
;; Please ignore the fact that making it uppercase means it will no longer
;; run.

(define (solvable? m)
  ;; base case test: solved? is is pos lower right
  ;; reduction: down and right but within maze and no walls
  ;; argument: maze is finite, so moving only down or right
  ;;           must run into walls, edge of maze, or solved
  (local [(DEFINE (FN-FOR-POS P)
            (cond [(solved? P) true]
                  [else
                   (FN-FOR-LOP (valid-next-positions p))]))

          (DEFINE (FN-FOR-LOP LOP)
            (COND [(EMPTY? LOP) false]
                  [else
                   (local [(define try (FN-FOR-POS (FIRST LOP)))]
                     (if (not (false? try))
                         try
                         (FN-FOR-LOP (REST LOP))))]))


;; Which template origins does the UPPERCASE code come from?

;; A. try-catch
;; B. genrec
;; C. arb-tree







          