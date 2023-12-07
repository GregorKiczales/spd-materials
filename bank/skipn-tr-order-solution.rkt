;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname f-p6-solution) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #t #t none #f () #f)))
(require spd/tags)

(@assignment bank/skipn-tr-order)

(@cwl ???)

#|
 Below are data definitions for a simple graph FROM LECTURE 22.

 REVIEW THEM, AND THEN PROCEED TO THE PROBLEM INSTRUCTIONS BELOW.
|#


;; =================
;; DATA DEFINITIONS: 

(@htdd Node)
(define-struct node (number nexts))
;; Node is (make-node Natural (listof String))
;; interp. node's number, and list of numbers of nodes that the arrows point to

(define N101 (make-node 101 (list 102 108 107)))


(@htdd Map)
#|
 A Map is AN OPAQUE DATA STRUCTURE that represents one or more maps.
 OPAQUE means you can't look inside it.  THE ONLY THING YOU ARE  ALLOWED TO DO
 WITH A MAP IS PASS IT TO generate-node.

 generate-node is defined at the bottom of the file. You should treat it as a
 primitive function described as follows:

 generate node
 Map Natural -> Node

 If a node with the given number exists in map then generate and produce it.
 Signal an error if no node with the given number exists in the map.

 The bottom of the file defines a map called MAP for the graphs shown in
 this figure:

   https://cs110.students.cs.ubc.ca/lectures/m11-out-of-order-figure.png
 
 But the functions you design must work for any map.
|#

;;
;; Normal recursion and tail recursion templates for this kind of graph:
;;
#;
(define (fn-for-graph/nr map num0)  
  (local [(define (fn-for-node n)
            (local [(define num (node-number n))
                    (define nexts (node-nexts n))]
              (cond [(...) (...)] ;stop cycles
                    [else
                     (fn-for-lonn nexts)])))
          
          (define (fn-for-lonn lonn)
            (cond [(empty? lonn) (...)]
                  [else
                   (... (first lonn)
                        (fn-for-node (generate-node map (first lonn))))]))]
    
    (fn-for-? ...num0))) 

#;
(define (fn-for-graph/tr map num0)
  ;; nn-wl is (listof Natural); node number worklist
  ;; fn-for-node adds the unvisited direct subs of n
  ;; fn-for-lonn takes node numbers off one at a time to call fn-for-node
  (local [(define (fn-for-node n nn-wl)
            (local [(define num (node-number n))
                    (define nexts (node-nexts n))]
              (cond [(...) (...)] ;stop cycles
                    [else
                     (fn-for-lonn (append nexts nn-wl))])))
          
          (define (fn-for-lonn nn-wl visited)
            (cond [(empty? nn-wl) (...)] 
                  [else
                   (fn-for-node (generate-node map (first nn-wl))
                                (rest nn-wl))]))]

    (fn-for-? ...num0)))




;; =================
;; Functions:


(@problem 1)



(@htdf skipn-tr-order)
(@signature Map Natural Natural -> Natural)
;; in TR traversal of graph from start, produce first node num, skip n, repeat

(check-expect (skipn-tr-order MAP   1 2) (list 1 3 5 8))
(check-expect (skipn-tr-order MAP   1 3) (list 1 4 8))
(check-expect (skipn-tr-order MAP  11 2) (list 11 13 15 17))
(check-expect (skipn-tr-order MAP  11 3) (list 11 14 17))
(check-expect (skipn-tr-order MAP 101 2) (list 101 103 105 108))
(check-expect (skipn-tr-order MAP 101 3) (list 101 104 108))

(@template-origin genrec arb-tree accumulator)

(define (skipn-tr-order map start count)
  ;; nn-wl is (listof Natural);   worklist of node numbers
  ;; visited is (listof Natural); numbers of nodes already visited in the tr
  ;; pick is Natural; number till next pick
  ;; rsf
  (local [(define (fn-for-node n nn-wl visited pick rsf)
            (cond [(member (node-number n) visited)
                   (fn-for-lonn nn-wl visited pick rsf)]
                  [(zero? pick)
                   (fn-for-lonn (append (node-nexts n) nn-wl)
                                (cons (node-number n) visited)
                                (sub1 count)
                                (cons (node-number n) rsf))]
                  [else
                   (fn-for-lonn (append (node-nexts n) nn-wl) 
                                (cons (node-number n) visited)
                                (sub1 pick)
                                rsf)]))
          
          (define (fn-for-lonn nn-wl visited pick rsf)
            (cond [(empty? nn-wl) (reverse rsf)] 
                  [else
                   (fn-for-node (generate-node map (first nn-wl))
                                (rest nn-wl)
                                visited
                                pick
                                rsf)]))]
    (fn-for-lonn (node-nexts (generate-node map start))
                 (list start)
                 (sub1 count)
                 (list start))))


;;
;; generate-node is a primitive described-above.
;;
;; You should not look at and definitely must not edit this code.
;;


(@htdf generate-node)
(@signature Map Natural -> Node)
;; Give map and node number (name), generate corresponding node
(define (generate-node map number)
  (local [(define entry (assoc number map))]
    (if (false? entry)
        (error "Node with given number does not exist." number)
        (apply make-node entry))))


(define MAP '((1 (2 6)) 
              (2 (3 5))
              (3 (4))
              (4 ())
              (5 ())
              (6 (8))
              (8 (9))
              (9 ())

              (11 (12 15 16))
              (12 (13 14))
              (13 ())
              (14 (12))
              (15 ())
              (16 (17 18))
              (17 ())
              (18 ())

              (101 (102 108 107))
              
              (102 (103))
              (108 (103))
              (107 ())
              
              (103 (104 105))
              
              (104 ())
              (105 (106))
              (106 (108))               
              ))
