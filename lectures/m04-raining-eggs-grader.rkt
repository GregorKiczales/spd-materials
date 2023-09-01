#lang racket
(require spd-grader/check-template)
(require spd-grader/grader)
(require racket/function)
(require syntax/stx)
(provide grader)

(define draw-handler  (make-parameter #f))
(define tick-handler  (make-parameter #f))
(define mouse-handler (make-parameter #f))
(define key-handler   (make-parameter #f))

(define grader
  (lambda ()
    (grade-submission

      (define (%%next-egg e)
        (make-egg (egg-x e)
                  (+ (egg-y e) FALL-SPEED)
                  (+ (egg-r e) SPIN-SPEED)))
      
      (define (%%place-egg e img)
        (place-image (rotate  (egg-r e) YOSHI-EGG)
                     (egg-x e)
                     (egg-y e)
                     img))
      
      (define (%%lay-egg loe x y me)
        (cond [(mouse=? me "button-down") (cons (make-egg x y 0) loe)]
              [else loe]))
      
      (define (%%handle-key loe ke)
        (cond [(key=? ke " ") empty]
              [else loe]))
    
      (grade-problem 1
        (weights (*)

          (grade-htdd Egg
            (grade-dd-rules-and-template (compound (Number Number Number)
                                                   make-egg egg?
                                                   (egg-x egg-y egg-r))))

          (grade-htdd ListOfEgg
            (grade-dd-rules-and-template (one-of empty
                                                 (compound ((ref fn-for-egg) (self-ref fn-for-loe))
                                                           cons cons?
                                                           (first rest)))))

          (grade-htdf main
            (with-handlers ([void (λ (exn) (score #f 1 1 '() (list (message #f "found main function"))))])
              (let* ([htdf (car (context))]
                     [defn (car (htdf-defns htdf))]
                     [options (cddr (caddr defn))])
                (weights (*)
                  (draw-handler  (ass '(on-draw to-draw) options))
                  (tick-handler  (ass '(on-tick) options))
                  (mouse-handler (ass '(on-mouse) options))
                  (key-handler   (ass '(on-key) options))
                  (grade-signature (ListOfEgg -> ListOfEgg))))))

          (if (false? (tick-handler))
              (rubric-item 'signature #f "on-tick option to big-bang exists")
              (grade-htdf* (tick-handler)
                           (lambda ()
                             (weights (*)
                                      
                   (grade-signature (ListOfEgg -> ListOfEgg))

                   (grade-tests-validity (loe) r
                     (list? loe)
                     (andmap egg? loe)
                     (equal? r (map %%next-egg loe)))
                    
                   (grade-tests-argument-thoroughness (loe)
                     (empty? loe)
                     (> (length loe) 1))

                   (grade-thoroughness-by-faulty-functions 1
                     (define (,(tick-handler) loe)
                       (cond [(empty? loe) empty]
                             [else
                              (cons (next-egg (first loe)) empty)]))
                     (define (,(tick-handler) loe)
                       (local [(define (toc loe)
                                 (cond [(empty? loe) empty]
                                       [else
                                        (cons (first loe)
                                              (toc (rest loe)))]))]
                         (toc loe))))
                    
                   (grade-template-origin (ListOfEgg))
                   (grade-template 1 (loe) (one-of empty
                                                   (compound ((ref fn-for-egg) (self-ref fn-for-loe))
                                                             cons cons?
                                                             (first rest))))
                   (grade-template-intact ListOfEgg)
                   (grade-submitted-tests)
                   (grade-additional-tests 1
                     (check-expect (,(tick-handler) empty) empty)
                     (check-expect (,(tick-handler) (cons (make-egg 10 20 30) empty))
                                   (cons (make-egg 10 (+ 20 FALL-SPEED)(+ 30 SPIN-SPEED)) empty)))))))
          
          (grade-htdf next-egg
            (weights (*)

              (grade-signature (Egg -> Egg))

              (grade-tests-validity (e) r
                (egg? e)
                (equal? r (%%next-egg e)))

              (grade-thoroughness-by-faulty-functions 1
                (define (next-egg e)
                  (make-egg (egg-x e)
                            (egg-y e)
                            (egg-r e))))

              (grade-template-origin (Egg))
              (grade-template 1 (e) (compound (Number Number Number)
                                              make-egg egg?
                                              (egg-x egg-y egg-r)))
              (grade-submitted-tests)
              (grade-additional-tests 1
                (check-expect (next-egg (make-egg 10 20 30))
                              (make-egg 10 (+ 20 FALL-SPEED)(+ 30 SPIN-SPEED))))))
          
          (if (false? (draw-handler))
              (rubric-item 'signature #f "to-draw/on-draw option to big-bang exists")
              (grade-htdf* (draw-handler)
                           (lambda ()
                             (weights (*)
                                      
                    (grade-signature (ListOfEgg -> Image))

                    (grade-tests-validity (loe) r
                      (list? loe)
                      (andmap egg? loe)
                      (equal? r (foldr %%place-egg MTS loe)))

                    
                    (grade-tests-argument-thoroughness (loe)
                      (empty? loe)
                      (> (length loe) 1))
                    
                    (grade-thoroughness-by-faulty-functions 1
                      #; ;!!! solution fails at this???
                      (define (,(draw-handler) loe)
                        (cond [(empty? loe) MTS]
                              [else
                               (%%place-egg (first loe) MTS)]))
                      
                      (define (,(draw-handler) loe)
                        (local [(define (rend loe)
                                  (cond [(empty? loe) empty-image]
                                        [else
                                         (%%place-egg (first loe)
                                                      (rend (rest loe)))]))]
                          (rend loe))))
                    
                    (grade-template-origin (ListOfEgg))
                    (grade-template 1 (loe) (one-of empty
                                                    (compound ((ref fn-for-egg) (self-ref fn-for-loe))
                                                              cons cons?
                                                              (first rest))))
                    (grade-template-intact ListOfEgg)                    
                    (grade-submitted-tests)
                    (grade-additional-tests 1
                      (check-expect (check-expect (,(draw-handler) empty) MTS)
                                    (check-expect (,(draw-handler) (cons (make-egg 10 20 30)
                                                                         empty))
                                                  (place-image (rotate 30 YOSHI-EGG) 10 20
                                                               MTS))
                                    (check-expect (,(draw-handler) (cons (make-egg 110 120 130)
                                                                         (cons (make-egg 10 20 30)
                                                                               empty)))
                                                  (place-image (rotate 130 YOSHI-EGG) 110 120
                                                               (place-image (rotate 30 YOSHI-EGG) 10 20
                                                                            MTS)))))))))
          
          (grade-htdf place-egg
            (weights (*)

              (grade-signature (Egg Image -> Image))

              (grade-tests-validity (e img) r
                (egg? e)
                (equal? r (%%place-egg e img)))

              (grade-tests-argument-thoroughness (e img)
                (and (egg? e) (not (or (= (egg-x e) (egg-y e))
                                       (= (egg-x e) (egg-r e))
                                       (= (egg-y e) (egg-r e)))))
                (not (equal? img MTS)))

              #; ;!!!
              (grade-thoroughness-by-faulty-functions 1
                (define (place-egg e img)
                  (place-image (rotate  (egg-r e) YOSHI-EGG)
                               100
                               100
                               img)))
              
              (grade-template-origin (Egg))
              (grade-template 1 (e img) (compound (Number Number Number)
                                                  make-egg egg?
                                                  (egg-x egg-y egg-r)))


              (grade-submitted-tests)
              (grade-additional-tests 1
                (check-expect (place-egg (make-egg 10 20 30) MTS)
                              (place-image (rotate  30 YOSHI-EGG) 10 20 MTS))
                (check-expect (place-egg (make-egg 110 120 130) MTS)
                              (place-image (rotate  130 YOSHI-EGG) 110 120 MTS)))))

        
          (if (false? (mouse-handler))
              (rubric-item 'signature #f "on-mouse option to big-bang exists")
              (grade-htdf* (mouse-handler)
                           (lambda ()
                             (weights (*)
                                      
                    (grade-signature (ListOfEgg Integer Integer MouseEvent -> ListOfEgg))

                    (grade-tests-validity (loe i1 i2 me) r
                      (number? i1)
                      (number? i2)
                      (>= (length r) (length loe)))

                    (grade-tests-argument-thoroughness (loe i1 i2 me)
                      (mouse=? me "button-down")
                      (not (mouse=? me "button-down")))

                    (grade-thoroughness-by-faulty-functions 1
                      (define (,(mouse-handler) loe x y me)
                        (cond [(mouse=? me "drag") (cons (make-egg x y 0) loe)]
                              [else loe]))
                      (define (,(mouse-handler) loe x y me)
                        (cond [(mouse=? me "button-down") empty]
                              [else loe])))
                    
                    (grade-template-origin (MouseEvent))
                    (grade-template-intact 1 me
                      (cond [(mouse=? me "button-down") (... me)]
                            [else (... me)]))
                    (grade-submitted-tests)
                    (grade-additional-tests 1
                      (check-expect (,(mouse-handler) empty 10 40 "button-down")
                                    (cons (make-egg 10 40 0) empty))
                      (check-expect (,(mouse-handler) empty 90 100 "drag") empty))))))
          

          (if (false? (key-handler))
              (rubric-item 'signature #f "on-key option to big-bang exists")
              (grade-htdf* (key-handler)
                           (lambda ()
                             (weights (*)
                                      
                    (grade-signature (ListOfEgg KeyEvent -> ListOfEgg))

                    (grade-tests-validity (loe ke) r
                      (list? loe)
                      (andmap egg? loe)
                      (equal? r (%%handle-key loe ke)))

                    (grade-tests-argument-thoroughness (loe ke)
                      (and (key=? ke " ") (not (empty? loe)))
                      (not (key=? ke " ")))

                    (grade-thoroughness-by-faulty-functions 1
                      (define (,(key-handler) loe ke)
                        empty))
                    
                    (grade-template-origin (KeyEvent))
                    (grade-template-intact 1 ke
                      (cond [(key=? ke " ") (... ke)]
                            [else (... ke)]))
                    (grade-submitted-tests)
                    (grade-additional-tests 1
                      (check-expect (,(key-handler) (cons E1 (cons E2 empty)) " ") empty)
                      (check-expect (,(key-handler) (cons E1 empty) "a") (cons E1 empty))))))))))))


(define (ass lok alist)
  (ormap (lambda (k)
           (and (assq k alist)
                (cadr (assq k alist))))
         lok))
