#lang racket
(require spd-grader/grader)
(require spd-grader/use-bia-fn)

(provide grader)

(define grader
  (lambda ()
    (grade-submission
      (weights (*)
        (grade-problem 1
          (weights (*) 
            (grade-htdf next-eggs
              (begin (ensure-unchanged '((@signature (listof Egg) -> (listof Egg))))
                     (weights (*)
                      (grade-submitted-tests 1 2)
                      (grade-use-bia-fn 1
                                        [(1.0 (filter _ (map _ _)))
                                         (0.2 (foldr _ _))]
                        #:supplied-tests                
                        (check-expect (next-eggs empty) empty)
                        (check-expect (next-eggs (cons (make-egg 10 20 30) empty))
                                      (cons (make-egg 10 (+ 20 FALL-SPEED)(+ 30 SPIN-SPEED)) empty))
                        #:additional-tests  ;!!! upgrade these
                        (check-expect (next-eggs empty) empty)
                        (check-expect (next-eggs (cons (make-egg 10 20 30) empty))
                                      (cons (make-egg 10 (+ 20 FALL-SPEED)(+ 30 SPIN-SPEED)) empty))


                        ))))

            (grade-htdf render-eggs
              (begin (ensure-unchanged '((@signature (listof Egg) -> Image)))
                     (weights (*)
                       (grade-submitted-tests 1 2)
                       (grade-use-bia-fn 1
                                         [(1 (foldr _ _))]
                         #:supplied-tests
                         (check-expect (render-eggs empty) MTS)
                         (check-expect (render-eggs (cons (make-egg 10 20 30)
                                                          (cons (make-egg 20 30 40) empty)))
                                       (place-image (rotate 30 YOSHI-EGG)
                                                    10 20
                                                    (place-image (rotate 40 YOSHI-EGG)
                                                                 20 30
                                                                 MTS)))
                         #:additional-tests ;!!! upgrade these
                         (check-expect (render-eggs empty) MTS)
                         (check-expect (render-eggs (cons (make-egg 10 20 30)
                                                          (cons (make-egg 20 30 40) empty)))
                                       (place-image (rotate 30 YOSHI-EGG)
                                                    10 20
                                                    (place-image (rotate 40 YOSHI-EGG)
                                                                 20 30
                                                                 MTS)))))))))))))
