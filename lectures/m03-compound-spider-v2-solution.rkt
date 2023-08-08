;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname m03-compound-spider-v2) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #t)))
(require 2htdp/image)
(require 2htdp/universe)
(require spd/tags)
(@assignment lectures/m03-compound-spider)

;; Spider, goes up/down screen with thread, changes, and wiggles


(@htdw Spider)

;; =================
;; Constants:

(define WIDTH 400)
(define HEIGHT 600)

(define CTR-X (/ WIDTH 2))

(define SPIDER-RADIUS 25)

(define SPIDER-WIGGLE 3)

(define TOP (+ 0        SPIDER-RADIUS))
(define BOT (- HEIGHT 1 SPIDER-RADIUS))

(define MID (/ HEIGHT 2))


(define SPIDER-IMAGE
  (rotate (/ 360 16)
          (radial-star 8 SPIDER-RADIUS (/ SPIDER-RADIUS 5) "solid" "black")))

(define LW-SPIDER-IMAGE (rotate (* -1 SPIDER-WIGGLE) SPIDER-IMAGE))
(define RW-SPIDER-IMAGE (rotate (*  1 SPIDER-WIGGLE) SPIDER-IMAGE))

(define MTS (empty-scene WIDTH HEIGHT))


;; =================
;; Data definitions:
(@problem 1)
(@htdd Spider)
(define-struct spider (y dy lw?))
;; Spider is (make-spider Number Number Boolean)
;; interp. y   is spider's vertical position in screen coordinates (pixels)
;;         dy  is velocity in pixels per tick, + is down, - is up
;;         lw? is true if left wiggle, false if right
;; CONSTRAINT: to be visible, must be in
;;             [TOP, BOT] which is [SPIDER-RADIUS, HEIGHT - SPIDER-RADIUS]
(define S-TOP-D (make-spider TOP  3 true))   ;top going down
(define S-MID-D (make-spider MID  3 false))  ;middle going down
(define S-MID-U (make-spider MID -3 true))   ;middle going up
(define S-BOT-U (make-spider BOT -3 true))   ;bottom going up


(@dd-template-rules compound);2 fields

(define (fn-for-spider s)
  (... (spider-y s)
       (spider-dy s)
       (spider-lw? s)))


;; =================
;; Functions:

(@htdf main)
(@signature Spider -> Spider) 
;; start the world with (main S-TOP-D)
;; no tests for htdw-main template

(@template-origin htdw-main)

;; no @template for htdw-main template

(define (main s)
  (big-bang s                    ; Spider
    (on-tick   tock)             ; Spider -> Spider
    (to-draw   render)           ; Spider -> Image
    (on-key    reverse-spider))) ; Spider KeyEvent -> Spider


(@htdf tock)
(@signature Spider -> Spider)
;; move spider by dy, change dir at bottom and top edges, flip lw?

;; don't hit boundaries
(check-expect (tock S-MID-D)
              (make-spider (+ (spider-y S-MID-D) (spider-dy S-MID-D))
                           (spider-dy S-MID-D)
                           true))
(check-expect (tock S-MID-U)
              (make-spider (+ (spider-y S-MID-U) (spider-dy S-MID-U))
                           (spider-dy S-MID-U)
                           false))
;; top edge
(check-expect
 (tock (make-spider (+ TOP 3) -2 true)) (make-spider (+ TOP 1) -2 false))
(check-expect
 (tock (make-spider (+ TOP 3) -3 false)) (make-spider    TOP     3 true))
(check-expect
 (tock (make-spider (+ TOP 3) -4 true)) (make-spider    TOP     4 false))

;; bottom edge
(check-expect
 (tock (make-spider (- BOT 3) 2 true))  (make-spider (- BOT 1)  2 false))
(check-expect
 (tock (make-spider (- BOT 3) 3 false))  (make-spider    BOT    -3 true))
(check-expect
 (tock (make-spider (- BOT 3) 4 true))  (make-spider    BOT    -4 false))

;(define (tock s) s) ;stub

(@template-origin Spider)

(@template
 (define (tock s)
   (... (spider-y s)
        (spider-dy s))))

(define (tock s)
  (cond [(<= (+ (spider-y s) (spider-dy s)) TOP)
         (make-spider TOP
                      (- (spider-dy s))
                      (not (spider-lw? s)))]
        [(>= (+ (spider-y s) (spider-dy s)) BOT)
         (make-spider BOT
                      (- (spider-dy s))
                      (not (spider-lw? s)))]
        [else
         (make-spider (+ (spider-y s) (spider-dy s))
                      (spider-dy s)
                      (not (spider-lw? s)))]))
        

(@htdf render)
(@signature Spider -> Image) 
;; place LW/RW-SPIDER-IMAGE and thread on MTS, at spider's y coordinate
(check-expect (render S-MID-D)
              (add-line
               (place-image RW-SPIDER-IMAGE CTR-X (spider-y S-MID-D) MTS)
               CTR-X 0
               CTR-X (spider-y S-MID-D)
               "black"))

(check-expect (render (make-spider 36 -10 true))
              (add-line (place-image LW-SPIDER-IMAGE CTR-X 36 MTS)
                        CTR-X 0
                        CTR-X 36
                        "black"))

;(define (render s) MTS)

(@template-origin Spider)

(@template
 (define (render s)
   (... (spider-y s)
        (spider-dy s))))
  
(define (render s)
  (add-line (place-image (if (spider-lw? s) LW-SPIDER-IMAGE RW-SPIDER-IMAGE)
                         CTR-X
                         (spider-y s)
                         MTS)
            CTR-X 0
            CTR-X (spider-y s)
            "black"))


(@htdf reverse-spider)
(@signature Spider KeyEvent -> Spider)
;; change direction of spider on space, unchanged for other keys
(check-expect (reverse-spider (make-spider 100  2 true) " ")
              (make-spider 100 -2 true))
(check-expect (reverse-spider (make-spider 200 -3 false) " ")
              (make-spider 200  3 false))
(check-expect (reverse-spider (make-spider 100  2 true) "a")
              (make-spider 100  2 true))

;(define (reverse-spider s ke) s)

(@template-origin KeyEvent ;using large enumeration rule
                  Spider)  ;to get Spider selectors in cond answer

(@template 
 (define (reverse-spider s ke)
  (cond [(key=? ke " ") (... (spider-y s) (spider-dy s))]
        [else (... (spider-y s) (spider-dy s))])))

(define (reverse-spider s ke)
  (cond [(key=? ke " ")
         (make-spider (spider-y s) (- (spider-dy s)) (spider-lw? s))]
        [else s]))
