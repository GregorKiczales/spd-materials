;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname m10-tr-trees-2) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #t)))
(require spd/tags)
(@assignment lectures/m10-tr-trees)



#|
;;
;; Which function passes this test?
;;

(check-expect (??? TOP1)
              (list (list 10 (list 10))
                    (list 20 (list 10 20))
                    (list 30 (list 10 20 30))
                    (list 40 (list 10 40))
                    (list 50 (list 10 40 50))
                    (list 60 (list 10 40 60))))

;; A) foo
;; B) bar
;; C) neither


;;
;; Which function passes this test?
;;

(check-expect (??? TOP1)
              (list (list 10 (list 10))
                    (list 20 (list 10 20))
                    (list 30 (list 10 20 30))
                    (list 40 (list 10 20 30 40))
                    (list 50 (list 10 20 30 40 50))
                    (list 60 (list 10 20 30 40 50 60))))


;; A) foo
;; B) bar
;; C) neither

|#



(@htdd Tree) 

(define-struct node (number subs))
;; Tree is (make-node Integer (listof Tree))
;; interp. a bare bones arbitrary arity tree, each node has a number and subs
;;
;; NOTE: The template has a little extra in it to help with the functions
;;       we will be writing.

(define (fn-for-tree t)  
  (local [(define (fn-for-t t)
            (local [(define number (node-number t))  ;unpack the fields
                    (define subs   (node-subs t))]   ;for convenience
              
              (... number (fn-for-lot subs))))
          
          (define (fn-for-lot lot)
            (cond [(empty? lot) (...)]
                  [else
                   (... (fn-for-t (first lot))
                        (fn-for-lot (rest lot)))]))]
    
    (fn-for-t t)))

(define L1 (make-node 30 empty))
(define L2 (make-node 50 empty))
(define L3 (make-node 60 empty))

(define M1 (make-node 20 (list L1)))
(define M2 (make-node 40 (list L2 L3)))

(define TOP1 (make-node 10 (list M1 M2)))  ;top->bot and t/l -> b/r sorted

(define TOP2 (make-node 100 (list M1 M2))) ;not top->bot

(define TOP3
  (make-node 10
             (list (make-node 100 empty)   ;not l->r
                   M1
                   M2)))


(@problem 1)

(@htdf foo)

(@signature Tree -> (listof (list Integer (listof Integer))))
;; produce pairs showing what path is at each subtree
(check-expect (foo L1)
              (list (list 30 (list 30))))
(check-expect (foo M1)
              (list (list 20 (list 20))
                    (list 30 (list 20 30))))

(check-expect (foo TOP1)
              (list (list 10 (list 10))
                    (list 20 (list 10 20))
                    (list 30 (list 10 20 30))
                    (list 40 (list 10 40))
                    (list 50 (list 10 40 50))
                    (list 60 (list 10 40 60))))

(@template-origin Tree (listof Tree) accumulator) 

(define (foo t0)
  ;; path is ???
  (local [(define (fn-for-t t path)
            (local [(define number (node-number t))  ;unpack the fields
                    (define subs (node-subs t))]     ;for convenience
              (cons (list number (reverse (cons number path)))
                    (fn-for-lot subs (cons number path)))))
          
          (define (fn-for-lot lot path)
            (cond [(empty? lot) empty]
                  [else
                   (append (fn-for-t (first lot) path)
                           (fn-for-lot (rest lot) path))]))]
    
    (fn-for-t t0 empty)))


(@problem 2)

(@htdf bar)

(@signature Tree -> Boolean)
;; produce pairs showing what visited is at each subtree
(check-expect (bar L1)
              (list (list 30 (list 30))))
(check-expect (bar M1)
              (list
               (list 20 (list 20))
               (list 30 (list 20 30))))

(check-expect (bar TOP1)
              (list (list 10 (list 10))
                    (list 20 (list 10 20))
                    (list 30 (list 10 20 30))
                    (list 40 (list 10 20 30 40))
                    (list 50 (list 10 20 30 40 50))
                    (list 60 (list 10 20 30 40 50 60))))

(@template-origin Tree (listof Tree) accumulator)

(define (bar t0)
  ;; t-wl is (listof Tree); worklist of Trees to visit
  ;;                        unvisited direct subs of visited trees
  ;; visited is ???
  (local [(define (fn-for-t t t-wl visited)
            (local [(define number (node-number t))  ;unpack the fields
                    (define subs (node-subs t))]     ;for convenience
              (cons (list number (reverse (cons number visited)))
                    (fn-for-lot (append subs t-wl)
                                (cons number visited)))))
          
          (define (fn-for-lot t-wl visited)
            (cond [(empty? t-wl) empty]
                  [else
                   (fn-for-t (first t-wl) (rest t-wl) visited)]))]
    
    (fn-for-t t0 empty empty)))



