;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname m10-find-path-solution) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #t)))
(require spd/tags)
(@assignment lectures/m10-find-path)
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
  ;; path is (listof String); names of ... grandparent, parent trees to here
  ;;                          (builds along recursive  calls)
  (local [(define (fn-for-t t path)      
            (local [(define name (node-name t))
                    (define subs (node-subs t))
                    (define npath (append path (list name)))] ;including t
              (if (string=? name n)
		  npath
                  (fn-for-lot subs npath))))
          
          (define (fn-for-lot lot path)
            (cond [(empty? lot) false]
                  [else     
		   (local [(define try (fn-for-t (first lot) path))]
                     (if (not (false? try))
                         try          
                         (fn-for-lot (rest lot) path)))]))]
    
    (fn-for-t0 t empty)))


