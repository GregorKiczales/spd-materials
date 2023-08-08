
Intro -

done learning SR w/ NR - will move on to genrec
will continue to use SR all the time

difference between sr (natural recursion) and genrec


setup qsort by walking through picture
xition to starter
class works

interrupt to setup that it's two filters




;;                   (list 6 8 1 9 3 7 2) 
;;                   /         |        \
;;                  /          |         \
;;        (list 1 3 2)         6        (list 8 9 7)
;;         /  |  \                         /    |    \
;;        /   |   \                       /     |     \
;;     empty  1 (list 3 2)          (list 7)    8    (list 9)
;;                /  |  \             / | \           /  |  \
;;               /   |   \           /  |  \         /   |   \
;;          (list 2) 3  empty     empty 7 empty    empty 9  empty
;;           /  |  \
;;        empty 2 empty

;; Please design a function that does quicksort
(@problem 1)
(@htdf qsort)
(@signature (listof Number) -> (listof Number))
;; use quicksort to produce list of numbers in ascending order
;; CONSTRAINT there are no duplicates
(check-expect (qsort (list)) (list))
(check-expect (qsort (list 2)) (list 2))
(check-expect (qsort (list 5 4 6)) (list 4 5 6))
(check-expect (qsort (list 6 5 4)) (list 4 5 6)) ;all < pivot
(check-expect (qsort (list 4 6 5)) (list 4 5 6)) ;all > pivot
(check-expect (qsort (list 3 1 5 2 4 6)) (list 1 2 3 4 5 6))
(check-expect (qsort (list 8 3 11 1 12 5 2 10 4 6))
              (list 1 2 3 4 5 6 8 10 11 12))

(@template-origin genrec use-abstract-fn)

(define (qsort lon)
  (cond [(empty? lon) empty]
        [else
         (local [(define p (first lon))
                 (define (<p? x) (< x p))
                 (define (>p? x) (> x p))]
           
           (append (qsort (filter <p? lon))
                   (list p)
                   (qsort (filter >p? lon))))]))



clickers

A, C, C

C, ???


  ;; Base case: empty
  ;; Reduction: strict subset (at least one element removed) from lon
  ;; Argument: repeated strict subset of list always reaches empty



Those local functions:
- are small
- used only one place
- the body is as clear as the name

---> use lambda


#;  ;this version uses lambda
(define (qsort lon)
  ;; Base case: empty
  ;; Reduction: strict subset of lon
  ;; Argument: repeated strict subset of list always reaches empty
  (cond [(empty? lon) empty]
        [else
         (local [(define p (first lon))]
           (append (qsort (filter (lambda (x) (< x p)) lon))
                   (list p)
                   (qsort (filter (lambda (x) (> x p))  lon))))]))



-25:00

QUICKLY
show picture, say it is (cantor 300)
encourage them to draw picture
let them work

after a couple of minutes slowly start marking up image



(define CUTOFF 4)

(@htdf cantor)
(@signature Number -> Image)
;; Produce cantor set image of given width
;; CONSTRAINT: w >= 0
(check-expect (cantor 0)
              (rectangle 0             BAR-HEIGHT "solid" BAR-COLOR))
(check-expect (cantor (sub1 CUTOFF))
              (rectangle (sub1 CUTOFF) BAR-HEIGHT "solid" BAR-COLOR))
(check-expect (cantor CUTOFF)
              (rectangle CUTOFF        BAR-HEIGHT "solid" BAR-COLOR))

(check-expect (cantor (* 3 CUTOFF))
              (above (rectangle (* 3 CUTOFF) BAR-HEIGHT "solid" BAR-COLOR)
                     (rectangle (* 3 CUTOFF) GAP-HEIGHT "solid" SPACER-COLOR)
                     (beside (cantor CUTOFF)
                             (rectangle CUTOFF BAR-HEIGHT "solid" SPACER-COLOR)
                             (cantor CUTOFF))))

(@template-origin genrec)

(define (cantor w)
  ;; base case:  w <= CUTOFF, (note CUTOFF is > 0)
  ;; reduction:  w / 3
  ;; argument:   repeated division by 3 approaches 0, so will get below CUTOFF 
  
  (cond [(<= w CUTOFF) (rectangle w BAR-HEIGHT "solid" BAR-COLOR)]
        [else
         (local [(define w/3 (/ w 3))
                 (define top (rectangle w BAR-HEIGHT "solid" BAR-COLOR))
                 (define gap (rectangle w GAP-HEIGHT "solid" SPACER-COLOR))
                 (define l&r (cantor w/3))
                 (define spc (rectangle w/3 BAR-HEIGHT "solid" SPACER-COLOR))]
           (above top
                  gap
                  (beside l&r spc l&r)))]))
