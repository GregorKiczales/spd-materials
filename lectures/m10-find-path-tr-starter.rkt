;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname m10-find-path-tr-starter) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #t)))
(require spd/tags)
(@assignment lectures/m10-find-path-tr)
(@cwl ???) ;replace ??? with your cwl

(@problem 1)

(@htdd Tree) 

(define-struct node (name subs))
;; Tree is (make-node String (listof Tree))
;; interp. a bare bones arbitrary arity tree, each node has a name and subs
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

(define L1 (make-node "L1" empty))
(define L2 (make-node "L2" empty))
(define L3 (make-node "L3" empty))

(define M1 (make-node "M1" (list L1)))
(define M2 (make-node "M2" (list L2 L3)))

(define TOP (make-node "TOP" (list M1 M2)))


#|
;;
;; REVIEW
;;
;; find-tree, structural recursion
;; no accumulators, plug try-catch into DD templates and a few edits
;;
(@template-origin encapsulated Tree (listof Tree) try-catch)

(define (find-tree t n)
  (local [(define (fn-for-t t)
            (local [(define name (node-name t))  ;unpack the fields
                    (define subs (node-subs t))] ;for convenience
              (if (string=? name n)
                  t
                  (fn-for-lot subs))))
          
          (define (fn-for-lot lot)
            (cond [(empty? lot) false]
                  [else
                   (local [(define try (fn-for-t (first lot)))]
                     (if (not (false? try))
                         try
                         (fn-for-lot (rest lot))))]))]
    
    (fn-for-t t)))

;;
;; find-tree, tail recursion
;; worklist accumulator (t-wl) is unvisited direct subs of all the visited trees
;; is still backtracking search because of how it visits the data, but
;; no more try-catch because in TR version no internal intermediate results are
;; produced so no internal failure handling is required
;;
(@template-origin encapsulated Tree (listof Tree) accumulator)

(define (find-tree t n)
  ;; t-wl is (listof Tree); worklist of pending trees to visit
  ;;                        the unvisited direct subs of all the visited trees
  ;;                   
  (local [(define (fn-for-t t t-wl)
            (local [(define name (node-name t))  ;unpack the fields
                    (define subs (node-subs t))] ;for convenience
              (if (string=? name n)
                  t
                  (fn-for-lot (append subs t-wl)))))
          
          (define (fn-for-lot t-wl)
            (cond [(empty? t-wl) false]
                  [else
                   (fn-for-t (first t-wl)
                             (rest t-wl))]))]
    
    (fn-for-t t empty)))


;;
;; find-path, structural recursion
;; path accumulator is names of nodes above current point in tree
;; builds naturally along recursive calls
(@signature Tree String -> (listof String) or false)

(@template-origin encapsulated Tree (listof Tree) try-catch accumulator)

(define (find-path t n)
  ;; path is (listof String); names of parent, grandparent... trees to here
  ;;                          (builds along recursive  calls)
  (local [(define (fn-for-t t path)
            (local [(define name (node-name t))
                    (define subs (node-subs t))
                    (define npath (append path (list name)))]
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
    
    (fn-for-t t empty)))

|#

;;
;; PROBLEM
;;
;; Below is a copy of the structural recursion version of find-path.
;; Please update the function definition to be tail recursive.  You only
;; need to update the function definition, the rest of the design.
;; stays the same. Proceed by
;;   - renaming the path accumulator to ???
;;   - test to make sure your code is still running
;;   - then convert the code to be tail recursive
;;
;;

(@htdf find-path)

(@signature Tree String -> (listof String) or false)
;; produce path to given node name if found
(check-expect (find-path L1 "L1") (list "L1"))
(check-expect (find-path L1 "foo") false)
(check-expect (find-path TOP "M1") (list "TOP" "M1"))
(check-expect (find-path TOP "L1") (list "TOP" "M1" "L1"))
(check-expect (find-path TOP "M2") (list "TOP" "M2"))
(check-expect (find-path TOP "L2") (list "TOP" "M2" "L2"))
(check-expect (find-path TOP "L3") (list "TOP" "M2" "L3"))

(@template-origin Tree (listof Tree) try-catch accumulator)

(define (find-path t n)
  ;; path is (listof String); names of parent, grandparent... trees to here
  ;;                          (builds along recursive  calls)
  (local [(define (fn-for-t t path)
            (local [(define name (node-name t))
                    (define subs (node-subs t))
                    (define npath (append path (list name)))]
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
    
    (fn-for-t t empty)))







;;
;; Use the pictures to describe what is happening in the TR version,
;; and what should be happening using the SR version.  Then develop
;; a new version of the function using tandem worklists that is
;; both tail recursive and produces the correct result.  Keep the
;; incorrect visited accumulator working (for comparison).
;;







(@template-origin Tree (listof Tree)
                  accumulator)        ;t-wl p-wl visited

#;

;; Tail recursion with tandem worklists - tree worklist and path worklist. 
(define (find-path t n)
  ;; t-wl is (listof Tree)
  ;; worklist of trees to visit (unvisited subs of already visited trees)
  ;;
  ;; p-wl is (listof (listof String))
  ;; worklist of paths to corresponding trees in t-wl
  ;;
  ;; visited is (listof String)
  ;; names of trees visited so far (builds along tail recursive calls)
  (local [(define (fn-for-t t path t-wl p-wl visited)
            (local [(define name (node-name t))
                    (define subs (node-subs t))
                    (define npath (append path (list name)))
                    (define nvisited (append visited (list name)))]
              (if (string=? name n)
                  npath
                  (fn-for-lot (append                    subs         t-wl)
                              (append (make-list (length subs) npath) p-wl)
                              nvisited))))
          
          (define (fn-for-lot t-wl p-wl visited)
            (cond [(empty? t-wl) false]
                  [else
                   (fn-for-t (first t-wl)
                             (first p-wl)
                             (rest t-wl)
                             (rest p-wl)
                             visited)]))]
    
    (fn-for-t t empty  empty empty empty)))
