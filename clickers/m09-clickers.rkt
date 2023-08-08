;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname m09-clickers) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require spd/tags)








(@htdf silly)
(@signature (listof Number) -> (listof Number))
;; a silly little function on lists of numbers
(check-expect (silly empty) empty)
(check-expect (silly (list 8 4 12 9 10 1 2 3 4))
              (list 8 4 1))

(define (silly lon)
  (if (empty? lon)
      empty
      (local [(define f (first lon))
              (define (<f? x) (< x f))]
        (cons f
              (silly (filter <f? (rest lon)))))))


;;
;; PROBLEM 1 [30 seconds]
;;
;; What is the base case test for silly?
;;  (A) filter    (B) (rest lon)  (C) lon is empty  (D) 1
;;
;; PROBLEM 2 [30 seconds]
;;
;; What is the reduction step for silly?
;;  (A) (rest lon)    (B) (first lon)  (C) elements of (rest lon) < (first lon)
;;
;; PROBLEM 3 [20 seconds]
;;
;; Does silly always terminate?  Meaning for any list we call it with,
;; does it always produce a result?
;;  (A) YES   (B) NO
;;















(@htdf hailstones)
(@signature Natural -> (listof Natural))
;; produce hailstone sequence for n
;; CONSTRAINT integers in argument and result are >=1
(check-expect (hailstones 1) (list 1))
(check-expect (hailstones 2) (list 2 1))
(check-expect (hailstones 4) (list 4 2 1))
(check-expect (hailstones 5) (list 5 16 8 4 2 1))

(define (hailstones n)
  (if (= n 1) 
      (list 1)
      (cons n 
            (if (even? n)
                (hailstones (/ n 2))
                (hailstones (add1 (* n 3)))))))

;; PROBLEM 4 [30 seconds]
;;
;; What is the base case test for hailstones?
;;  (A) (even? n)    (B) (add1 (* n 3))  (C) (= n 1)  (D) (/ n 2)
;;
;;
;; PROBLEM 5 [30 seconds]
;;
;; The reduction step for hailstones is:
;;   if n is even  then  n/2
;;   if n is odd   then  n*3 + 1
;;
;; does hailstones terminate?
;;  (A) Yes   (B) No
;;




;; PROBLEM 1 [1:45]
;;
;; Here are just the first two local function definitions from the maze solver:

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







          
