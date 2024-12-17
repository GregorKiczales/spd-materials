;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname m11-out-of-order-solution) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
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
|#


;; =================
;; Functions:


(@problem 1)

(@htdf first-out-of-order)
(@signature Map Natural -> Natural or false)
;; in TR traversal of graph from n, produce first out of sequence node number

(check-expect (first-out-of-order MAP   1) 8)
(check-expect (first-out-of-order MAP  11) false)
(check-expect (first-out-of-order MAP 101) 108)

(@template-origin genrec arb-tree accumulator)
 

(define (first-out-of-order map num0)
  ;; nn-wl is (listof Natural);   worklist of node numbers
  ;; visited is (listof Natural)
  ;; Numbers of nodes already visited in the tr. (first visited) is always
  ;; the previous node's number which implies visited is never empty
  (local [(define (fn-for-node n nn-wl visited)
            (local [(define num (node-number n))
                    (define nexts (node-nexts n))
                    (define nvisited (cons num visited))]
              (cond [(member num visited) (fn-for-lonn nn-wl visited)]
                    [(not (= num (add1 (first visited)))) num]
                    [else
                     (fn-for-lonn (append nexts nn-wl) nvisited)])))
          
          (define (fn-for-lonn nn-wl visited)
            (cond [(empty? nn-wl) false] 
                  [else
                   (fn-for-node (generate-node map (first nn-wl))
                                (rest nn-wl)
                                visited)]))]
    ;; must start at fn-for-lonn to satisfy visited invariant
    (fn-for-lonn (node-nexts (generate-node map num0))
                 (list num0))))


(@problem 2)

(@htdf first-out-of-order-path)
(@signature Map Natural -> (listof Natural) or false)
;; in TR traversal of graph from n, produce path if first out of sequence node

(check-expect (first-out-of-order-path MAP   1) (list 1 6 8))
(check-expect (first-out-of-order-path MAP  11) false)
(check-expect (first-out-of-order-path MAP 101) (list 101 102 103 105 106 108))

(@template-origin genrec arb-tree accumulator)

(define (first-out-of-order-path map num0)
  
  ;; nn-wl   is (listof Natural);          worklist of node numbers
  ;; path-wl is (listof (listof Natural)); tandem worklist of paths
  ;; visited is (listof Natural)
  ;; Numbers of nodes already visited in the tr. (first visited) is always
  ;; the previous node's number which implies visited is never empty
  
  (local [(define (fn-for-node n path nn-wl path-wl  visited)
            (local [(define num      (node-number n))
                    (define nexts    (node-nexts n))
                    (define npath    (cons num path))
                    (define nvisited (cons num visited))]
              (cond [(member num visited) (fn-for-lonn nn-wl path-wl visited)]
                    [(not (= num (add1 (first visited)))) (reverse npath)]
                    [else
                     (fn-for-lonn (append nexts
                                          nn-wl)
                                  (append (make-list (length nexts) npath)
                                          path-wl)
                                  nvisited)])))
          
          (define (fn-for-lonn nn-wl path-wl visited)
            (cond [(empty? nn-wl) false] 
                  [else
                   (fn-for-node (generate-node map (first nn-wl))
                                (first path-wl)
                                (rest nn-wl)
                                (rest path-wl)
                                visited)]))]
    
    ;; must start at fn-for-lonn to satisfy visited invariant
    (fn-for-lonn (node-nexts (generate-node map num0))
                 (make-list (length (node-nexts (generate-node map num0)))
                            (list num0))
                 (list num0))))



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
