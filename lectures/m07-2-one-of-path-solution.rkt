;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname m07-2-one-of-path-solution) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #t)))
(require spd/tags)
(@assignment lectures/m07-2-one-of-path)

;; ======================================================================
;;
;; Consider the following two data definitions:
;;
(@problem 1)

(@htdd BinaryTree)

(define-struct node (k v l r))
;; BinaryTree is one of:
;;  - false
;;  - (make-node Natural String BinaryTree BinaryTree)
;; interp. 
;;  a binary tree, each node has a key, value and l/r children

(define BT0 false)
(define BT1 (make-node 1 "a" false false))
(define BT4 (make-node 4 "d"
                       (make-node 2 "b"
                                  (make-node 1 "a" false false)
                                  (make-node 3 "c" false false))
                       (make-node 5 "e" false false)))

(@htdd Path)
;; Path is one of:
;; - empty
;; - (cons "L" Path)
;; - (cons "R" Path)
;; interp. 
;;  A sequence of left and right 'turns' down through a BinaryTree
;;  (list "L" "R" "R") means take the left child of the tree, then
;;  the right child of that subtree, and the right child again.
;;  empty means you have arrived at the destination.

(define P1 empty)
(define P2 (list "L"))
(define P3 (list "R"))
(define P4 (list "L" "R"))


#|
Design the function has-path? that consumes BinaryTree and Path.
The function should produce true if following the path through the
tree leads to a node. If the path leads to false, or runs into false
before reaching the end of the path the function should produce false. 
Show the cross product of type comments table, the simplification,
and the correspondence between table cells and cond cases.
|#


(@htdf has-path?)
(@signature BinaryTree Path -> Boolean)
;; produce true if following p through bt leads to a node, not false
(check-expect (has-path? false empty) false)
(check-expect (has-path? false (list "L")) false)
(check-expect (has-path? false (list "R")) false)

(check-expect (has-path? BT4 empty) true)

(check-expect (has-path? BT4 P2)    true)
(check-expect (has-path? BT4 P3) true)
(check-expect (has-path? BT4 P4) true) 
(check-expect (has-path? BT4 (list "L" "R" "L")) false)

#|
          bt          false            (make-node Nat Str BT BT) 
 p

empty                 false  [1]       true                      [2]

(cons "L" Path)       false  [1]       (has-path? (node-l bt)    [3]
                                                  (rest p))

(cons "R" Path)       false  [1]       (has-path? (node-r bt)    [4]
                                                  (rest p))
|#

(@template-origin 2-one-of)

(define (has-path? bt p)   
  (cond [(false? bt) false]                                           ;[1]
        [(empty? p)  true]                                            ;[2]
        [(string=? (first p) "L") (has-path? (node-l bt) (rest p))]   ;[3]
        [else                     (has-path? (node-r bt) (rest p))])) ;[4]
