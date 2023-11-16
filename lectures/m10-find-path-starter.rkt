;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname m10-find-path-starter) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #t)))
(require spd/tags)
(@assignment lectures/m10-find-path)
(@cwl ???) ;replace ??? with your cwl


(@problem 1)

(@htdd Tree)

(define-struct node (name subs))
;; Tree is (make-node String (listof Tree))
;; interp. a bare bones arbitrary arity tree, each node has a name and subs

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

;;
;; PROBLEM
;;
;; Complete the design of the find-path function below.
;;
;; Your function definition should use a context preserving accumulator to
;; represent the path to the current tree.
;;

(@htdf find-path)

(@signature Tree String -> (listof String) or false)
;; produce names of nodes from t0 to node w/ given name (or fail)
(check-expect (find-path L1 "L1") (list "L1"))
(check-expect (find-path L1 "L2") false)
(check-expect (find-path L2 "L2") (list "L2"))
(check-expect (find-path M1 "L1") (list "M1" "L1"))
(check-expect (find-path TOP "L3") (list  "TOP" "M2" "L3"))

(@template-origin encapsulated Tree (listof Tree) try-catch accumulator)

(define (find-path t0 n)
  ;; path is ???;
  
  (local [(define (fn-for-t t path)
            (local [(define name (node-name t))  ;unpack the fields
                    (define subs (node-subs t))] ;for convenience
              
              (... path name (fn-for-lot subs (... path)))))
          
          (define (fn-for-lot lot path)
            (cond [(empty? lot) (... path)]
                  [else
                   (... path
                        (fn-for-t (first lot) (... path))
                        (fn-for-lot (rest lot) (... path)))]))]
    
    (fn-for-t t ...)))


