#lang racket
(require spd-grader/grader)
(provide grader)

(define grader
  (lambda ()
    (grade-submission
      (weights (*)
        (grade-problem 1
          (grade-htdf $F2
            (let ([$F2 (car (htdf-names (car (context))))])
              (weights (*)
                (grade-refactoring 1
                  ((Wizard -> ListOfPair)
                   (Wizard -> (listof Pair)))
                  ((Wizard ListOfWizard encapsulated)
                   (Wizard (listof Wizard) encapsulated))
                  2
                  (check-expect (,$F2 (make-wiz "a" "b" "c" empty))
                                (list (list "a" "c")))
                  (check-expect (,$F2 ARTHUR)
                                (list (list "Arthur" "Weasel")
                                      (list "Bill" "")
                                      (list "Victoire" "")
                                      (list "Dominique" "")
                                      (list "Louis" "")
                                      (list "Charlie" "")
                                      (list "Fred" "")
                                      (list "George" "")
                                      (list "Ron" "Jack Russell Terrier")
                                      (list "Ginny" "horse")
                                      (list "James" "")
                                      (list "Albus" "")
                                      (list "Lily" ""))))
                (grade-tests-validity (w) r
                  (wiz? w)
                  (or (empty? r) (and (not (empty? r)) (= 2 (length (first r)))))
                  (local [(define (patroni w)
                            (local [(define (patroni--wiz w)
                                      (cons (list (wiz-name w)
                                                  (wiz-patronus w))
                                            (patroni--low (wiz-kids w))))
                                    (define (patroni--low low)
                                      (cond [(empty? low) empty]
                                            [else
                                             (append (patroni--wiz (first low))
                                                     (patroni--low (rest low)))]))]
                              (patroni--wiz w)))
                          (define (check-small l1 l2)
                            (cond [(empty? l1) (empty? l2)]
                                  [else
                                   (and (string=? (first l1) (first l2))
                                        (check-small (rest l1) (rest l2)))]))]
                    (equal? r (patroni w))))
                (grade-tests-argument-thoroughness (w)
                  (and (wiz? w) (empty? (wiz-kids w)))
                  (and (wiz? w) (not (empty? (wiz-kids w)))))
                (grade-thoroughness-by-faulty-functions 1
                  (define (,$F2 w)
                    (local [(define (patroni--wiz w)
                              (cons (list (wiz-name w)
                                          (wiz-patronus w))
                                    empty))
                            (define (patroni--low low)
                              (cond [(empty? low) empty]
                                    [else
                                     (append (patroni--wiz (first low))
                                             (patroni--low (rest low)))]))]
                      (patroni--wiz w)))
                  (define (,$F2 w)
                    (local [(define (patroni--wiz w)
                              (patroni--low (wiz-kids w)))
                            (define (patroni--low low)
                              (cond [(empty? low) empty]
                                    [else
                                     (append (patroni--wiz (first low))
                                             (patroni--low (rest low)))]))]
                      (patroni--wiz w)))
                  (define (,$F2 w)
                    (local [(define (patroni--wiz w)
                              (cons (list (wiz-name w)
                                          (wiz-patronus w))
                                    (patroni--low (wiz-kids w))))
                            (define (patroni--low low)
                              (cond [(empty? low) empty]
                                    [else
                                     (append (patroni--wiz (first low))
                                             empty)]))]
                      (patroni--wiz w))))))))
        (grade-problem 2
          (grade-htdf $F3
            (let ([$F3 (car (htdf-names (car (context))))])
              (weights (*)
                (grade-refactoring 1
                  ((Wizard String -> ListOfString)
                   (Wizard String -> (listof String)))
                  ((Wizard ListOfWizard encapsulated)
                   (Wizard (listof Wizard) encapsulated))
                  3
                  (check-expect (,$F3 (make-wiz "a" "b" "c" empty) "x") empty)
                  (check-expect (,$F3 (make-wiz "a" "b" "c" empty) "b")
                                (list "a"))                                           
                  (check-expect (,$F3 ARTHUR "ash")
                                (list "Charlie" "Ron")))
                (grade-tests-validity (w s) r
                  (wiz? w)
                  (string? s)
                  (or (empty? r) (and (not (empty? r)) (string? (first r))))
                  (local [(define (has-wand-of-wood w wood)
                            (local [(define (has-wand-of-wood--wiz w)
                                      (if (string=? (wiz-wand w) wood)
                                          (cons (wiz-name w)
                                                (has-wand-of-wood--low (wiz-kids w)))
                                          (has-wand-of-wood--low (wiz-kids w))))
                                    (define (has-wand-of-wood--low low)
                                      (cond [(empty? low) empty]
                                            [else
                                             (append (has-wand-of-wood--wiz (first low))
                                                     (has-wand-of-wood--low (rest low)))]))]
                              (has-wand-of-wood--wiz w)))]
                    (equal? r (has-wand-of-wood w s))))
                (grade-thoroughness-by-faulty-functions 1
                  (define (,$F3 w wood)
                    (local [(define (has-wand-of-wood--wiz w)
                              (cons (wiz-name w)
                                    (has-wand-of-wood--low (wiz-kids w))))
                            (define (has-wand-of-wood--low low)
                              (cond [(empty? low) empty]
                                    [else
                                     (append (has-wand-of-wood--wiz (first low))
                                             (has-wand-of-wood--low (rest low)))]))]
                      (has-wand-of-wood--wiz w)))
                  (define (,$F3 w wood)
                    (local [(define (has-wand-of-wood--wiz w)
                              (has-wand-of-wood--low (wiz-kids w)))
                            (define (has-wand-of-wood--low low)
                              (cond [(empty? low) empty]
                                    [else
                                     (append (has-wand-of-wood--wiz (first low))
                                             (has-wand-of-wood--low (rest low)))]))]
                      (has-wand-of-wood--wiz w)))
                  (define (,$F3 w wood)
                    (local [(define (has-wand-of-wood--wiz w)
                              (if (string=? (wiz-wand w) wood)
                                  (cons (wiz-name w)
                                        (has-wand-of-wood--low (wiz-kids w)))
                                  (has-wand-of-wood--low (wiz-kids w))))
                            (define (has-wand-of-wood--low low)
                              (cond [(empty? low) empty]
                                    [else
                                     (append (has-wand-of-wood--wiz (first low))
                                             empty)]))]
                      (has-wand-of-wood--wiz w)))
                  (define (,$F3 w wood)
                    (local [(define (has-wand-of-wood--wiz w)
                              (if (string=? (wiz-wand w) wood)
                                  (cons (wiz-name w)
                                        (has-wand-of-wood--low (wiz-kids w)))
                                  (has-wand-of-wood--low (wiz-kids w))))
                            (define (has-wand-of-wood--low low)
                              (cond [(empty? low) empty]
                                    [else
                                     (append (has-wand-of-wood--low (rest low))
                                             empty)]))]
                      (has-wand-of-wood--wiz w))))))))))))
                                                        
