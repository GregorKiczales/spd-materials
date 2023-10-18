#lang racket
(require spd-grader/check-template
         spd-grader/grader
         spd-grader/walker
         spd-grader/utils)

(provide grader)


(define grader
  (lambda ()
    (grade-submission
      (weights (*)
        (grade-problem 1
          (let* ([sexps  (problem-sexps (car (context)))])
            (weights (.3 *)
              (rubric-item 'other
                           (and (>= (length sexps) 1)
                                (equal-sets? (car sexps) (car PROBLEM-1-SOLUTION)))
                           "@template-origin tag - which is there to make it easy to copy")
              (rubric-item 'other
                           (and (>= (length sexps) 2)
                                (equal? (cadr sexps) (cadr PROBLEM-1-SOLUTION)))
                           "encapsulated fn-for-region"))))
        

        (grade-problem 2
          (grade-htdf find-region
            (let* ([htdf  (car (context))]
                   [defns (htdf-defns htdf)]
                   [locs  (filter fn-defn? (cdr (defines defns)))]
                   [names (map caadr locs)])
              (weights (*)
                (grade-signature (String Region -> Region or false))

                (rubric-item 'other (= (length defns) 1) "Only one top-level function")
                (rubric-item 'other (= (length locs) 2)  "With 2 locally defined functions")
                (rubric-item 'other
                             (and (member (car  names) (free (caddr (cadr locs))))
                                  (member (cadr names) (free (caddr (car  locs)))))
                             "That are in mutual recursion")
                
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
