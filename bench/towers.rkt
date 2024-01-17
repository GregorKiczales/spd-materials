;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname towers) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

(require spd/tags)
(require 2htdp/image)


;; S (S -> (listof S)) (S -> Boolean) -> (listof S) or "fail"
;; abstract search over S space with cycle detection; produces shortest path
(define (solve init next solved?)
  ;; path is (listof S); previous states on the recursive path
  (local [(define (solve/one s path)
            (cond [(solved? s) (reverse (cons s path))]
                  [(member s path) "fail"]
                  [else
                   (solve/list (next s) (cons s path))]))
          (define (solve/list los path)
            (cond [(empty? los) "fail"]
                  [else
                   (local [(define try/one  (solve/one (first los) path))
                           (define try/list (solve/list (rest los) path))]
                     (cond [(equal? try/one  "fail") try/list]
                           [(equal? try/list "fail") try/one]
                           [(<= (length try/one) (length try/list)) try/one]
                           [else try/list])
                     #;
                     (if (not
                         try
                         (solve/list (rest los) path)))
                     )]))]

    (solve/one init '())))



;; Towers of Hanoi built on the above

(@htdd Towers)
(define-struct towers (a b c))
;; Towers is (make-towers (listof Natural)  (listof Natural)  (listof Natural))
;; interp. the three towers, each with rings of different sizes on it.
;;         smallest ring is 1, then 2 etc. A Towers configuration is valid if
;;         each of the three lists is in ascending order.


(@signature Natural -> (listof Tower))
;; produce path to solution of Hanoi of given size
(check-expect (hanoi 3)
              (list (make-towers '(1 2 3) '()    '())
                    (make-towers '(2 3)   '()    '(1))
                    (make-towers '(3)     '(2)   '(1))
                    (make-towers '(3)     '(1 2) '())
                    (make-towers '()      '(1 2) '(3))
                    (make-towers '(1)     '(2)   '(3))
                    (make-towers '(1)     '()    '(2 3))
                    (make-towers '()      '()    '(1 2 3))))
                    
(define (hanoi n)
  (solve (make-towers (build-list n add1) '() '())
         next-towers
         solved-towers?))


(@signature Towers -> Boolean)
;; Constraint: twrs is valid
;; produce true if all disks are on the c tower
(check-expect (solved-towers? (make-towers (list) (list) (list 1))) true)
(check-expect (solved-towers? (make-towers (list 2) (list) (list 1))) false)
(check-expect (solved-towers? (make-towers (list) (list 2) (list 1))) false)

(define (solved-towers? twrs)
  (and (empty? (towers-a twrs))
       (empty? (towers-b twrs))))


(@signature Towers -> (listof Towers))
;; produce the next possible valid configurations of disks
(define (next-towers twrs)
  (local [;; (@signature Towers -> Boolean)
          ;; produce true if all towers are sorted?
          (define (valid? twrs)
            (and (sorted? (towers-a twrs))
                 (sorted? (towers-b twrs))
                 (sorted? (towers-c twrs))))
          
          ;; (@signature (listof Natural) -> Boolean)
          ;; produce true if lon is sorted smallest to largest, or empty
          (define (sorted? lon0)
            ;; prev is Integer; element of lon0 before (first lon), -1 init
            (local [(define (scan lon prev)
                      (cond [(empty? lon) true]
                            [else
                             (and (> (first lon) prev)
                                  (scan (rest lon) (first lon)))]))]
              (scan lon0 -1)))

          (define a (towers-a twrs))
          (define b (towers-b twrs))
          (define c (towers-c twrs))]
    (filter valid?
            (append (if (empty? a)
                        '()
                        (list (make-towers (rest a) (cons (first a) b) c)
                              (make-towers (rest a) b (cons (first a) c))))
                    (if (empty? b)
                        '()
                        (list (make-towers (cons (first b) a) (rest b) c)
                              (make-towers a (rest b) (cons (first b) c))))
                    (if (empty? c)
                        '()
                        (list (make-towers (cons (first c) a) b (rest c))
                              (make-towers a (cons (first c) b) (rest c))))))))


(@signature Towers -> Image)
;; produce VERY simple rendering of a towers of Hanoi configuration
(define (render-towers twrs)
  (local [(define (render-one lon)
            (foldr above
                   (rectangle 20 1 "solid" "white")
                   (map (lambda (n) (rectangle (* n 10) 8 "solid" "black"))
                        lon)))]
    (beside (render-one (towers-a twrs))
            (render-one (towers-b twrs))
            (render-one (towers-c twrs)))))
          
            

(foldr append
       empty
       (map (lambda (twrs)
              (list (render-towers twrs) 
                    (rectangle 30 1 "solid" "white")))
            (hanoi 3)))


       
