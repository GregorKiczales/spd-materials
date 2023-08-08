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
                              (patroni--wiz w)))]
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
                (grade-signature (Wizard String -> Wizard or false))
                (grade-tests-validity (w s) r
                  (wiz? w)
                  (string? s)
                  (or (wiz? r) (false? r))
                  (local [(define (find-wiz w n)
                            (local [(define (fn-for-wizard w)
                                      (if (string=? (wiz-name w) n)
                                          w
                                          (fn-for-low (wiz-kids w))))
                                    (define (fn-for-low low)
                                      (cond [(empty? low) false]
                                            [else
                                             (local [(define try (fn-for-wizard (first low)))]
                                               (if (not (false? try))
                                                   try
                                                   (fn-for-low (rest low))))]))]
                              (fn-for-wizard w)))]
                    (equal? r (find-wiz w s))))
                (grade-tests-argument-thoroughness (w s)
                  (and (wiz? w) (empty? (wiz-kids w))  (local [(define (find-wiz w n)
                                                                 (local [(define (fn-for-wizard w)
                                                                           (if (string=? (wiz-name w) n)
                                                                               w
                                                                               (fn-for-low (wiz-kids w))))
                                                                         (define (fn-for-low low)
                                                                           (cond [(empty? low) false]
                                                                                 [else
                                                                                  (local [(define try (fn-for-wizard (first low)))]
                                                                                    (if (not (false? try))
                                                                                        try
                                                                                        (fn-for-low (rest low))))]))]
                                                                   (fn-for-wizard w)))]
                                                         (not (false? (find-wiz w s)))))
                  (and (wiz? w) (empty? (wiz-kids w))  (local [(define (find-wiz w n)
                                                                 (local [(define (fn-for-wizard w)
                                                                           (if (string=? (wiz-name w) n)
                                                                               w
                                                                               (fn-for-low (wiz-kids w))))
                                                                         (define (fn-for-low low)
                                                                           (cond [(empty? low) false]
                                                                                 [else
                                                                                  (local [(define try (fn-for-wizard (first low)))]
                                                                                    (if (not (false? try))
                                                                                        try
                                                                                        (fn-for-low (rest low))))]))]
                                                                   (fn-for-wizard w)))]
                                                         (false? (find-wiz w s))))
                  (and (wiz? w) (not (empty? (wiz-kids w)))  (local [(define (find-wiz w n)
                                                                       (local [(define (fn-for-wizard w)
                                                                                 (if (string=? (wiz-name w) n)
                                                                                     w
                                                                                     (fn-for-low (wiz-kids w))))
                                                                               (define (fn-for-low low)
                                                                                 (cond [(empty? low) false]
                                                                                       [else
                                                                                        (local [(define try (fn-for-wizard (first low)))]
                                                                                          (if (not (false? try))
                                                                                              try
                                                                                              (fn-for-low (rest low))))]))]
                                                                         (fn-for-wizard w)))]
                                                               (not (false? (find-wiz w s)))))
                  (and (wiz? w) (not (empty? (wiz-kids w)))  (local [(define (find-wiz w n)
                                                                       (local [(define (fn-for-wizard w)
                                                                                 (if (string=? (wiz-name w) n)
                                                                                     w
                                                                                     (fn-for-low (wiz-kids w))))
                                                                               (define (fn-for-low low)
                                                                                 (cond [(empty? low) false]
                                                                                       [else
                                                                                        (local [(define try (fn-for-wizard (first low)))]
                                                                                          (if (not (false? try))
                                                                                              try
                                                                                              (fn-for-low (rest low))))]))]
                                                                         (fn-for-wizard w)))]
                                                               (false? (find-wiz w s)))))
                (grade-thoroughness-by-faulty-functions 1
                  (define (,$F3 w n)
                    (local [(define (fn-for-wizard w)
                              (if (string=? (wiz-name w) n)
                                  w
                                  (fn-for-low (wiz-kids w))))
                            (define (fn-for-low low)
                              (cond [(empty? low) true]
                                    [else
                                     (local [(define try (fn-for-wizard (first low)))]
                                       (if (not (false? try))
                                           try
                                           (fn-for-low (rest low))))]))]
                      (fn-for-wizard w)))
                  (define (,$F3 w n)
                    (local [(define (fn-for-wizard w)
                              (if (string=? (wiz-name w) n)
                                  w
                                  (fn-for-low (wiz-kids w))))
                            (define (fn-for-low low)
                              (cond [(empty? low) false]
                                    [else
                                     (local [(define try (fn-for-wizard (first low)))]
                                       try)]))]
                      (fn-for-wizard w)))
                  (define (,$F3 w n)
                    (local [(define (fn-for-wizard w)
                              (if (string=? (wiz-name w) n)
                                  w
                                  (fn-for-low (wiz-kids w))))
                            (define (fn-for-low low)
                              (cond [(empty? low) false]
                                    [else
                                     (fn-for-low (rest low))]))]
                      (fn-for-wizard w)))
                  (define (,$F3 w n)
                    (local [(define (fn-for-wizard w)
                              w)
                            (define (fn-for-low low)
                              (cond [(empty? low) false]
                                    [else
                                     (local [(define try (fn-for-wizard (first low)))]
                                       (if (not (false? try))
                                           try
                                           (fn-for-low (rest low))))]))]
                      (fn-for-wizard w)))
                  (define (,$F3 w n)
                    (local [(define (fn-for-wizard w)
                              (fn-for-low (wiz-kids w)))
                            (define (fn-for-low low)
                              (cond [(empty? low) false]
                                    [else
                                     (local [(define try (fn-for-wizard (first low)))]
                                       (if (not (false? try))
                                           try
                                           (fn-for-low (rest low))))]))]
                      (fn-for-wizard w))))
                (score-max (grade-template-origin (Wizard ListOfWizard encapsulated try-catch))
                           (grade-template-origin  (Wizard (listof Wizard) encapsulated try-catch)))
                (grade-submitted-tests 1 4)
                (grade-additional-tests 1
                  (check-expect (,$F3 (make-wiz "James" "" "" empty) "James")
                                (make-wiz "James" "" "" empty))
                  (check-expect (,$F3 (make-wiz "James" "" "" empty) "Ron")
                                false)
                  (check-expect (,$F3 ARTHUR "Ron") 
                                (make-wiz "Ron"     "ash" "Jack Russell Terrier" empty))
                  (check-expect (,$F3 ARTHUR "Sally") 
                                false))))))))))

