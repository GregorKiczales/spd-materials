;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname river-crossing) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))


(define F "fox")
(define G "goose")
(define B "beans")

(define-struct crossing (s1 s2 b d))
;; Crossing is: (make-crossing
;;                (listof String) (listof String) (listof String) Boolean)
;; interp. as a boat crossing (scariest time since farmer is on neither side)
;;  s1, s2, b are animals on side 1, side 2 and in the boat
;;  d (direction) is where the boat will be arriving at the end of this journey
(define CFGB- (make-crossing (list F G B) '() '() true))
(define CGBF- (make-crossing (list G B F) '() '() true))                          
                           
;; solve river crossing, produce list of boat contents or false if impossible
(check-expect (solve CFGB-)
              (list (list G) '() (list F) (list G) (list B) '() (list G)))

(define (solve c0)
  (local [(define (fn-for-c c visited)
            (cond [(solved? c) (rest (map crossing-b (reverse visited)))]
                  [(contains-crossing? c visited) false]
                  [else
                   (fn-for-loc (next-crossings c) (cons c visited))]))
          (define (fn-for-loc loc visited)
            (cond [(empty? loc) false]
                  [else
                   (local [(define try (fn-for-c (first loc) visited))]
                     (if (not (false? try))
                         try
                         (fn-for-loc (rest loc) visited)))]))]
    (fn-for-c c0 empty)))

(check-expect (next-crossings CFGB-)
              (list (make-crossing (list F G B) '() '() #f)
                    (make-crossing (list F B) '() (list G) #f)))
(check-expect (next-crossings (make-crossing (list F B) '() (list G) #f))
              (list (make-crossing (list F B) (list G) '() #t)
                    (make-crossing (list F B) '() (list G) #t)))
(check-expect (next-crossings (make-crossing (list F B) (list G) '() #t))
              (list (make-crossing (list F B) (list G) '() #f)
                    (make-crossing (list B) (list G) (list F) #f)
                    (make-crossing (list F) (list G) (list B) #f)))
(check-expect (next-crossings (make-crossing (list B) (list G) (list F) #f))
              (list (make-crossing (list B) (list F) (list G) #t)
                    (make-crossing (list B) (list G) (list F) #t)))
(check-expect (next-crossings (make-crossing (list B) (list F) (list G) #t))
              (list (make-crossing (list G) (list F) (list B) #f)
                    (make-crossing (list B) (list F) (list G) #f)))
(check-expect (next-crossings (make-crossing (list G) (list F) (list B) #f))
              (list (make-crossing (list G) (list F B) '() #t)
                    (make-crossing (list G) (list B) (list F) #t)
                    (make-crossing (list G) (list F) (list B) #t)))
(check-expect (next-crossings (make-crossing (list G) (list F B) '() #t))
              (list (make-crossing (list G) (list F B) '() #f)
                    (make-crossing '() (list F B) (list G) #f)))

 
(define (next-crossings c)
  (local [(define b  (crossing-b c))
          (define d  (crossing-d c))
          ;; d = true means arriving at s1
          (define s1 (if d       (append (crossing-s1 c) b) (crossing-s1 c)))
          (define s2 (if (not d) (append (crossing-s2 c) b) (crossing-s2 c)))]
    (filter valid?
            (if d  
                (cons (make-crossing s1 s2 '() false) ;go back empty
                      (map (lambda (a)
                             (make-crossing (remove a s1) s2 (list a) false))
                           s1))
                (cons (make-crossing s1 s2 '() true) ;go back empty
                      (map (lambda (a)
                             (make-crossing s1 (remove a s2) (list a) true))
                           s2))))))


(define (valid? c)
  (local [(define (check-side? los)
            (cond [(= (length los) 3) true]
                  [(member? "fox" los) (not (member "goose" los))]
                  [(member? "goose" los) (not (member "beans" los))]
                  [else true]))]
    (and (check-side? (crossing-s1 c))
         (check-side? (crossing-s2 c)))))

(define (solved? c)
  (= (length (crossing-s2 c)) 3))

(define (contains-crossing? c loc)
  (cond [(empty? loc) false]
        [else
         (or (equals-crossing? c (first loc))
             (contains-crossing? c (rest loc)))]))

(define (equals-crossing? c1 c2)
  (and (same-elements? (crossing-s1 c1) (crossing-s1 c2))
       (same-elements? (crossing-s2 c1) (crossing-s2 c2))
       (same-elements? (crossing-b  c1) (crossing-b  c2))
       (equal? (crossing-d c1) (crossing-d c2))))

;; (listof String) (listof String) -> Boolean
;; produce true if all elements of los1 are in los2 and vice versa
(check-expect (same-elements? '()        '()) true)
(check-expect (same-elements? (list F G) '()) false)
(check-expect (same-elements? '()        (list F G)) false)
(check-expect (same-elements? (list F G) (list F G)) true)
(check-expect (same-elements? (list G F) (list F G)) true)

(define (same-elements? los1 los2)
  (and (andmap (lambda (s1) (member s1 los2)) los1)
       (andmap (lambda (s2) (member s2 los1)) los2)))



