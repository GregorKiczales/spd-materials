;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname m11-out-of-order-solution) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #t #t none #f () #f)))
(require spd/tags)

(@assignment lectures/m11-out-of-order)

(@cwl ???)



;; =================
;; Data Definitions: 

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

 generate-node is defined at the bottom of the fole. You should treat it as a
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
;; Here are normal recursion and tail recursion templates.
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
                   (... (fn-for-node (first lonn))
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
          
          (define (fn-for-lonn nn-wl)
            (cond [(empty? nn-wl) (...)] 
                  [else
                   (fn-for-node (generate-node map (first nn-wl))
                                (rest nn-wl))]))]

    (fn-for-? ...num0)))


;; =================
;; Functions:


(@problem 1)

#|
 Complete the design of the following function. Use either the normal-
 or tail-recursion template from above.
|#

(@htdf first-out-of-order)
(@signature Map Natural -> Natural or false)
;; in TR traversal of graph from n, produce first out of sequence node number

(check-expect (first-out-of-order MAP   1) 8)
(check-expect (first-out-of-order MAP  11) false)
(check-expect (first-out-of-order MAP 101) 108)

(@template-origin genrec arb-tree accumulator)
 
(define (first-out-of-order map num0) false)


(@problem 2)

#|
 Complete the design of the following function. Use either the normal-
 or tail-recursion template from above.
|#

(@htdf first-out-of-order-path)
(@signature Map Natural -> (listof Natural) or false)
;; in TR traversal of graph from n, produce path if first out of sequence node

(check-expect (first-out-of-order-path MAP   1) (list 1 6 8))
(check-expect (first-out-of-order-path MAP  11) false)
(check-expect (first-out-of-order-path MAP 101) (list 101 102 103 105 106 108))

(@template-origin genrec arb-tree accumulator)

(define (first-out-of-order-path map num0) false)




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
