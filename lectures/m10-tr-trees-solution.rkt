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
            (local [(define num  (node-number t))  ;unpack the fields
                    (define subs (node-subs t))]   ;for convenience
              
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

(define TOP1 (make-node 10 (list M1 M2)))  ;t->b and t/l -> b/r sorted

(define TOP2 (make-node 100 (list M1 M2))) ;not t->b

(define TOP3
  (make-node 10
             (list (make-node 100 empty)   ;not l->r
                   M1
                   M2)))


(@problem 1)

(@htdf t->b-sorted?)

(@signature Tree -> Boolean)
;; produce true if ever subtree has a number greater than its parent
(check-expect (t->b-sorted? L1) true)
(check-expect (t->b-sorted? M1) true)
(check-expect (t->b-sorted? TOP1) true)
(check-expect (t->b-sorted? TOP2) false)
(check-expect (t->b-sorted? TOP3) true)

(@template-origin encapsulated Tree (listof Tree) try-catch)

(define (t->b-sorted? t0)
  ;; pnum is Integer; immediate parent node's number
  ;; **PARENT** means the parent IN THE TREE
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
    
    (fn-for-t t0 (sub1 (node-number t0)))))


(@problem 2)

(@htdf top/left->bot/right-sorted?)

(@signature Tree -> Boolean)
;; produce tree w/ given number (or fail)
(check-expect (top/left->bot/right-sorted? L1) true)
(check-expect (top/left->bot/right-sorted? M1) true)
(check-expect (top/left->bot/right-sorted? TOP1) true)
(check-expect (top/left->bot/right-sorted? TOP2) false)
(check-expect (top/left->bot/right-sorted? TOP3) false)

(@template-origin encapsulated Tree (listof Tree) try-catch)

(define (top/left->bot/right-sorted? t0)
  ;; vnum is Integer; immediate previous visited node number
  ;; t-wl
  ;; PREVIOUS **VISITED** MEANS IN THE FLOW OF THE TAIL RECURSION
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
    
    (fn-for-t t0 empty (sub1 (node-number t0)))))





(@problem 3)

(@htdf count-nodes)

(@signature Tree -> Natural)
;; produce count of all nodes in the given tree
(check-expect (count-nodes L1) 1)
(check-expect (count-nodes M2) 3)
(check-expect (count-nodes TOP) 6)

(@template-origin encapsulated Tree (listof Tree))

(define (count-nodes t) 0)

;;
;; SOLUTION MUST BE TAIL RECURSIVE.  TO HELP YOU GET STARTED, HERE
;; ARE THE TWO ACCUMULATOR INVARIANTS WE WANT YOU TO USE.
;;
;; t-wl is (listof Tree); worklist of Trees to visit
;;                        unvisited direct subs of visited trees
;; count is Natural; number of nodes visited in tail recursion so far
;; 
;; SOLUTION DELIBERATELY NOT PROVIDE TO HELP YOU PRACTICE WITHOUT
;; LOOKING AT THE SOLUTION.  BUT THIS ONE DOES NEED RSF.
;;


(@problem 4)

(@htdf all-numbers)

(@signature Tree -> (listof String))
;; produce list of numbers of all nodes in the given tree
(check-expect (all-numbers L1) (list "L1"))
(check-expect (all-numbers M2) (list "M2" "L2" "L3"))
(check-expect (all-numbers TOP) (list "TOP" "M1" "L1" "M2" "L2" "L3"))

(@template-origin encapsulated Tree (listof Tree))

(define (all-numbers t) empty)

;; 
;; SOLUTION MUST BE TAIL RECURSIVE.
;;
;; SOLUTION DELIBERATELY NOT PROVIDE TO HELP YOU PRACTICE WITHOUT
;; LOOKING AT THE SOLUTION. ALSO NEEDS RSF.


(@problem 5)

(@htdf all-leaf-nums)

(@signature Tree -> (listof Tree))
;; produce list of all leaf nodes in the given tree
(check-expect (all-leaf-nums L1) (list L1))
(check-expect (all-leaf-nums M2) (list L2 L3))
(check-expect (all-leaf-nums TOP) (list L1 L2 L3))

(@template-origin encapsulated Tree (listof Tree))

(define (all-leaf-nums t) empty)

;; 
;; SOLUTION MUST BE TAIL RECURSIVE.
;;
;; SOLUTION DELIBERATELY NOT PROVIDE TO HELP YOU PRACTICE WITHOUT
;; LOOKING AT THE SOLUTION. ALSO NEEDS RSF.

