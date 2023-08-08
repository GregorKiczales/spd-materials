#lang racket
(require spd-grader/check-template)
(require spd-grader/grader)

(provide grader)

(define draw-handler  (make-parameter #f))
(define tick-handler  (make-parameter #f))
;(define mouse-handler (make-parameter #f))
;(define key-handler   (make-parameter #f))

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
            (with-handlers ([void (λ (exn) (score #f 'signature 1 1 '() (list (message #f "found main function"))))])
              (let* ([htdf (car (context))]
                     [defn (car (htdf-defns htdf))]
                     [options (cddr (caddr defn))])
                (weights (*)
                  (draw-handler  (ass '(on-draw to-draw) options))
                  (tick-handler  (ass '(on-tick) options))
                  ;(mouse-handler (ass '(on-mouse) options))
                  ;(key-handler   (ass '(on-key) options))
                  (grade-signature (Spider -> Spider))))))

          (if (false? (tick-handler))
              (rubric-item 'signature 1 #f "on-tick option to big-bang exists")
              (grade-htdf* (tick-handler)
                (lambda ()
                  (weights (*)
                    (grade-signature (Spider -> Spider))

                    (grade-tests-validity (sp) r
                      (%%spider? sp)
                      (equal? r (%%tock sp)))

                    (grade-tests-argument-thoroughness (sp)
                      (= sp (- BOT  1 SPEED))
                      (= sp (- BOT  0 SPEED))
                      (= sp (- BOT -1 SPEED)))

                    (grade-thoroughness-by-faulty-functions 1
                      (define (,(tick-handler) s)
                        (if (= (+ s SPEED) BOT)
                            BOT
                            (+ s SPEED)))
                      (define (,(tick-handler) s)
                        (if (>= s BOT)
                            BOT
                            (+ s SPEED))))
                    
                    (grade-template-origin (Spider))
                    (grade-submitted-tests)
                    (grade-additional-tests 1
                      (check-expect (,(tick-handler) TOP) (+ TOP SPEED))
                      (check-expect (,(tick-handler) (- BOT  1 SPEED)) (- BOT 1))
                      (check-expect (,(tick-handler) (- BOT  0 SPEED))    BOT)
                      (check-expect (,(tick-handler) (- BOT -1 SPEED))    BOT))))))

          (if (false? (draw-handler))
              (rubric-item 'signature 1 #f "on-draw or to-draw option to big-bang exists")
              (grade-htdf* (draw-handler)
                (lambda ()
                  (weights (*)
                    (grade-signature (Spider -> Image))

                    (grade-tests-validity (sp) r
                      (%%spider? sp)
                      (equal? r (%%render sp)))

                    ;; !!! need version of arg thoroughness that gives access args of all tests
                    
                    (grade-thoroughness-by-faulty-functions 1
                      (define (,(draw-handler) s)
                        (place-image SPIDER-IMAGE s CTR-X MTS)))
                    
                    (grade-template-origin (Spider))
                    (grade-template (s) Number)
                    (grade-submitted-tests)
                    (grade-additional-tests 1
                      (check-expect (,(draw-handler) TOP)          (%%render TOP))
                      (check-expect (,(draw-handler) (/ HEIGHT 2)) (%%render (/ HEIGHT 2)))))))))))))


(define (ass lok alist)
  (ormap (lambda (k)
           (and (assq k alist)
                (cadr (assq k alist))))
         lok))
