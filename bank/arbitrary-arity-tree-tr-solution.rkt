;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname arb-tree-tr-starter) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #t)))
(require spd/tags)

(@assignment bank/arbitrary-arity-tree-tr)

(@cwl ???)


(@htdd Tree) 

(define-struct node (name subs))
;; Tree is (make-node String (listof Tree))
;; interp. a bare bones arbitrary arity tree, each node has a name and subs

(define L1 (make-node "L1" empty))
(define L2 (make-node "L2" empty))
(define L3 (make-node "L3" empty))

(define M1 (make-node "M1" (list L1)))
(define M2 (make-node "M2" (list L2 L3)))

(define TOP (make-node "TOP" (list M1 M2)))

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



(@problem 1)
;;
;; Complete the design of the all-names function below.
;;
;; You MAY want to complete a structural recursion version of the function
;; definition first, test it, then copy that, and systematically convert it
;; to tail recursion.
;;
;; The autograder will be looking for a tail-recursive version.
;;
(@htdf all-names)
(@signature Tree -> (listof String))
;; produce the names of all nodes in t
(check-expect (all-names L1) (list "L1"))
(check-expect (all-names M2) (list "M2" "L2" "L3"))
(check-expect (all-names TOP) (list "TOP" "M1" "L1" "M2" "L2" "L3"))

#;#;
(@template-origin Tree (listof Tree) encapsulated)

(define (all-names t)   
  (local [(define (fn-for-t t)
            (local [(define name (node-name t))  ;unpack the fields
                    (define subs (node-subs t))] ;for convenience
              
              (cons name (fn-for-lot subs))))
          
          (define (fn-for-lot lot)
            (cond [(empty? lot) empty]
                  [else
                   (append (fn-for-t (first lot))
                           (fn-for-lot (rest lot)))]))]
    
    (fn-for-t t)))



(@template-origin Tree (listof Tree) accumulator)
(define (all-names t)
  ;; rsf is (listof String): names of nodes visited so far
  ;; t-wl is (listof Tree): worklist accumulator of nodes needed to be visited
  (local [(define (fn-for-t t t-wl rsf)
            (local [(define name (node-name t))  ;unpack the fields
                    (define subs (node-subs t))] ;for convenience
              
              (fn-for-lot (append subs t-wl)
                          (cons name rsf))))
                         
          (define (fn-for-lot t-wl rsf)
            (cond [(empty? t-wl) (reverse rsf)]
                  [else
                   (fn-for-t (first t-wl) (rest t-wl) rsf)]))]
                          
    (fn-for-t t empty empty)))


(@problem 2)
;;
;; Complete the design of the count-nodes function below.
;;
;; You MAY want to complete a structural recursion version of the function
;; definition first, test it, then copy that, and systematically convert it
;; to tail recursion.
;;
;; The autograder will be looking for a tail-recursive version.
;;

(@htdf count-nodes)
(@signature Tree -> Natural)
;; produce a count of the number of nodes in t
(check-expect (count-nodes L1) 1)
(check-expect (count-nodes M2) 3)
(check-expect (count-nodes TOP) 6)

#;#;
(@template-origin Tree (listof Tree) encapsulated)

(define (count-nodes t)   
  (local [(define (fn-for-t t)
            (local [(define name (node-name t))  ;unpack the fields
                    (define subs (node-subs t))] ;for convenience
              
              (add1 (fn-for-lot subs))))
          
          (define (fn-for-lot lot)
            (cond [(empty? lot) 0]
                  [else
                   (+ (fn-for-t (first lot))
                      (fn-for-lot (rest lot)))]))]
    
    (fn-for-t t)))



(@template-origin Tree (listof Tree) accumulator)
(define (count-nodes t)
  ;; rsf is Natural: number of nodes visited so far
  ;; t-wl is (listof Tree): worklist accumulator of nodes needed to be visited
  (local [(define (fn-for-t t t-wl rsf)
            (local [(define name (node-name t))  ;unpack the fields
                    (define subs (node-subs t))] ;for convenience
              
              (fn-for-lot (append subs t-wl)
                          (add1 rsf))))
                         
          (define (fn-for-lot t-wl rsf)
            (cond [(empty? t-wl) rsf]
                  [else
                   (fn-for-t (first t-wl) (rest t-wl) rsf)]))]
                          
    (fn-for-t t empty 0)))


(@problem 3)
;;
;; Complete the design of the all-leaves function below.
;;
;; You MAY want to complete a structural recursion version of the function
;; definition first, test it, then copy that, and systematically convert it
;; to tail recursion.
;;
;; The autograder will be looking for a tail-recursive version.
;;
(@htdf all-leaves)
(@signature Tree -> (listof String))
;; produce the names of all leaf nodes (nodes without children) in t
(check-expect (all-leaves L1)  (list "L1"))
(check-expect (all-leaves M2)  (list "L2" "L3"))
(check-expect (all-leaves TOP) (list "L1" "L2" "L3"))

#;#;
(@template-origin Tree (listof Tree) encapsulated)

(define (all-leaves t)
  (local [(define (fn-for-t t)
            (local [(define name (node-name t))  ;unpack the fields
                    (define subs (node-subs t))] ;for convenience

              (if (empty? subs)
                  (list t)
                  (fn-for-lot subs))))
          
          (define (fn-for-lot lot)
            (cond [(empty? lot) empty]
                  [else
                   (append (fn-for-t (first lot))
                           (fn-for-lot (rest lot)))]))]
    
    (fn-for-t t)))



(@template-origin Tree (listof Tree) accumulator)
(define (all-leaves t)
  ;; rsf is (listof Tree): tree nodes visited so far
  ;; t-wl is (listof Tree): worklist accumulator of nodes needed to be visited
  (local [(define (fn-for-t t t-wl rsf)
            (local [(define name (node-name t))  ;unpack the fields
                    (define subs (node-subs t))] ;for convenience
              
              (fn-for-lot (append subs t-wl)
                          (if (empty? subs)
                              (append rsf (list name))
                              rsf))))
                         
          (define (fn-for-lot t-wl rsf)
            (cond [(empty? t-wl) rsf]
                  [else
                   (fn-for-t (first t-wl) (rest t-wl) rsf)]))]
                          
    (fn-for-t t empty empty)))
