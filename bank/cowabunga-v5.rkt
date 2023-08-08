;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname cowabunga-v5) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/image)
(require 2htdp/universe)
(require spd/tags)

(@assignment bank/compound-l3)
(@cwl ???)

;;   cowabunga-starter.rkt  problem statement
;;   cowabunga-v0.rkt       has constants
;;   cowabunga-v1.rkt       has data definition
;;   cowabunga-v2.rkt       has main function, wish list entries
;;   cowabunga-v3.rkt       has next-cow
;;   cowabunga-v4.rkt       has render-cow
;; > cowabunga-v5.rkt       has handle-key
;;   cowabunga-v6.rkt       waddles

(@problem 1)

;; A cow, meandering back and forth across the screen.

(@htdw Cow)

;; =================
;; Constants:

(define WIDTH  400)
(define HEIGHT 200)


(define CTR-Y (/ HEIGHT 2)) 


(define RCOW
  (bitmap/url
   "https://cs110.students.cs.ubc.ca/bank/rcow.png"))
(define LCOW
  (bitmap/url
   "https://cs110.students.cs.ubc.ca/bank/lcow.png"))


(define MTS (empty-scene WIDTH HEIGHT))



;; =================
;; Data definitions:

(@htdd Cow)
(define-struct cow (x dx))
;; Cow is (make-cow Natural Integer)
;; interp. (make-cow x dx) is a cow with x coordinate x and x velocity dx
;;         the x is the center of the cow, in the interval [0, WIDTH]
;;         x  is in screen coordinates (pixels)
;;         dx is in pixels per tick
;;
(define C1 (make-cow 10  3)) ; at 10, moving left -> right
(define C2 (make-cow 20 -4)) ; at 20, moving left <- right

(@dd-template-rules compound) ;2 fields

#;
(define (fn-for-cow c)
  (... (cow-x c)    ;Natural
       (cow-dx c))) ;Integer



;; =================
;; Functions:

(@htdf main)
(@signature Cow -> Cow)
;; called to make the cow go for a walk; start with (main (make-cow 0 3))
;; no tests for main function

(@template-origin htdw-main)

(define (main c)
  (big-bang c
    (on-tick next-cow)       ; Cow -> Cow
    (to-draw render-cow)     ; Cow -> Image
    (on-key  handle-key)))   ; Cow KeyEvent -> Cow


(@htdf next-cow)
(@signature Cow -> Cow)
;; increase cow x by dx; when gets to edge, change dir and move off by 1
(check-expect (next-cow (make-cow 20           3))
              (make-cow (+ 20 3)  3))              ;away from edges
(check-expect (next-cow (make-cow 20          -3))
              (make-cow (- 20 3) -3))

(check-expect (next-cow (make-cow (- WIDTH 3)  3))
              (make-cow WIDTH     3))              ;reaches edge
(check-expect (next-cow (make-cow 3           -3))
              (make-cow 0        -3))

(check-expect (next-cow (make-cow (- WIDTH 2)  3))
              (make-cow WIDTH    -3))              ;tries to pass edge
(check-expect (next-cow (make-cow 2           -3))
              (make-cow 0         3)) 

;(define (next-cow c) c)      ;stub

(@template-origin Cow)

(@template
 (define (next-cow c)
   (... (cow-x c)
        (cow-dx c))))

(define (next-cow c)
  (cond [(> (+ (cow-x c) (cow-dx c)) WIDTH) (make-cow WIDTH (- (cow-dx c)))]
        [(< (+ (cow-x c) (cow-dx c)) 0)     (make-cow 0     (- (cow-dx c)))]
        [else
         (make-cow (+ (cow-x c) (cow-dx c))
                   (cow-dx c))]))


(@htdf render-cow)
(@signature Cow -> Image)
;; place appropriate cow image on MTS at (cow-x c) and CTR-Y
(check-expect (render-cow (make-cow 99 3))
              (place-image RCOW 99 CTR-Y MTS))
(check-expect (render-cow (make-cow 33 -3))
              (place-image LCOW 33 CTR-Y MTS))

;(define (render-cow c) MTS)  ;stub

(@template-origin Cow)

(@template
 (define (render-cow c)
   (... (cow-x c)
        (cow-dx c))))

(define (render-cow c)  
  (place-image (choose-image c) (cow-x c) CTR-Y MTS))


(@htdf choose-image)
(@signature Cow -> Image)
;; produce RCOW or LCOW depending on direction cow is going; LCOW if dx = 0
(check-expect (choose-image (make-cow 10  3)) RCOW)
(check-expect (choose-image (make-cow 11 -3)) LCOW)
(check-expect (choose-image (make-cow 11  0)) LCOW)

;(define (choose-image c) RCOW) ;stub

(@template-origin Cow)

(@template
 (define (choose-image c)
   (... (cow-x c)
        (cow-dx c))))

(define (choose-image c)
  (if (> (cow-dx c) 0)
      RCOW
      LCOW))
  

(@htdf handle-key)
(@signature Cow KeyEvent -> Cow)
;; reverse direction of cow travel when space bar is pressed
(check-expect (handle-key (make-cow (/ WIDTH 2) -3) " ")
              (make-cow (/ WIDTH 2) 3))
(check-expect (handle-key (make-cow (/ WIDTH 2) 3) " ")
              (make-cow (/ WIDTH 2) -3))
(check-expect (handle-key (make-cow (/ WIDTH 2) 3) "a")
              (make-cow (/ WIDTH 2) 3))

;(define (handle-key c ke) (make-cow 100 -5)) ;stub

(@template-origin KeyEvent)

(@template   
 (define (handle-key c ke)
   (cond [(key=? ke " ") (... c)]
         [else 
          (... c)])))

(define (handle-key c ke)
  (cond [(key=? ke " ") 
         (make-cow (cow-x c)
                   (- (cow-dx c)))]
        [else c]))


