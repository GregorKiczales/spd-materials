#lang racket
(require spd-grader/check-template
         spd-grader/grader
         spd-grader/walker
         spd-grader/utils)

(provide grader)


(define grader
  (lambda ()
    (grade-submission
      (weights (.3 *)
        (grade-problem 1
          (let* ([sexps (problem-sexps (car (context)))]
                 [to    (and (>= (length sexps) 1) (car sexps))]
                 [defn  (and (>= (length sexps) 2) (cadr sexps))]
                 [locs  (cdr (defines defn))])
            (weights (.3 *)
              (rubric-item 'other
                           (and to (equal-sets? to '(@template-origin Region ListOfRegion encapsulated)))
                           "@template-origin tag - which is there to make it easy to copy")
              (rubric-item 'other
                           (and defn
                                (fn-defn? defn)
                                (= (length locs) 2)
                                (equal? (car locs)
                                        '(define (fn-for-region r)
                                           (cond [(leaf? r)
                                                  (... (leaf-label r)
                                                       (leaf-weight r)
                                                       (leaf-color r))]
                                                 [else
                                                  (... (inner-color r)
                                                       (fn-for-lor (inner-subs r)))])))
                                (equal? (cadr locs)
                                        '(define (fn-for-lor lor)
                                           (cond [(empty? lor) (...)]
                                                 [else
                                                  (... (fn-for-region (first lor))
                                                       (fn-for-lor (rest lor)))]))))
                           "local definitions")
              (rubric-item 'other
                           (and defn
                                (fn-defn? defn)
                                (eq? (caaddr defn) 'local)
                                (pair? (caddr (caddr defn)))
                                (eqv? (car (caddr (caddr defn))) 'fn-for-region)
                                (eqv? (cadr (caddr (caddr defn))) (cadr (cadr defn))))
                           "trampoline"))))
        

        ;; !!! update to state of the art
        (grade-problem 2
          (grade-htdf find-region
            (let* ([htdf  (car (context))]
                   [defns (htdf-defns htdf)]
                   [defn  (and (pair? defns) (car defns))]
                   [locs  (filter fn-defn? (cdr (defines defn)))]
                   [names (map caadr locs)])
              (weights (*)
                (grade-signature (String Region -> Region or false))

                (rubric-item 'other (= (length defns) 1) "only one top-level function")
                (rubric-item 'other (= (length locs) 2)  "with 2 locally defined functions")
                (rubric-item 'other
                             (and (member (car  names) (free (caddr (cadr locs))))
                                  (member (cadr names) (free (caddr (car  locs)))))
                             "that are in mutual recursion")
                
                (grade-template-origin 1 (encapsulated Region ListOfRegion try-catch))

                (grade-additional-tests 1
                  (check-expect (find-region "one" L1) L1)
                  (check-expect (find-region "one" L2) false)
                  (check-expect (find-region "three" I4) L3))))))))))

            


  
(define PROBLEM-1-SOLUTION
  '((@template-origin Region ListOfRegion encapsulated)

    (define (fn-for-region r)
      (local [(define (fn-for-region r)
                (cond [(leaf? r)
                       (... (leaf-label r)
                            (leaf-weight r)
                            (leaf-color r))]
                      [else
                       (... (inner-color r)
                            (fn-for-lor (inner-subs r)))]))
              
              (define (fn-for-lor lor)
                (cond [(empty? lor) (...)]
                      [else
                       (... (fn-for-region (first lor))
                            (fn-for-lor (rest lor)))]))]
        
        (fn-for-region r)))))
