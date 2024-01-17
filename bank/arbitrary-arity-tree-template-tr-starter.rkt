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
;; Complete the design of the all-names function below. You should use the
;; tail recursive template. 
;;
;; The autograder will be looking for a tail-recursive function definition.
;;
(@htdf all-names)
(@signature Tree -> (listof String))
;; produce the names of all nodes in t
(check-expect (all-names L1) (list "L1"))
(check-expect (all-names M2) (list "M2" "L2" "L3"))
(check-expect (all-names TOP) (list "TOP" "M1" "L1" "M2" "L2" "L3"))


(define (all-names t) empty)
#;
(define (fn-for-tree-tr t)
  ;; acc is ...
  ;; t-wl is ...
  (local [(define (fn-for-t t t-wl acc)
            (local [(define name (node-name t))  ;unpack the fields
                    (define subs (node-subs t))] ;for convenience
              ;(... name
              (fn-for-lot (append (node-subs t) t-wl)
                          (... acc))))
          
          (define (fn-for-lot t-wl acc)
            (cond [(empty? t-wl) (... acc)]
                  [else
                   (fn-for-t (first t-wl)
                             (rest t-wl)
                             (... acc))]))]
         
    (fn-for-t t ... ...)))


(@problem 2)
;;
;; Complete the design of the count-nodes function below. You should use the
;; tail recursive template. 
;;
;; The autograder will be looking for a tail-recursive function definition.
;;

(@htdf count-nodes)
(@signature Tree -> Natural)
;; produce a count of the number of nodes in t
(check-expect (count-nodes L1) 1)
(check-expect (count-nodes M2) 3)
(check-expect (count-nodes TOP) 6)

(define (count-nodes t) 0)    ;stub
#;
(define (fn-for-tree-tr t)
  ;; acc is ...
  ;; t-wl is ...
  (local [(define (fn-for-t t t-wl acc)
            (local [(define name (node-name t))  ;unpack the fields
                    (define subs (node-subs t))] ;for convenience
              ;(... name
              (fn-for-lot (append (node-subs t) t-wl)
                          (... acc))))
          
          (define (fn-for-lot t-wl acc)
            (cond [(empty? t-wl) (... acc)]
                  [else
                   (fn-for-t (first t-wl)
                             (rest t-wl)
                             (... acc))]))]
         
    (fn-for-t t ... ...)))


(@problem 3)
;;
;; Complete the design of the all-leaves function below. You should use the
;; tail recursive template. 
;;
;; The autograder will be looking for a tail-recursive function definition.
;;
(@htdf all-leaves)
(@signature Tree -> (listof String))
;; produce the names of all leaf nodes (nodes without children) in t
(check-expect (all-leaves L1)  (list "L1"))
(check-expect (all-leaves M2)  (list "L2" "L3"))
(check-expect (all-leaves TOP) (list "L1" "L2" "L3"))

(define (all-leaves t) empty) ; stub
#;
(define (fn-for-tree-tr t)
  ;; acc is ...
  ;; t-wl is ...
  (local [(define (fn-for-t t t-wl acc)
            (local [(define name (node-name t))  ;unpack the fields
                    (define subs (node-subs t))] ;for convenience
              ;(... name
              (fn-for-lot (append (node-subs t) t-wl)
                          (... acc))))
          
          (define (fn-for-lot t-wl acc)
            (cond [(empty? t-wl) (... acc)]
                  [else
                   (fn-for-t (first t-wl)
                             (rest t-wl)
                             (... acc))]))]
         
    (fn-for-t t ... ...)))
