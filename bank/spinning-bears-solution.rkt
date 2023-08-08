;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname spinning-bears-solution) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/image)
(require 2htdp/universe)
(require spd/tags)

(@assignment bank/ref-p2)
(@cwl ???)

(@problem 1)
;; In this problem you will design another world program. In this program the
;; changing information will be more complex - your type definitions will
;; involve arbitrary sized data as well as the reference rule and compound data.
;; But by doing your design in two phases you will be able to manage this 
;; complexity. As a whole, this problem will represent an excellent summary of 
;; the material covered so far in the course, and world programs in particular.
;;
;; This world is about spinning bears. The world will start with an empty 
;; screen. Clicking anywhere on the screen will cause a bear to appear at that
;; spot. The bear starts out upright, but then rotates counterclockwise at a 
;; constant speed. Each time the mouse is clicked on the screen, a new upright
;; bear appears and starts spinning.
;;
;; So each bear has its own x and y position, as well as its angle of rotation.
;; And there are an arbitrary amount of bears.
;;
;; To start, design a world that has only one spinning bear. Initially, the 
;; world will start with one bear spinning in the center at the screen. Clicking
;; the mouse at a spot on the world will replace the old bear with a new bear at
;; the new spot. You can do this part with only material up through compound.
;;
;; Once this is working you should expand the program to include an arbitrary
;; number of bears.
;;
;; Here is an image of a bear for you to use:
;;
;; https://cs110.students.cs.ubc.ca/bank/bear-img.png


;; Spinning Bears

(@htdw Bear)

;; =================
;; Constants:

(define WIDTH 600) ; width of the scene
(define HEIGHT 700) ; height of the scene

(define SPEED 3)  ; speed of rotation

(define MTS (empty-scene WIDTH HEIGHT)) ; the empty scene

(define BEAR-IMG
  (bitmap/url
   "https://cs110.students.cs.ubc.ca/bank/bear-img.png"))



;; =================
;; Data definitions:

(@htdd Bear)
(define-struct bear (x y r))
;; Bear is (make-bear Number Number Integer)
;; interp. (make-bear x y r) is the state of a bear, where
;;          x is the x coordinate in pixels, restricted to [0,WIDTH]
;;          y is the y coordinate in pixels, restricted to [0,HEIGHT]
;;          r is the angle of rotation in degrees
(define B1 (make-bear 0 0 0))                       ; bear in upper left corner
(define B2 (make-bear (/ WIDTH 2) (/ HEIGHT 2) 90)) ; sideways bear in middle

(@dd-template-rules compound) ;3 fields

#;
(define (fn-for-bear b)
  (... (bear-x b)     ; Number
       (bear-y b)     ; Number
       (bear-r b)))   ; Integer


(@htdd ListOfBear)
;; ListOfBear is one of:
;; - empty
;; - (cons Bear ListOfBear)
;; interp. a list of bears
(define LB0 empty)
(define LB1 (cons B1 empty))
(define LB2 (cons B1 (cons B2 empty)))

(@dd-template-rules one-of           ;2 cases
                    atomic-distinct  ;empty
                    compound         ;(cons Bear ListofBear)
                    ref              ;(first lob) is Bear
                    self-ref)        ;(rest lob) is ListOfBear

#;
(define (fn-for-lob lob)
  (cond [(empty? lob) (...)]
        [else 
         (... (fn-for-bear (first lob))
              (fn-for-lob (rest lob)))]))



;; =================
;; Functions:

(@htdf main)
(@signature ListOfBear -> ListOfBear)
;; start the world with (main empty)

(@template-origin htdw-main)

(define (main lob)
  (big-bang lob                 ; ListOfBear
    (on-tick   spin-bears)      ; ListOfBear -> ListOfBear
    (to-draw   render-bears)    ; ListOfBear -> Image
    (on-mouse  handle-mouse)))  ; ListOfBear Integer Integer
; MouseEvent -> ListOfBear


(@htdf spin-bears)
(@signature ListOfBear -> ListOfBear)
;; spin all of the bears forward by SPEED degrees
(check-expect (spin-bears empty) empty)
(check-expect (spin-bears 
               (cons (make-bear 0 0 0) empty))
              (cons (make-bear 0 0 (+ 0 SPEED)) empty))
(check-expect (spin-bears 
               (cons (make-bear 0 0 0)
                     (cons (make-bear (/ WIDTH 2) (/ HEIGHT 2) 90) 
                           empty)))
              (cons (make-bear 0 0 (+ 0 SPEED))
                    (cons (make-bear (/ WIDTH 2) (/ HEIGHT 2) (+ 90 SPEED))
                          empty)))               

;(define (spin-bears lob) empty)

(@template-origin ListOfBear)

(@template
 (define (spin-bears lob)
   (cond [(empty? lob) (...)]
         [else 
          (... (fn-for-bear (first lob))
               (spin-bears (rest lob)))])))

(define (spin-bears lob)
  (cond [(empty? lob) empty]
        [else
         (cons (spin-bear (first lob))
               (spin-bears (rest lob)))]))


(@htdf spin-bear)
(@signature Bear -> Bear)
;; spin a bear forward by SPEED degrees
(check-expect (spin-bear (make-bear 0 0 0)) (make-bear 0 0 (+ 0 SPEED)))
(check-expect (spin-bear (make-bear (/ WIDTH 2) (/ HEIGHT 2) 90)) 
              (make-bear (/ WIDTH 2) (/ HEIGHT 2) (+ 90 SPEED)))

;(define (spin-bear b) b)

(@template-origin Bear)

(@template
 (define (spin-bear b)
   (... (bear-x b) 
        (bear-y b) 
        (bear-r b))))

(define (spin-bear b)
  (make-bear (bear-x b)
             (bear-y b)
             (+ (bear-r b) SPEED)))


(@htdf render-bears)
(@signature ListOfBear -> Image)
;; render the bears onto the empty scene
(check-expect (render-bears empty) MTS)
(check-expect (render-bears (cons (make-bear 0 0 0) empty))
              (place-image (rotate 0 BEAR-IMG) 0 0 MTS))
(check-expect (render-bears 
               (cons (make-bear 0 0 0)
                     (cons (make-bear (/ WIDTH 2) (/ HEIGHT 2) 90) 
                           empty)))
              (place-image (rotate 0 BEAR-IMG) 0 0 
                           (place-image (rotate 90 BEAR-IMG)
                                        (/ WIDTH 2)
                                        (/ HEIGHT 2)
                                        MTS)))

;(define (render-bears lob) MTS)

(@template-origin ListOfBear)

(@template
 (define (render-bears lob)
   (cond [(empty? lob) (...)]
         [else 
          (... (fn-for-bear (first lob))
               (render-bears (rest lob)))])))

(define (render-bears lob)
  (cond [(empty? lob) MTS]
        [else 
         (render-bear-on (first lob) (render-bears (rest lob)))]))


(@htdf render-bear-on)
(@signature Bear Image -> Image)
;; render an image of the bear on the given image
(check-expect (render-bear-on (make-bear 0 0 0) MTS)
              (place-image (rotate 0 BEAR-IMG) 0 0 MTS))
(check-expect (render-bear-on (make-bear (/ WIDTH 2) (/ HEIGHT 2) 90) MTS)
              (place-image (rotate 90 BEAR-IMG) (/ WIDTH 2) (/ HEIGHT 2) MTS))

;(define (render-bear-on b img) MTS)

(@template-origin Bear)

(@template
 (define (render-bear-on b img)
   (... (bear-x b) 
        (bear-y b) 
        (bear-r b)
        img)))

(define (render-bear-on b img)
  (place-image (rotate (modulo (bear-r b) 360) BEAR-IMG)
               (bear-x b)
               (bear-y b)
               img))


(@htdf handle-mouse)
(@signature ListOfBear Integer Integer MouseEvent -> ListOfBear)
;; On mouse-click, adds a bear with 0 rotation to the list at the x, y location
(check-expect (handle-mouse empty 5 4 "button-down")
              (cons (make-bear 5 4 0) empty))
(check-expect (handle-mouse empty 5 4 "move") empty)

;(define (handle-mouse lob x y mev) empty)

(@template-origin MouseEvent)

(@template
 (define (handle-mouse lob x y me)
   (cond [(mouse=? me "button-down") (... lob x y)]
         [else
          (... lob x y)])))

(define (handle-mouse lob x y mev)
  (cond [(mouse=? mev "button-down") (cons (make-bear x y 0) lob)]
        [else lob]))
