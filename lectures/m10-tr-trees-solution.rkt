;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname m10-tr-trees-solution) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #t)))
(require spd/tags)
(@assignment lectures/m10-tr-trees)



(@htdd Tree) 

(define-struct node (number subs))
;; Tree is (make-node Integer (listof Tree))
;; interp. a bare bones arbitrary arity tree, each node has a number and subs
;;
;; NOTE: The template has a little extra in it to help with the functions
;;       we will be writing.

(define (fn-for-tree t)  
  (local [(define (fn-for-t t)
            (local [(define number (node-number t))  ;unpack the fields
                    (define subs   (node-subs t))]   ;for convenience
              
              (... number (fn-for-lot subs))))
          
          (define (fn-for-lot lot)
            (cond [(empty? lot) (...)]
                  [else
                   (... (fn-for-t (first lot))
                        (fn-for-lot (rest lot)))]))]
    
    (fn-for-t t)))

(define L1 (make-node 30 empty))
(define L2 (make-node 50 empty))
(define L3 (make-node 60 empty))

(define M1 (make-node 20 (list L1)))
(define M2 (make-node 40 (list L2 L3)))

(define TOP1 (make-node 10 (list M1 M2)))  ;top->bot and t/l -> b/r sorted

(define TOP2 (make-node 100 (list M1 M2))) ;not top->bot

(define TOP3
  (make-node 10
             (list (make-node 100 empty)   ;not l->r
                   M1
                   M2)))


(@problem 1)

(@htdf top->bot-sorted?)

(@signature Tree -> Boolean)
;; produce true if every num is greater than all nodes above it
(check-expect (top->bot-sorted? L1) true)
(check-expect (top->bot-sorted? M1) true)
(check-expect (top->bot-sorted? TOP1) true)
(check-expect (top->bot-sorted? TOP2) false)
(check-expect (top->bot-sorted? TOP3) true)

(@template-origin Tree (listof Tree) accumulator) 

(define (top->bot-sorted? t0)
  ;; pnum is Integer; immediate parent node's number
  ;; **parent means the parent in the tree **
  (local [(define (fn-for-t t pnum)
            (local [(define number (node-number t))  ;unpack the fields
                    (define subs (node-subs t))]     ;for convenience
              (if (> number pnum)
                  (fn-for-lot subs number)
                  false)))
          
          (define (fn-for-lot lot pnum)
            (cond [(empty? lot) true]
                  [else
                   (and (fn-for-t (first lot) pnum)
                        (fn-for-lot (rest lot) pnum))]))]
    
    (fn-for-lot (node-subs t0) (node-number t0))))


(@problem 2)

(@htdf top/left->bot/right-sorted?)

(@signature Tree -> Boolean)
;; produce true if every number in t0 is > any number above or to the left of it
(check-expect (top/left->bot/right-sorted? L1) true)
(check-expect (top/left->bot/right-sorted? M1) true)
(check-expect (top/left->bot/right-sorted? TOP1) true)
(check-expect (top/left->bot/right-sorted? TOP2) false)
(check-expect (top/left->bot/right-sorted? TOP3) false)

(@template-origin Tree (listof Tree) accumulator)

(define (top/left->bot/right-sorted? t0)
  ;; t-wl is (listof Tree); worklist of Trees to visit
  ;;                        unvisited direct subs of visited trees
  ;; vnum is Integer; node number of most recently VISITED node
  ;; ** visited means in the dynamic flow of the tail recursion **
  ;; ** not in the static structure of the tree                 **
  (local [(define (fn-for-t t t-wl vnum)
            (local [(define number (node-number t))  ;unpack the fields
                    (define subs (node-subs t))]     ;for convenience
              (if (> number vnum)
                  (fn-for-lot (append subs t-wl) number)
                  false)))
          
          (define (fn-for-lot t-wl vnum)
            (cond [(empty? t-wl) true]
                  [else
                   (fn-for-t (first t-wl) (rest t-wl) vnum)]))]
    
    (fn-for-lot (node-subs t0) (node-number t0))))





(@problem 3)

(@htdf count-nodes)

(@signature Tree -> Natural)
;; produce count of all nodes in the given tree
(check-expect (count-nodes L1) 1)
(check-expect (count-nodes M1) 2)
(check-expect (count-nodes TOP1) 6)
(check-expect (count-nodes TOP2) 6)
(check-expect (count-nodes TOP3) 7)

(@template-origin Tree (listof Tree) accumulator)

(define (count-nodes t0)
  ;; t-wl is (listof Tree); worklist of Trees to visit
  ;;                        unvisited direct subs of visited trees
  ;; count is Natural; number of nodes VISITED in tail recursion before t
  ;; ** visited means in the dynamic flow of the tail recursion **
  ;; ** not in the static structure of the tree                 **
  (local [(define (fn-for-t t t-wl n)
            (local [(define subs (node-subs t))]
              (fn-for-lot (append subs t-wl) (add1 n))))
          
          (define (fn-for-lot t-wl n)
            (cond [(empty? t-wl) n]
                  [else
                   (fn-for-t (first t-wl) (rest t-wl) n)]))]
    
    (fn-for-t t0 empty 0)))



;;
;; SOLUTION MUST BE TAIL RECURSIVE.  TO HELP YOU GET STARTED, HERE
;; ARE THE TWO ACCUMULATOR INVARIANTS WE WANT YOU TO USE.
;

;; 



(@problem 4)

(@htdf all-numbers)

(@signature Tree -> (listof Integer))
;; produce list of numbers of all nodes in the given tree
(check-expect (all-numbers L1) (list 30))
(check-expect (all-numbers M1) (list 20 30))
(check-expect (all-numbers TOP1) (list 10 20 30 40 50 60))
(check-expect (all-numbers TOP2) (list 100 20 30 40 50 60))
(check-expect (all-numbers TOP3) (list 10 100 20 30 40 50 60))

(@template-origin Tree (listof Tree) accumulator)

(define (all-numbers t0)
  ;; t-wl is (listof Tree); worklist of Trees to visit
  ;;                        unvisited direct subs of visited trees
  ;; rsf is (listof Natural); numbers of nodes VISITED before t in reverse order
  ;; ** visited means in the dynamic flow of the tail recursion **
  ;; ** not in the static structure of the tree                 **
  (local [(define (fn-for-t t t-wl rsf)
            (local [(define number (node-number t))
                    (define subs   (node-subs t))]
              (fn-for-lot (append subs t-wl) (cons number rsf))))
          
          (define (fn-for-lot t-wl rsf)
            (cond [(empty? t-wl) (reverse rsf)]
                  [else
                   (fn-for-t (first t-wl) (rest t-wl) rsf)]))]
    
    (fn-for-t t0 empty empty)))


(@problem 5)

(@htdf all-leaves)

(@signature Tree -> (listof Tree))
;; produce list of all leaf nodes in the given tree
(check-expect (all-leaves L1) (list L1))
(check-expect (all-leaves M1) (list L1))
(check-expect (all-leaves TOP1) (list L1 L2 L3))
(check-expect (all-leaves TOP2) (list L1 L2 L3))
(check-expect (all-leaves TOP3) (list (make-node 100 empty) L1 L2 L3))

(@template-origin Tree (listof Tree) accumulator)

(define (all-leaves t0)
  ;; t-wl is (listof Tree); worklist of Trees to visit
  ;;                        unvisited direct subs of visited trees
  ;; rsf is (listof Tree); leaf trees visited before t
  ;; ** visited means in the dynamic flow of the tail recursion **
  ;; ** not in the static structure of the tree                 **
  (local [(define (fn-for-t t t-wl rsf)
            (local [(define subs (node-subs t))]
              (if (empty? subs)
                  (fn-for-lot              t-wl  (cons t rsf))
                  (fn-for-lot (append subs t-wl)         rsf))))
          
          (define (fn-for-lot t-wl rsf)
            (cond [(empty? t-wl) (reverse rsf)]
                  [else
                   (fn-for-t (first t-wl) (rest t-wl) rsf)]))]
    
    (fn-for-t t0 empty empty)))

