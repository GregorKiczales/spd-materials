#lang racket
(require spd-grader/grader
         spd-grader/check-template
         spd-grader/templates)

(provide grader)

(define Egg
  (compound (Number Number Number)
            make-egg egg?
            (egg-x egg-y egg-r)))

(define ListOfEgg (make-listof-type 'ListOfEgg 'fn-for-loe 'Egg 'fn-for-egg))


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
      
      (define (%%handle-mouse loe x y me)
        (cond [(mouse=? me "button-down") (cons (make-egg x y 0) loe)]
              [else loe]))
      
      (define (%%handle-key loe ke)
        (cond [(key=? ke " ") empty]
              [else loe]))
      
      (grade-problem 1
        (weights (*)

          (grade-htdd Egg
            (grade-dd-rules-and-template Egg))

          (grade-htdd ListOfEgg
            (grade-dd-rules-and-template ListOfEgg))

          (grade-htdf main
            (grade-signature (ListOfEgg -> ListOfEgg)))

          (grade-bb-handler (on-tick tick-handler-name tick-handler-defn)
            (weights (*)
              
              (grade-signature (ListOfEgg -> ListOfEgg))

              (grade-tests-validity (loe) r
                (list? loe)
                (andmap egg? loe)
                (equal? r (map %%next-egg loe)))
              
              (grade-argument-thoroughness ()
                (per-args (loe)
                  (empty? loe)
                  (> (length loe) 1)))
                
              (grade-thoroughness-by-faulty-functions 1
                (define (,tick-handler-name loe)
                  (cond [(empty? loe) empty]
                        [else
                         (cons (next-egg (first loe)) empty)]))
                (define (,tick-handler-name loe)
                  (local [(define (toc loe)
                            (cond [(empty? loe) empty]
                                  [else
                                   (cons (first loe)
                                         (toc (rest loe)))]))]
                    (toc loe))))
              
              (grade-template-origin (ListOfEgg))
              (grade-template         ListOfEgg)
              (grade-template-intact  ListOfEgg)

              (grade-submitted-tests)
              (grade-additional-tests 1
                (check-expect (,tick-handler-name empty) empty)
                (check-expect (,tick-handler-name (cons (make-egg 10 20 30) empty))
                              (cons (make-egg 10 (+ 20 FALL-SPEED)(+ 30 SPIN-SPEED)) empty)))))
          
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
              (grade-template         Egg)

              (grade-submitted-tests)
              (grade-additional-tests 1
                (check-expect (next-egg (make-egg 10 20 30))
                              (make-egg 10 (+ 20 FALL-SPEED)(+ 30 SPIN-SPEED)))
                (check-expect (next-egg (make-egg 1 2 3))
                              (make-egg 1 (+ 2 FALL-SPEED)(+ 3 SPIN-SPEED))))))


          (grade-bb-handler (to-draw draw-handler-name)
            (weights (*)
              
              (grade-signature (ListOfEgg -> Image))

              (grade-tests-validity (loe) r
                (list? loe)
                (andmap egg? loe)
                (equal? r (foldr %%place-egg MTS loe)))

              
              (grade-argument-thoroughness ()
                (per-args (loe)
                  (empty? loe)
                  (> (length loe) 1)))
              
              (grade-thoroughness-by-faulty-functions 1
                #; ;!!! solution fails at this???
                (define (,draw-handler-name loe)
                  (cond [(empty? loe) MTS]
                        [else
                         (%%place-egg (first loe) MTS)]))
                
                (define (,draw-handler-name loe)
                  (local [(define (rend loe)
                            (cond [(empty? loe) empty-image]
                                  [else
                                   (%%place-egg (first loe)
                                                (rend (rest loe)))]))]
                    (rend loe))))
              
              (grade-template-origin (ListOfEgg))
              (grade-template         ListOfEgg)
              (grade-template-intact  ListOfEgg);!!!

              (grade-submitted-tests)
              (grade-additional-tests 1
                (check-expect (,draw-handler-name empty) MTS)
                (check-expect (,draw-handler-name (cons (make-egg 10 20 30)
                                                   empty))
                              (place-image (rotate 30 YOSHI-EGG) 10 20
                                           MTS))
                (check-expect (,draw-handler-name (cons (make-egg 110 120 130)
                                                   (cons (make-egg 10 20 30)
                                                         empty)))
                              (place-image (rotate 130 YOSHI-EGG) 110 120
                                           (place-image (rotate 30 YOSHI-EGG) 10 20
                                                        MTS))))))
          
          (grade-htdf place-egg
            (weights (*)

              (grade-signature (Egg Image -> Image))

              (grade-tests-validity (e img) r
                (egg? e)
                (equal? r (%%place-egg e img)))

              (grade-argument-thoroughness ()
                (per-args (e img)
                  (and (egg? e) (not (or (= (egg-x e) (egg-y e))
                                         (= (egg-x e) (egg-r e))
                                         (= (egg-y e) (egg-r e)))))
                  (not (equal? img MTS))))

              #; ;!!!
              (grade-thoroughness-by-faulty-functions 1
                (define (place-egg e img)
                  (place-image (rotate  (egg-r e) YOSHI-EGG)
                               100
                               100
                               img)))

              (grade-template-origin (Egg))
              (grade-template         Egg Image)

              (grade-submitted-tests)
              (grade-additional-tests 1
                (check-expect (place-egg (make-egg 10 20 30) MTS)
                              (place-image (rotate  30 YOSHI-EGG) 10 20 MTS))
                (check-expect (place-egg (make-egg 110 120 130) MTS)
                              (place-image (rotate  130 YOSHI-EGG) 110 120 MTS)))))

          
          (grade-bb-handler (on-mouse mouse-handler-name mouse-handler-defn)

            (weights (*)
              
              (grade-signature (ListOfEgg Integer Integer MouseEvent -> ListOfEgg))

              (grade-tests-validity (loe i1 i2 me) r
                (number? i1)
                (number? i2)
                (>= (length r) (length loe)))

              (grade-argument-thoroughness ()
                (per-args (loe i1 i2 me)
                  (mouse=? me "button-down")
                  (not (mouse=? me "button-down"))))

              (grade-thoroughness-by-faulty-functions 1
                (define (,mouse-handler-name loe x y me)
                  (cond [(mouse=? me "drag") (cons (make-egg x y 0) loe)]
                        [else loe]))
                (define (,mouse-handler-name loe x y me)
                  (cond [(mouse=? me "button-down") empty]
                        [else loe])))
              
              (grade-template-origin (MouseEvent))
              (grade-template/body (ws x y me)
                (cond [(mouse=? me "button-down") (... ws x y)]
                      [else (... ws x y)]))

              (grade-questions-intact/body mouse-handler-defn (ws x y me)
                (cond [(mouse=? me "button-down") (... ws x y)]
                      [else (... ws x y)]))
              
              (grade-submitted-tests)
              (grade-additional-tests 1
                (check-expect (,mouse-handler-name empty 10 40 "button-down")
                              (cons (make-egg 10 40 0) empty))
                (check-expect (,mouse-handler-name empty 90 100 "drag") empty))))
          

          (grade-bb-handler (on-key key-handler-name key-handler-defn)

            (weights (*)
              
              (grade-signature (ListOfEgg KeyEvent -> ListOfEgg))

              (grade-tests-validity (loe ke) r
                (list? loe)
                (andmap egg? loe)
                (equal? r (%%handle-key loe ke)))

              (grade-argument-thoroughness ()
                (per-args (loe ke)
                  (and (key=? ke " ") (not (empty? loe)))
                  (not (key=? ke " "))))

              (grade-thoroughness-by-faulty-functions 1
                (define (,key-handler-name loe ke) empty)
                (define (,key-handler-name loe ke) loe))
              
              (grade-template-origin (KeyEvent))
              (grade-template/body (ws ke)
                (cond [(key=? ke " ") (... ws)]
                      [else (... ws)]))
              
              (grade-questions-intact/body key-handler-defn (ke)
                (cond [(key=? ke " ") (... ke)]
                      [else (... ke)]))
              
              (grade-submitted-tests)
              (grade-additional-tests 1
                (check-expect (,key-handler-name (cons E1 (cons E2 empty)) " ") empty)
                (check-expect (,key-handler-name (cons E1 empty) "a") (cons E1 empty))))))))))



