;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname m06-clickers) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require spd/tags)
(require 2htdp/image)













;; QUESTION [30 seconds]
;;
;; I spent this many hours preparing for the midterm:
;; 
;; A. more than 15
;; B. 10 to 15
;; C.  7 to 10
;; D.  3 to 7
;; E. less than 3









;; QUESTION [20 seconds]
;; 
;; I thought the midterm was:
;; 
;; A. much harder than expected
;; B.      harder than expected
;; C. about as hard as expected
;; D.      easier than expected
;; E. much easier than expected
;;













;; QUESTION [45 seconds]
;;
;; Which of the following is equivalent to 
;;
;; (cons 3 (cons 2 (cons 1 empty)))
;; 
;; A. (list 3 (list 2 (list 1)))
;; B. (list 3 2 1)
;; C. (list 3 2 1 empty)






















;; QUESTION [45 seconds]
;; 
;; Given the variable definition
;; 
;; (define L1 (list 3 2 1))
;; 
;; What is the value of the following expression?
;; 
;; (append (list 1 2) L1)
;; 
;;  A. (list 1 2 3 2 1)
;;  B. (list (list 1 2) (list 3 2 1))
;;  C. (list (list 1 2) 3 2 1)




















;; QUESTION [30 seconds]
;; 
;; Given the variable definition
;; 
;; (define L1 (list 3 2 1));
;; 
;; What is the value of the following expression?
;; 
;; (cons 0 L1)
;; 
;;  A. (list 3 2 1 0)
;;  B. (list 0 3 2 1)
;;  C. (list 0 (list 3 2 1)) 
;;  D. (list (list 0) (list 3 2 1))


;; THESE NEXT QUESTION WORK BEST WITH A DOCUMENT CAMERA


(@HtDD Region ListOfRegion)
(define-struct single (label weight color))
(define-struct group (color subs))
;; Region is one of:
;;  - (make-single String Natural Color)
;;  - (make-group Color ListOfRegion)
;; interp.
;;  an arbitrary-arity tree of regions
;;  single regions have label, weight and color
;;  groups have a color and a list of sub-regions
;;
;;  weight is a unitless number indicating how much weight
;;  the given single region contributes to whole tree

;; ListOfRegion is one of:
;;  - empty
;;  - (cons Region ListOfRegion)
;; interp. a list of regions



;; Question [90 seconds]
;;
;; How many arrows of any kind would you draw on the the type comments?
;;
;;  A: 1    B: 2    C: 3    D: 4     E: 5













;; Questions (three of them) [20 each]
;;
;; Is this arrow:
;;
;;  A: reference   B: self-reference   C: mutual reference































