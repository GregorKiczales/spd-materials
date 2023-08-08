;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname m10-find-path-tr-solution) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #t)))
(require spd/tags)
(@assignment lectures/m10-find-path-tr)
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
;; Design a function that given a tree and a name tries to find a path to a
;; node with that name.
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

#;#;
(@template-origin try-catch Tree (listof Tree) accumulator)

;; Structural recursion with path accumulator. Works properly.
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
;; PROBLEM
;;
;; Define a new version of the function which is tail recursive.  You only
;; need a new function definition. Proceed by
;;   - copying your solution to the problem above
;;   - and renaming the path accumulator to visited
;;   - then convert the code to be tail recursive
;;



#;#;
(@template-origin Tree (listof Tree)
           accumulator)         ;tree-wl visited

;; Tail recursion with visited accumulator. FAILS SOME TESTS!!!
(define (find-path t n)  
  ;; tree-wl is (listof Tree);
  ;; worklist of trees to visit (unvisited subs of already visited trees)
  ;;           
  ;; visited is (listof String)
  ;; names of trees visited so far (builds along tail recursive calls)
  (local [(define (fn-for-t t tree-wl visited)
            (local [(define name (node-name t))      
                    (define subs (node-subs t))
                    (define nvisited (append visited (list name)))]
              (if (string=? name to)
                  nvisited      
                  (fn-for-lot (append subs tree-wl)
                              nvisited))))
          
          (define (fn-for-lot tree-wl visited)
            (cond [(empty? tree-wl) false]    
                  [else         
                   (fn-for-t (first tree-wl)
                             (rest tree-wl)     
                             visited)]))]
    
    (fn-for-t t empty empty)))      


;;
;; Use the pictures to describe what is happening in the TR version,
;; and what should be happening using the SR version.  Then develop
;; a new version of the function using tandem worklists that is
;; both tail recursive and produces the correct result.  Keep the
;; incorrect visited accumulator working (for comparison).
;;

(@template-origin Tree (listof Tree) accumulator)        ;tree-wl path-wl visited

;; Tail recursion with tandem worklists - tree worklist and path worklist. 
(define (find-path t n)
  ;; tree-wl is (listof Tree)       
  ;; worklist of trees to visit (unvisited subs of already visited trees)
  ;;
  ;; path-wl is (listof (listof String))      
  ;; worklist of paths to corresponding trees in tree-wl      
  ;;
  ;; visited is (listof String)
  ;; names of trees visited so far (builds along tail recursive calls)
  (local [(define (fn-for-t t path tree-wl path-wl visited)
            (local [(define name (node-name t))
                    (define subs (node-subs t))           
                    (define npath (append path (list name)))
                    (define nvisited (append visited (list name)))]
              (if (string=? name n)         
                  npath     
                  (fn-for-lot (append                    subs         tree-wl)
                              (append (make-list (length subs) npath) path-wl)
                              nvisited))))        
          
          (define (fn-for-lot tree-wl path-wl visited)
            (cond [(empty? tree-wl) false]
                  [else           
                   (fn-for-t (first tree-wl)
                             (first path-wl)
                             (rest tree-wl)      
                             (rest path-wl)
                             visited)]))]
    
    (fn-for-t t empty  empty empty empty)))



