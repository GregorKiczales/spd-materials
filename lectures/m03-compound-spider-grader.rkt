#lang racket
(require spd-grader/grader)
(require spd-grader/check-template)
;(require racket/function)
;(require syntax/stx)
(provide grader)




(define draw-handler  (make-parameter #f))
(define tick-handler  (make-parameter #f))
;(define mouse-handler (make-parameter #f))
(define key-handler   (make-parameter #f))

(define grader  
  (lambda ()
    (grade-submission

      (define %%MID (/ HEIGHT 2))

      (define (%%spider? x)
        (and (spider? x)
             (number? (spider-y x))
             (number? (spider-dy x))
             (<= TOP (spider-y x) BOT)))
      
      (define (%%tock s)
        (cond [(<= (+ (spider-y s) (spider-dy s)) TOP) (make-spider TOP (- (spider-dy s)))]
              [(>= (+ (spider-y s) (spider-dy s)) BOT) (make-spider BOT (- (spider-dy s)))]
              [else
               (make-spider (+ (spider-y s) (spider-dy s))
                            (spider-dy s))]))
      
      (define (%%reverse-spider s ke)
        (cond [(key=? ke " ") (make-spider (spider-y s) (- (spider-dy s)))]
              [else s]))
      
      (grade-problem 1
        (weights (*)
          (grade-htdd Spider
            (grade-dd-rules-and-template 1
                                         (compound (Number Number)
                                                   make-spider
                                                   spider?
                                                   (spider-y spider-dy))))
          (grade-htdf main
            (with-handlers ([void (λ (exn) (score #f 'signature 1 1 '() (list (message #f "main function exists"))))])
              (let* ([htdf (car (context))]
                     [defn (car (htdf-defns htdf))]
                     [options (cddr (caddr defn))])
                (draw-handler  (ass '(on-draw to-draw) options))
                (tick-handler  (ass '(on-tick) options))
                (key-handler   (ass '(on-key) options))
                
                (grade-signature (Spider -> Spider)))))

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
                      (= (+ (spider-y sp) (spider-dy sp)) (+ TOP 1))
                      (= (+ (spider-y sp) (spider-dy sp)) (- TOP 1))
                      (= (+ (spider-y sp) (spider-dy sp)) TOP)
                      (= (+ (spider-y sp) (spider-dy sp)) (+ 1 BOT))
                      (= (+ (spider-y sp) (spider-dy sp)) (- BOT 1))
                      (= (+ (spider-y sp) (spider-dy sp)) BOT))
                    
                    (grade-thoroughness-by-faulty-functions 1
                      (define (,(tick-handler) s)
                        (cond [(< (+ (spider-y s) (spider-dy s)) TOP)
                               (make-spider TOP
                                            (- (spider-dy s)))]
                              [(>= (+ (spider-y s) (spider-dy s)) BOT)
                               (make-spider BOT
                                            (- (spider-dy s)))]
                              [else
                               (make-spider (+ (spider-y s) (spider-dy s))
                                            (spider-dy s))]))
                      (define (,(tick-handler) s)
                        (cond [(<= (+ (spider-y s) (spider-dy s)) TOP)
                               (make-spider TOP
                                            (- (spider-dy s)))]
                              [(>= (spider-y s) BOT)
                               (make-spider BOT
                                            (- (spider-dy s)))]
                              [else
                               (make-spider (+ (spider-y s) (spider-dy s))
                                            (spider-dy s))])))
                    
                    (grade-template-origin (Spider))
                    (grade-template (s) (compound (Number Number) make-spider spider? (spider-y spider-dy)))
                    (grade-submitted-tests)
                    (grade-additional-tests 1
                      (check-expect (,(tick-handler) (make-spider   %%MID    3)) (%%tock (make-spider   %%MID    3)))
                      (check-expect (,(tick-handler) (make-spider   %%MID   -3)) (%%tock (make-spider   %%MID   -3)))
                      (check-expect (,(tick-handler) (make-spider (+ TOP 3) -2)) (%%tock (make-spider (+ TOP 3) -2)))
                      (check-expect (,(tick-handler) (make-spider (+ TOP 3) -3)) (%%tock (make-spider (+ TOP 3) -3)))
                      (check-expect (,(tick-handler) (make-spider (+ TOP 3) -4)) (%%tock (make-spider (+ TOP 3) -4)))
                      (check-expect (,(tick-handler) (make-spider (- BOT 3)  2)) (%%tock (make-spider (- BOT 3)  2)))
                      (check-expect (,(tick-handler) (make-spider (- BOT 3)  3)) (%%tock (make-spider (- BOT 3)  3)))
                      (check-expect (,(tick-handler) (make-spider (- BOT 3)  4)) (%%tock (make-spider (- BOT 3)  4))))))))

          (if (false? (draw-handler))
              (rubric-item 'signature 1 #f "on-draw or to-draw option to big-bang exists")
              (grade-htdf* (draw-handler)
                (lambda ()
                  (weights (*)
                    (grade-signature (Spider -> Image))
                    (grade-template-origin (Spider))
                    (grade-template (s) (compound (Number Number) make-spider spider? (spider-y spider-dy)))
                    (grade-submitted-tests)))))

              
          (if (false? (key-handler))
              (rubric-item 'signature 1 #f "on-key option to big-bang exists")
              (grade-htdf* (key-handler)
                (lambda ()
                  (weights (*)

                    (grade-signature (Spider KeyEvent -> Spider))

                    (grade-tests-validity (s ke) r
                       (%%spider? s)
                       (key-event? ke)
                       (equal? r (%%reverse-spider s ke)))
                    
                    (grade-tests-argument-thoroughness (s ke)
                      (key=? ke " ")
                      (not (key=? ke " ")))
                    
                    (grade-thoroughness-by-faulty-functions 1
                      (define (,(key-handler) s ke)
                        (make-spider (spider-y s) (- (spider-dy s))))
                      (define (,(key-handler) s ke)
                        s))
                    
                    (grade-template-origin (KeyEvent Spider))
                    (grade-template-intact 1 ke
                      (cond [(key=? ke " ") (... ke)]
                            [else (... ke)]))
                    (grade-submitted-tests)
                    (grade-additional-tests 1
                      (check-expect (,(key-handler) (make-spider 100  2) " ") (%%reverse-spider (make-spider 100  2) " "))
                      (check-expect (,(key-handler) (make-spider 200 -3) " ") (%%reverse-spider (make-spider 200 -3) " "))
                      (check-expect (,(key-handler) (make-spider 100  2) "a") (%%reverse-spider (make-spider 100  2) "a"))))))))))))




(define (ass lok alist)
  (ormap (lambda (k)
           (and (assq k alist)
                (cadr (assq k alist))))
         lok))
