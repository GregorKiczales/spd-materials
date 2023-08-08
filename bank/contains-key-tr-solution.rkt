;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname contains-key-tr-solution) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require spd/tags)

(@assignment bank/accumulators-p12)
(@cwl ???)

(@problem 1)
;; Starting with the following data definition for a binary tree
;; (not a binary search tree) design a tail-recursive function called contains?
;; that consumes a key and a binary tree and produces true if the tree contains
;; the key.


(@htdd BT)
(define-struct node (k v l r))
;; BT is one of:
;;  - false
;;  - (make-node Integer String BT BT)
;; Interp. A binary tree, each node has a key, value and 2 children
(define BT1 false)
(define BT2 (make-node 1 "a"
                       (make-node 6 "f"
                                  (make-node 4 "d" false false)
                                  false)
                       (make-node 7 "g" false false)))


(@htdf contains?)
(@signature Integer BT -> Boolean)
;; Produce true if the tree contains the given key
(check-expect (contains? 1 BT1) false)
(check-expect (contains? 1 BT2) true)
(check-expect (contains? 3 BT2) false)
(check-expect (contains? 7 BT2) true)

;; This is the non-tail-recursive version. The lack of tail-recursion is coming
;; from the backtracking to visit unvisited right branches of the tree. An
;; accumulator can be used to keep a list of those branches to visit.

(@template-origin BT)

#;
(define (contains? k bt)
  (cond [(false? bt) false]
        [else
         (or (= (node-k bt) k)
             (contains? k (node-l bt))
             (contains? k (node-r bt)))]))




;; Here we have added the accumulator except for the problem of what to do when
;; bt is false.

#;
(define (contains? k bt)
  ;; todo: (listof Node); the list of so far univisited right branches
  (local [(define (contains? bt todo)
            (cond [(false? bt) (... todo)]
                  [else
                   (or (= (node-k bt) k)
                       (contains? (node-l bt)
                                  (cons (node-r bt) todo)))]))]
    (contains? bt empty)))


;; Since todo is a list, and so has arbitrary size, we need to introduce a new
;; helper function. In doing so we rename the original inner function.

(@template-origin BT encapsulated accumulator)

#;
(define (contains? k bt)
  ;; todo: (listof Node); the list of so far univisited right branches
  (local [(define (contains/one? bt todo)
            (cond [(false? bt) (contains/list? todo)]
                  [else
                   (or (= (node-k bt) k)
                       (contains/one? (node-l bt)
                                      (cons (node-r bt) todo)))]))
          
          (define (contains/list? todo)
            (cond [(empty? todo) false]
                  [else
                   (contains/one? (first todo) (rest todo))]))]

    (contains/one? bt empty)))


;; In the underlying Racket language, the last operand in an or is in tail
;; position. But in BSL, ISL, and ASL, or is designed to produce an error if any
;; of its operands produce a non-boolean, so no position of the or is a tail
;; position.  For that reason, at least in the teaching languages, we have to
;; re-write one last time as follows.

(@template-origin BT encapsulated accumulator)

#;
(define (contains? k bt)
  ;; todo: (listof BT); the list of so far univisited right branches
  (local [(define (contains/one? bt todo)
            (cond [(false? bt) (contains/list? todo)]
                  [else
                   (if (= (node-k bt) k)
                       true
                       (contains/one? (node-l bt)
                                      (cons (node-r bt) todo)))]))
          
          (define (contains/list? todo)
            (cond [(empty? todo) false]
                  [else
                   (contains/one? (first todo) (rest todo))]))]
    
    (contains/one? bt empty)))


;; This alternative is also good. It puts both branches on the todo. Note the
;; change in contains/one? as well as the change in the accumulator invariant

(@template-origin BT encapsulated accumulator)

(define (contains? k bt)
  ;; todo: (listof BT); the list of so far univisited subtrees
  (local [(define (contains/one? bt todo)
            (cond [(false? bt) (contains/list? todo)]
                  [else
                   (if (= (node-k bt) k)
                       true
                       (contains/list? (cons (node-l bt)
                                            (cons (node-r bt)
                                                  todo))))]))
          
          (define (contains/list? todo)
            (cond [(empty? todo) false]
                  [else
                   (contains/one? (first todo) (rest todo))]))]
    
    (contains/one? bt empty)))
