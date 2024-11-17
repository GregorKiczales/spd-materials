;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname foo) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #t)))

(require spd/tags)

;; 5 lecture plan
;;
;; 18. sequence? bst?
;;     accumulators, template, invariants, example progression
;;
;; 19. list-sum/tr            tree-sum/tr
;;     list-sum-if-new-max/tr tree-sum-if-new-max/tr
;;
;; 20. find-
;;     add additional context-preserving accumulator
;;
;; 21. find-path   (in house with keys)
;;     graphs, cycles, lookup-node step, path accumulator
;;
;; 22. find-path-no-revisits (in house with keys) (optional material)
;;     path-dependent accumulation with tr --> use compound wle



(define-struct node (val subs))

(define T0
  (make-node 0
             (list (make-node 1
                              (list (make-node 2 (list))
                                    (make-node 3 (list))))
                   (make-node 4
                              (list (make-node 5 (list))
                                    (make-node 6 (list)))))))

(check-expect (list-sum/tr (list 1 4 3 7 5 9)) (+ 1 4 3 7 5 9))

(define (list-sum/tr lon0)
  (local [(define (fn-for-lon lon rsf)
            (cond [(empty? lon) rsf]
                  [else
                   (fn-for-lon (rest lon)                ;where to go (future)
                               (+ rsf (first lon)))]))]  ;sum so far  (past)
    (fn-for-lon lon0 0)))

(check-expect (tree-sum/tr T0) (+ 1 2 3 4 5 6))

(define (tree-sum/tr t0)
  (local [(define (fn-for-t t worklist rsf)
            (fn-for-lot (append worklist (node-subs t)) ;where to go (future)
                        (+ rsf (node-val t))))        ;sum so far  (past)

          (define (fn-for-lot worklist rsf)
            (cond [(empty? worklist) rsf]               ;done, produce result
                  [else
                   (fn-for-t (first worklist)           ;take first thing
                             (rest worklist)            ;item off the worklist
                             rsf)]))]                   ;unchanged rsf

    (fn-for-t t0 empty 0)))


(check-expect (list-sum-if-new-max/tr (list 1 4 3 7 5 9)) (+ 1 4 7 9))

(define (list-sum-if-new-max/tr lon0)
  (local [(define (fn-for-lon lon msf rsf)
            (cond [(empty? lon) rsf]
                  [else
                   (if (> (first lon) msf)
                       (fn-for-lon (rest lon)              
                                   (first lon)
                                   (+ rsf (first lon)))
                       (fn-for-lon (rest lon)
                                   msf
                                   rsf))]))]
    (if (empty? lon0)
        0
        (fn-for-lon (rest lon0) (first lon0) (first lon0)))))


(check-expect (tree-sum-if-new-max/tr T0) (+ 1 2 3 4 5 6))

(define (tree-sum-if-new-max/tr t0)
  (local [(define (fn-for-t t worklist msf rsf)
            (if (> (node-val t) msf)
                (fn-for-lot (append worklist (node-subs t))
                            (node-val t)
                            (+ rsf (node-val t)))
                (fn-for-lot (append worklist (node-subs t))
                            msf
                            rsf)))

          (define (fn-for-lot worklist msf rsf)
            (cond [(empty? worklist) rsf]     
                  [else
                   (fn-for-t (first worklist) 
                             (rest worklist)  
                             msf
                             rsf)]))]         

    (if (false? t0)
        0
        (fn-for-lot (node-subs t0)
                    (node-val t0)
                    (node-val t0)))))


