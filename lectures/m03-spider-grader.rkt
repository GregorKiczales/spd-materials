#lang racket
(require spd-grader/check-template)
(require spd-grader/grader)

(provide grader)

(define Spider 'Number)

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

          (grade-bb-handler (on-tick tick-handler-name)
            (grade-signature (Spider -> Spider))

            (grade-tests-validity (sp) r
              (%%spider? sp)
              (equal? r (%%tock sp)))

            (grade-tests-argument-thoroughness (sp)
                                               (= sp (- BOT  1 SPEED))
                                               (= sp (- BOT  0 SPEED))
                                               (= sp (- BOT -1 SPEED)))

            (grade-thoroughness-by-faulty-functions 1
              (define (,tick-handler-name s)
                (if (= (+ s SPEED) BOT)
                    BOT
                    (+ s SPEED)))
              (define (,tick-handler-name s)
                (if (>= s BOT)
                    BOT
                    (+ s SPEED))))
            
            (grade-template-origin (Spider))
            (grade-template        ,Spider)
            
            (grade-submitted-tests)
            (grade-additional-tests 1
              (check-expect (,tick-handler-name TOP) (+ TOP SPEED))
              (check-expect (,tick-handler-name (- BOT  1 SPEED)) (- BOT 1))
              (check-expect (,tick-handler-name (- BOT  0 SPEED))    BOT)
              (check-expect (,tick-handler-name (- BOT -1 SPEED))    BOT)))

          (grade-bb-handler (to-draw draw-handler-name)
            (grade-signature (Spider -> Image))

            (grade-tests-validity (sp) r
              (%%spider? sp)
              (equal? r (%%render sp)))

            ;; !!! need version of arg thoroughness that gives access args of all tests
            
            (grade-thoroughness-by-faulty-functions 1
              (define (,draw-handler-name s)
                (place-image SPIDER-IMAGE s CTR-X MTS)))
            
            (grade-template-origin (Spider))
            (grade-template        ,Spider)
            
            (grade-submitted-tests)
            (grade-additional-tests 1
              (check-expect (,draw-handler-name TOP)          (%%render TOP))
              (check-expect (,draw-handler-name (/ HEIGHT 2)) (%%render (/ HEIGHT 2))))))))))



