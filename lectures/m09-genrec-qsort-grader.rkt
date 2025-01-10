#lang racket
(require spd-grader/grader)
(require spd-grader/walker)
(provide grader)

(define grader
  (lambda ()
    (grade-submission
      (weights (*)
        (grade-problem 1
          (weights (*)
            (grade-htdf qsort
              (weights (*)
                (grade-signature ((listof Number) -> (listof Number)))

                (grade-tests-validity (lon) r
                  (andmap number? lon)
                  (andmap number? r)
                  (equal? r (sort lon <)))
                
                (grade-argument-thoroughness ()
                  (per-args (lon)
                    (empty? lon)
                    (and (> (length lon) 1) (not (equal? (sort lon <) lon)))))
                
                (grade-thoroughness-by-faulty-functions 1
                  (define (qsort lon)
                    (cond [(empty? lon) empty]
                          [else
                           (local [(define p (first lon))
                                   (define (<p x) (> x p))
                                   (define (>p x) (< x p))]
           
                             (append (qsort (filter <p lon))
                                     (list p)
                                     (qsort (filter >p lon))))]))
                  (define (qsort lon)
                    (cond [(empty? lon) empty]
                          [else
                           (local [(define p (first lon))
                                   (define (<p x) (< x p))]
           
                             (append (qsort (filter <p lon))
                                     (list p)
                                     (qsort (filter <p lon))))]))
                  (define (qsort lon)
                    (cond [(empty? lon) empty]
                          [else
                           (local [(define p (first lon))
                                   (define (>p x) (> x p))]
           
                             (append (qsort (filter >p lon))
                                     (list p)
                                     (qsort (filter >p lon))))]))
                  (define (qsort lon)
                    (cond [(empty? lon) empty]
                          [else
                           (local [(define p (first lon))
                                   (define (<p x) (< x p))
                                   (define (>p x) (> x p))]
           
                             (append (list p)
                                     (qsort (filter <p lon))
                                     (qsort (filter >p lon))))]))
                  (define (qsort lon)
                    (cond [(empty? lon) empty]
                          [else
                           (local [(define p (first lon))
                                   (define (<p x) (< x p))
                                   (define (>p x) (> x p))]
           
                             (append (qsort (filter <p lon))
                                     (qsort (filter >p lon))
                                     (list p)))])))

                (grade-template-origin (genrec use-abstract-fn encapsulated*))
                (grade-submitted-tests)
                (grade-additional-tests 1
                  (check-expect (qsort (list)) (list))
                  (check-expect (qsort (list 2)) (list 2))
                  (check-expect (qsort (list 5 4 6)) (list 4 5 6))
                  (check-expect (qsort (list 3 1 5 2 4 6)) (list 1 2 3 4 5 6))
                  (check-expect (qsort (list 8 3 11 1 12 5 2 10 4 6))
                                (list 1 2 3 4 5 6 8 10 11 12)))))))))))
                 
                                                  
                                                   
