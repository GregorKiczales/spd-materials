;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname m10-find-tree-solution) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #t)))
(require spd/tags)
(@assignment lectures/m10-find-tree)



(@htdd Tree) 

(define-struct node (name subs))
;; Tree is (make-node String (listof Tree))
;; interp. a bare bones arbitrary arity tree, each node has a name and subs
;;
;; NOTE: The template has a little extra in it to help with the functions
;;       we will be writing.

(define (fn-for-tree t)  
  (local [(define (fn-for-t t)
            (local [(define name (node-name t))  ;unpack the fields
                    (define subs (node-subs t))] ;for convenience
              
              (... name (fn-for-lot subs))))
          
          (define (fn-for-lot lot)
            (cond [(empty? lot) (...)]
                  [else
                   (... (fn-for-t (first lot))
                        (fn-for-lot (rest lot)))]))]
    
    (fn-for-t t)))

(define L1 (make-node "L1" empty))
(define L2 (make-node "L2" empty))
(define L3 (make-node "L3" empty))

(define M1 (make-node "M1" (list L1)))
(define M2 (make-node "M2" (list L2 L3)))

(define TOP (make-node "TOP" (list M1 M2)))


(@problem 1)

(@htdf find-tree)

(@signature Tree String -> Tree or false)
;; produce tree w/ given name (or fail)
(check-expect (find-tree L1 "L1") L1)
(check-expect (find-tree L1 "L2") false)
(check-expect (find-tree L2 "L2") L2)    
(check-expect (find-tree M1 "L1") L1)
(check-expect (find-tree TOP "L3") L3)

(@template-origin encapsulated Tree (listof Tree) try-catch)

(define (find-tree t tn)
  (local [(define (fn-for-t t)
            (local [(define name (node-name t))  ;unpack the fields
                    (define subs (node-subs t))] ;for convenience
              (if (string=? name tn)         
                  t         
                  (fn-for-lot subs))))
          
          (define (fn-for-lot lot)
            (cond [(empty? lot) false]
                  [else     
                   (local [(define try (fn-for-t (first lot)))]
                     (if (not (false? try))
                         try         
                         (fn-for-lot (rest lot))))]))]
    
    (fn-for-t t)))


(@problem 2)

(@htdf find-tree/tr)

(@signature Tree String -> Tree or false)
;; produce tree w/ given name (or fail)
(check-expect (find-tree/tr L1 "L1") L1)
(check-expect (find-tree/tr L1 "L2") false)
(check-expect (find-tree/tr L2 "L2") L2)
(check-expect (find-tree/tr M1 "L1") L1)
(check-expect (find-tree/tr TOP "L3") L3)


(@template-origin encapsulated Tree (listof Tree) accumulator) ;no try-catch!

;; Tail recursion
(define (find-tree/tr t tn)
  ;; tree-wl is (listof Tree); worklist of trees to visit
  ;; the unvisited direct subs of all the visited trees
  ;; aka the upper left fringe of the unvisited part of original tree
  (local [(define (fn-for-t t tree-wl)         
            (local [(define name (node-name t))  ;unpack the fields
                    (define subs (node-subs t))] ;for convenience
              (if (string=? name tn)
                  t    
                  (fn-for-lot (append subs tree-wl)))))
          
          (define (fn-for-lot tree-wl)
            (cond [(empty? tree-wl) false]
                  [else          
                   (fn-for-t (first tree-wl)
                             (rest tree-wl))]))]
    
    (fn-for-t t empty)))


(@problem 3)

(@htdf count-nodes)

(@signature Tree -> Natural)
;; produce count of all nodes in the given tree
(check-expect (count-nodes L1) 1)
(check-expect (count-nodes M2) 3)
(check-expect (count-nodes TOP) 6)

(@template-origin encapsulated Tree (listof Tree))

(define (count-nodes t) 0)

;; SOLUTION DELIBERATELY NOT PROVIDE TO HELP YOU PRACTICE WITHOUT
;; LOOKING AT THE SOLUTION.  BUT THIS ONE DOES NEED RSF.


(@problem 4)

(@htdf all-names)

(@signature Tree -> (listof String))
;; produce list of names of all nodes in the given tree
(check-expect (all-names L1) (list "L1"))
(check-expect (all-names M2) (list "M2" "L2" "L3"))
(check-expect (all-names TOP) (list "TOP" "M1" "L1" "M2" "L2" "L3"))

(@template-origin encapsulated Tree (listof Tree))

(define (all-names t) empty)

;; SOLUTION DELIBERATELY NOT PROVIDE TO HELP YOU PRACTICE WITHOUT
;; LOOKING AT THE SOLUTION. ALSO NEEDS RSF.


(@problem 5)

(@htdf all-leaves)

(@signature Tree -> (listof Tree))
;; produce list of all leaf nodes in the given tree
(check-expect (all-leaves L1) (list L1))
(check-expect (all-leaves M2) (list L2 L3))
(check-expect (all-leaves TOP) (list L1 L2 L3))

(@template-origin encapsulated Tree (listof Tree))

(define (all-leaves t) empty)

;; SOLUTION DELIBERATELY NOT PROVIDE TO HELP YOU PRACTICE WITHOUT
;; LOOKING AT THE SOLUTION. ALSO NEEDS RSF.

