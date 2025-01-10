#lang racket
(require spd-grader/check-template)
(require spd-grader/grader)
(require racket/function)

(provide grader)

(define grader
  (lambda ()
    (grade-submission

      (define (%%contains-canucks? los)
        (cond [(empty? los) false]
              [else
               (if (string=? (first los) "Canucks")
                   true
                   (contains-canucks? (rest los)))]))
    
      (grade-problem 1
        (weights (0 *)
          (grade-htdd ListOfString  ; weight is 0 because it is in starter, but we grade it so that
            ;;                      ; students can see grading report for correct self-referential
            ;;                      ; type definition
            (grade-dd-rules-and-template ListOfString))

          (grade-htdf contains-canucks?
            (weights (*)

              (grade-signature (ListOfString -> Boolean))

              (grade-tests-validity (los) r
                (list? los)
                (andmap string? los)
                (equal? r (%%contains-canucks? los)))
              
              (grade-argument-thoroughness ()
                (per-args (los)
                  (empty? los)
                  (and (> (length los) 0) (string=? "Canucks" (first los)))
                  (and (> (length los) 1) (member "Canucks" los) (not (string=? "Canucks" (first los))))
                  (and (> (length los) 1) (not (member "Canucks" los)))))

              (grade-thoroughness-by-faulty-functions 1
                (define (contains-canucks? los)
                  (local [(define (contains-canucks? los)
                            (cond [(empty? los) true]
                                  [else
                                   (if (string=? (first los) "Canucks")
                                       true
                                       (contains-canucks? (rest los)))]))]
                    (contains-canucks? los)))
                (define (contains-canucks? los)
                  (local[(define (contains-canuks? los)
                           (cond [(empty? los) false]
                                 [else
                                  (string=? (first los) "Canucks")]))]
                    (contains-canuks? los))))
              
              (grade-template-origin (ListOfString))
              (grade-template         ListOfString)
              (grade-template-intact  ListOfString)

              (grade-submitted-tests)
              (grade-additional-tests 1
                (check-expect (contains-canucks? empty) false)
                (check-expect (contains-canucks? (cons "Canucks" (cons "Flames" empty))) true)
                (check-expect (contains-canucks? (cons "Flames" (cons "Canucks" empty))) true)
                (check-expect (contains-canucks? (cons "Flames" (cons "Leafs" empty)))   false)))))))))


