;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname m10-find-tree-starter) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #t)))
(require spd/tags)
(@assignment lectures/m10-find-tree)
(@cwl ???) ;replace ??? with your cwl


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
;;
;; Complete the design of the following function using the templates
;; provided.  Use ordinary recursion as we have used all term.
;;
;; NOTE: you must not rename any locally defined functions from the template.
;;
;; This is not a trick problem, it is an ordinary backtracking search.

(@htdf find-tree)

(@signature Tree String -> Tree or false)
;; produce tree w/ given name (or fail)
(check-expect (find-tree L1 "L1") L1)
(check-expect (find-tree L1 "L2") false)
(check-expect (find-tree L2 "L2") L2)
(check-expect (find-tree M1 "L1") L1)
(check-expect (find-tree TOP "L3") L3)

(@template-origin encapsulated Tree (listof Tree) try-catch)

(define (find-tree t name) false) ;delete this when you start
#;
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



(@problem 2)
;;
;; Define a new version of the function which is tail recursive.  Below
;; we have set you up with everything you had above, for a new function
;; that is named find-tree/tr.
;;
;; Proceed by
;;   - copying your solution from the problem above to down below
;;   - rename the copy to find-tree/tr
;;   - then convert the code to be tail recursive
;;
;; NOTE: you must not rename any locally defined functions from the template


(@htdf find-tree/tr)

(@signature Tree String -> Tree or false)
;; produce tree w/ given name (or fail)
(check-expect (find-tree/tr L1 "L1") L1)
(check-expect (find-tree/tr L1 "L2") false)
(check-expect (find-tree/tr L2 "L2") L2)
(check-expect (find-tree/tr M1 "L1") L1)
(check-expect (find-tree/tr TOP "L3") L3)

(@template-origin encapsulated Tree (listof Tree) try-catch)

(define (find-tree/tr t tn) false) ;delete this when you start

;;
;; THE FOLLOWING PROBLEMS ARE FOR ADDITIONAL PRACTICE. THE LECTURE AUTOGRADER
;; WILL GRADE THEM, BUT THEY RECEIVE A WEIGHT OF 0, SO THEY ARE NOT REQUIRED
;; AS PART OF THE LECTURE WORK.
;;
;; In each problem you must complete the function design with a TAIL RECURSIVE
;; function definition based on the templates provided.  Be sure to document
;; all accumulators with type and invariant.
;;
;; HINT: All of these functions require an rsf accumulator.  You may want to
;; begin by first adding a t-wl worklist accumulator to make the templates
;; tail-recursive, and then adding the rsf accumulator.
;;

(@problem 3)

(@htdf count-nodes)

(@signature Tree -> Natural)
;; produce count of all nodes in the given tree
(check-expect (count-nodes L1) 1)
(check-expect (count-nodes M2) 3)
(check-expect (count-nodes TOP) 6)

(@template-origin encapsulated Tree (listof Tree))

;;
;; The following is a templated filled in with JUST a worklist
;; accumulator.  So as it is it traverses the entire tree and
;; then always produces 0.  Start your work by designing an
;; rsf accumulator for this function. Then add it to the code.
;;

(define (count-nodes t0)
  ;; t-wl is (listof Tree); worklist of trees to visit
  ;; the unvisited direct subs of all the visited trees
  ;; aka the upper left fringe of the unvisited part of original tree
  (local [(define (fn-for-t t t-wl)
            (local [(define name (node-name t))  ;unpack the fields
                    (define subs (node-subs t))] ;for convenience
              (fn-for-lot (append subs t-wl))))
          
          (define (fn-for-lot t-wl)
            (cond [(empty? t-wl) 0]
                  [else          
                   (fn-for-t (first t-wl)
                             (rest t-wl))]))]
    
    (fn-for-t t0 empty)))


(@problem 4)

(@htdf all-names)

(@signature Tree -> (listof String))
;; produce list of names of all nodes in the given tree
(check-expect (all-names L1) (list "L1"))
(check-expect (all-names M2) (list "M2" "L2" "L3"))
(check-expect (all-names TOP) (list "TOP" "M1" "L1" "M2" "L2" "L3"))

(@template-origin encapsulated Tree (listof Tree))

;;
;; The following is a templated filled in with JUST a worklist
;; accumulator.  So as it is it traverses the entire tree and
;; then always produces empty.  Start your work by designing an
;; rsf accumulator for this function. Then add it to the code.
;;

(define (count-nodes t0)
  ;; t-wl is (listof Tree); worklist of trees to visit
  ;; the unvisited direct subs of all the visited trees
  ;; aka the upper left fringe of the unvisited part of original tree
  (local [(define (fn-for-t t t-wl)
            (local [(define name (node-name t))  ;unpack the fields
                    (define subs (node-subs t))] ;for convenience
              (fn-for-lot (append subs t-wl))))
          
          (define (fn-for-lot t-wl)
            (cond [(empty? t-wl) empty]
                  [else          
                   (fn-for-t (first t-wl)
                             (rest t-wl))]))]
    
    (fn-for-t t0 empty)))



(@problem 5)

(@htdf all-leaves)

(@signature Tree -> (listof Tree))
;; produce list of all leaf nodes in the given tree
(check-expect (all-leaves L1) (list L1))
(check-expect (all-leaves M2) (list L2 L3))
(check-expect (all-leaves TOP) (list L1 L2 L3))

(@template-origin encapsulated Tree (listof Tree))

(define (all-leaves t) empty)

;;
;; In this case we are giving you just the raw data driven
;; non-tail recursive templates.  Work in 2 steps:
;;  - make these templates produce the correct answer
;;    but NOT using tail recursiion
;;  - then convert the code to be tail recursive
;;

#;
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

