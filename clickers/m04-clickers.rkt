;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname m04-clickers) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #t)))
(require spd/tags)

;; QUESTION [30 seconds]
;;
;; How many elements are in L1?

(define L1 (cons "a" (cons "b" (cons "c" empty))))

;; A. 2
;; B. 3
;; C. 4
;; D. 5



























;; QUESTION [30 seconds]
;;
;; What is the first element in L2?

(define L2 (cons "a" (cons "b" (cons "c" (cons "d" (cons "e" empty))))))

;; A. "a"
;; B. "b"
;; C. (cons "a" empty)
;; D. "eva"
;; E. "lu"

































;; QUESTION [30 seconds]
;;
;; What is the last element in L2?

(define L2 (cons "a" (cons "b" (cons "c" (cons "d" (cons "e" empty))))))

;; A. "e"
;; B. (cons "e" empty)
;; C. empty






























;; QUESTION [30 seconds]
;;
;; What is the result of (first (rest (rest L2)))?

(define L2 (cons "a" (cons "b" (cons "c" (cons "d" (cons "e" empty))))))

;; A. "a"
;; B. "b"
;; C. "c"
;; D. "d"
;; E. "e"



;; stop here for MWF

;; *** DEPENDING ON LECTURE FORMAT IT IS GOOD TO PUT THE CODE FOR THE NEXT ***
;; *** ON ONE PROJECTOR AND THE QUESTIONS ON ANOTHER                       ***


;; QUESTION [120 seconds]
;;
;; Given the following code:

;; Constants:
(define SPEED 10)

;; Data definitions:
(@htdd Ball)
(define-struct ball (x y))
;; Ball is (make-ball Integer Integer)
;; interp. a ball with screen coordinates

(define B1 (make-ball 10 20))

(@dd-template-rules compound) ;2 fields

(define (fn-for-ball b)
  (... (ball-x b)   ;Integer
       (ball-x b))) ;Integer

;; Functions:
(@htdf slide)
(@signature Ball -> Ball)
;; move ball down screen by SPEED
(check-expect (slide (make-ball 10 10))
              (make-ball 10 (+ 10 SPEED)))

;(define (slide b) b) ;stub

(@template-origin Ball)
(define (slide b)
  (make-ball (ball-x b)
             (+ (ball-x b) SPEED)))

;; The first error is (first means the one that appears
;; first in the program text):
;;
;; A. In the Constants.
;; B. In the type comment for Ball.
;; C. In the @dd-template-rules tag for Ball.
;; D. In the template for Ball.
;; E. In the @signature for slide.



;; QUESTION [30 seconds]
;;
;; Given the following code:

;; Constants:
(define SPEED 10)

;; Data definitions:
(@HtDD Ball)
(define-struct ball (x y))
;; Ball is (make-ball Integer Integer)
;; interp. a ball with screen coordinates

(define B1 (make-ball 10 20))

(@dd-template-rules compound) ;2 fields

(define (fn-for-ball b)
  (... (ball-x b)   ;Integer
       (ball-x b))) ;Integer

;; Functions:
(@HtDF slide)
(@signature Ball -> Ball)
;; move ball down screen by SPEED
(check-expect (slide (make-ball 10 10))
              (make-ball 10 (+ 10 SPEED)))

;(define (slide b) b) ;stub

(@template-origin Ball)
(define (slide b)
  (make-ball (ball-x b)
             (+ (ball-x b) SPEED)))

;; The second error is:
;;
;; A. In the @signature for slide.
;; B. In purpose for slide.
;; C. In the check-expects for slide.
;; D. In the @template-origin tag for slide.
;; E. In the function definition for slide.



;; QUESTION [20 seconds]
;;
;; Given the following code:

;; Constants:
(define SPEED 10)

;; Data definitions:
(@htdd Ball)
(define-struct ball (x y))
;; Ball is (make-ball Integer Integer)
;; interp. a ball with screen coordinates

(define B1 (make-ball 10 20))

(@dd-template-rules compound) ;2 fields

(define (fn-for-ball b)
  (... (ball-x b)   ;Integer
       (ball-x b))) ;Integer

;; Functions:
(@htdf slide)
(@signature Ball -> Ball)
;; move ball down screen by SPEED
(check-expect (slide (make-ball 10 10))
              (make-ball 10 (+ 10 SPEED)))

;(define (slide b) b) ;stub

(@template-origin Ball)
(define (slide b)
  (make-ball (ball-x b)
             (+ (ball-x b) SPEED)))

;; The third error is:
;;
;; A. In the @template-origin tag for slide.
;; B. In the function definition for slide.



;; ERRORS
;;
;; Template has ball-x twice
;; Only one test and test repeats 10
;; Function has ball-x twice
