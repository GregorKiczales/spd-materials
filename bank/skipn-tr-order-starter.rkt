;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname f-p6-starter) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #t #t none #f () #f)))
(require spd/tags)

(@assignment bank/skipn-tr-order)

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
#|

 Complete the design of a function that consumes a Map and two Natural numbers,
 called start and n. The function should do a tail-recursive traversal of the
 starting from node number start. It should produce a list of the node numbers
 traversed, skipping every n-th number.

 One approach would be to do the traversal to generate all the numbers, and then
 write a separate function to skip every n numbers in that list - THAT APPROACH
 WILL RECEIVED ZERO MARKS.  Instead you must arrange for your tail recursive
 traveral itself to skip every n-th node number.
 
 We have provided a complete set of check-expects below.

 TO BE CLEAR, the arguments are map, start and n IN THAT ORDER.

 NOTE: This problem will be autograded, and ALL OF THE FOLLOWING ARE ESSENTIAL
       IN YOUR SOLUTION.  Failure to follow these requirements may result in
       receiving zero marks for this problem.

 - The function you design MUST BE CALLED skipn-tr-order. 
 - You MUST FOLLOW all applicable design rules.

 - You MUST NOT EDIT above the marked line. WE REALLY MEAN THIS!
 - You MUST NOT EDIT below the other marked line. WE REALLY MEAN THIS!

 - You MUST complete the function definition and then comment out the existing
   stub. Do not delete it.
 
 - You MUST USE one of the two sets of encapsulated templates above.
 - You MUST NOT RENAME any of the local functions within those templates. 
 - You MUST NOT RENAME any of the parameters of those local functions. 
 - You MAY ADD ADDITIONAL PARAMETERS to those functions.
 - You MUST USE ALL of the local functions within those templates.

 - You MUST NOT COMMENT out any @ metadata tags.
 
 - The file MUST NOT have any errors when the Check Syntax button is pressed.
   Press Check Syntax and Run often, and correct any errors early.

|#


(@htdf skipn-tr-order)
(@signature Map Natural Natural -> (listof Natural))
;; in TR traversal of graph from start, produce first node num, skip n, repeat

(check-expect (skipn-tr-order MAP   1 2) (list 1 3 5 8))
(check-expect (skipn-tr-order MAP   1 3) (list 1 4 8))
(check-expect (skipn-tr-order MAP  11 2) (list 11 13 15 17))
(check-expect (skipn-tr-order MAP  11 3) (list 11 14 17))
(check-expect (skipn-tr-order MAP 101 2) (list 101 103 105 108))
(check-expect (skipn-tr-order MAP 101 3) (list 101 104 108))

(@template-origin genrec arb-tree accumulator)

;; *** Must not edit any line above here. ***

(define (skipn-tr-order map start n) empty)





;; *** Must not edit any line below here. ***

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
