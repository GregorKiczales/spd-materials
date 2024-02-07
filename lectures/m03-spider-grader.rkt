#lang racket
(require spd-grader/check-template)
(require spd-grader/grader)

(provide grader)

(define grader
  (lambda ()
    (grade-submission
      
      (define (%%spider? x)
        (and (number? x)
             (<= TOP x BOT)))
      
      (define (%%tock s)
        (if (>= (+ s SPEED) BOT)
            BOT
            (+ s SPEED)))
      
      (define (%%render s)
        (place-image SPIDER-IMAGE CTR-X s MTS))
      
      (grade-problem 1
        (weights (*)

          (grade-htdd Spider
            (grade-dd-rules-and-template 1 Number))

          (grade-htdf main
            (rubric-item 'template-intact #t "main function design exists"))

          (grade-bb-handler (on-tick tick-handler)
            (grade-signature (Spider -> Spider))

            (grade-tests-validity (sp) r
              (%%spider? sp)
              (equal? r (%%tock sp)))

            (grade-tests-argument-thoroughness (sp)
                                               (= sp (- BOT  1 SPEED))
                                               (= sp (- BOT  0 SPEED))
                                               (= sp (- BOT -1 SPEED)))

            (grade-thoroughness-by-faulty-functions 1
                                                    (define (,tick-handler s)
                                                      (if (= (+ s SPEED) BOT)
                                                          BOT
                                                          (+ s SPEED)))
                                                    (define (,tick-handler s)
                                                      (if (>= s BOT)
                                                          BOT
                                                          (+ s SPEED))))
            
            (grade-template-origin (Spider))
            (grade-submitted-tests)
            (grade-additional-tests 1
              (check-expect (,tick-handler TOP) (+ TOP SPEED))
              (check-expect (,tick-handler (- BOT  1 SPEED)) (- BOT 1))
              (check-expect (,tick-handler (- BOT  0 SPEED))    BOT)
              (check-expect (,tick-handler (- BOT -1 SPEED))    BOT)))

          (grade-bb-handler (to-draw draw-handler)
            (grade-signature (Spider -> Image))

            (grade-tests-validity (sp) r
              (%%spider? sp)
              (equal? r (%%render sp)))

            ;; !!! need version of arg thoroughness that gives access args of all tests
            
            (grade-thoroughness-by-faulty-functions 1
                                                    (define (,draw-handler s)
                                                      (place-image SPIDER-IMAGE s CTR-X MTS)))
            
            (grade-template-origin (Spider))
            (grade-template (s) Number)
            (grade-submitted-tests)
            (grade-additional-tests 1
              (check-expect (,draw-handler TOP)          (%%render TOP))
              (check-expect (,draw-handler (/ HEIGHT 2)) (%%render (/ HEIGHT 2))))))))))



