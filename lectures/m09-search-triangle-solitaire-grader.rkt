#lang racket
(require spd-grader/grader)
(require spd-grader/walker)
(provide grader)

  
(define grader
  (lambda ()
    (grade-submission

      (define (%%board? b) 
        (and (list? b) (= 15 (length b)) (andmap boolean? b)))

      (define (%%solve bd)
        (local [(define (solve-bd bd)
                  (if (%%solved? bd)
                      (list bd)
                      (local [(define try (solve-lobd (%%next-boards bd)))]
                        (if (not (false? try))
                            (cons bd try)
                            false))))
                
                (define (solve-lobd lobd)
                  (cond [(empty? lobd) false]
                        [else
                         (local [(define try (solve-bd (first lobd)))]
                           (if (not (false? try))
                               try
                               (solve-lobd (rest lobd))))]))]
          (solve-bd bd)))

      (define (%%solved? bd)
        (= 1
           (foldr + 0                            ;sum
                  (map (lambda (x) 1)            ;convert to 1s
                       (filter identity bd)))))  ;keep trues

      (define (%%next-boards bd)
        (local [;; Jump -> Board
                ;; (@template-origin Jump)
                (define (do-jump j)
                  (local [(define from (jump-from j))
                          (define over (jump-over j))
                          (define to   (jump-to   j))]
                    
                    (set-cell (set-cell (set-cell bd
                                                  to true)
                                        over false)
                              from false)))
          
                ;; Jump -> Boolean
                ;; (@template-origin Jump)
                (define (valid? j)
                  (and (get-cell bd (jump-from j))        ;from is full
                       (get-cell bd (jump-over j))        ;over is full
                       (not (get-cell bd (jump-to j)))))] ;to is empty
    
          (map do-jump (filter valid? JUMPS))))
      
      (weights (*)

        (grade-problem 2
          (weights (*)

            (grade-htdf solve
              (weights (*)
                (grade-signature (Board -> (listof Board) or #f))

                (grade-tests-validity (b) r
                   (%%board? b)
                   (equal? r (%%solve b)))
                
                (grade-thoroughness-by-faulty-functions 1
                  (define (solve b) false)
                  (define (solve b) (list b))
                  (define (solve b)
                    (local [(define try (%%solve b))]
                      (if (not (false? try))
                          (reverse try)
                          false))))

                (grade-template-origin 1 (try-catch genrec arb-tree encapsulated))
                (grade-submitted-tests 1)
                (grade-additional-tests 1
                  (false? (solve BD4))
                  (false? (solve MTB)))))

            (grade-htdf solved?
              (weights (*)

                (grade-signature (Board -> Boolean))

                (grade-tests-validity (b) r
                  (%%board? b)
                  (equal? r (%%solved? b)))

                (grade-argument-thoroughness ()
                  (per-args (b)
                    (= (length (filter identity b)) 1)
                    (> (length (filter identity b)) 1)
                    (member? false b)))
                
                (grade-thoroughness-by-faulty-functions 1
                  (define (solved? b)
                    (= 0
                       (foldr + 0                            
                              (map (lambda (x) 1)           
                                   (filter identity b)))))
                  (define (solved? b)
                    (= 1
                       (foldr + 1                            
                              (map (lambda (x) 1)           
                                   (filter identity b)))))
                  (define (solved? b)
                    (= 1
                       (foldr + 0                            
                              (map (lambda (x) 0)           
                                   (filter identity b))))))
                
                (grade-template-origin 1 (fn-composition* use-abstract-fn))
                (grade-submitted-tests 1)
                (grade-additional-tests 1
                  (check-expect (solved? BD1)  false)
                  (check-expect (solved? BD1s) true))))
            
            (grade-htdf next-boards
              (weights (*)
                (grade-signature (Board -> (listof Board)))

                (grade-tests-validity (b) r
                  (%%board? b)
                  (equal? r (%%next-boards b)))

                (grade-thoroughness-by-faulty-functions 1
                  (define (next-boards bd) empty)
                  (define (next-boards bd) (list bd)))

                (grade-template-origin (fn-composition use-abstract-fn))

                (grade-submitted-tests 1)

                (grade-additional-tests 1
                  (andmap (lambda (x) (member x (list BD1a BD1b))) (next-boards BD1))
                  (check-expect (next-boards BD1s) (list)))))))))))
