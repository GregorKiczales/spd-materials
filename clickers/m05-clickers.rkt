;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname m05-clickers) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require spd/tags)
(require 2htdp/image)


;; QUESTION [30 seconds]
;;
;; I understand that during the midterm no questions at all will be
;; answered. None. Zero. No questions. I will read the midterm exam
;; instructions posted to Piazza later today, and ask any questions
;; I have before the exam.
;;
;; A. Yes
;; B. No, I will not read the instructions today even though it
;;    might cause me to fail the midterm.


















;; QUESTION [45 seconds]
;;
;; Given the following type comments:

(@htdd Cat)
;; Cat is Number
;; interp. x position of cat in screen coordinates


(@htdd ListOfCat)
;; ListOfCat is one of:
;;  - empty
;;  - (cons Cat ListOfCat)
;; interp. a list of cats


;; the arrow labeled B is a:

;; A. Self-reference.
;; B. Natural recursion.
;; C. Reference.
;; D. Natural helper.













;; QUESTION [60 seconds]
;;
;; Given the following data definition, 


(@htdd Natural)
;; Natural is one of:
;;  - 0
;;  - (add1 Natural)
;; interp. a natural number
(define N0 0)         ;0
(define N1 (add1 N0)) ;1
(define N2 (add1 N1)) ;2

(@dd-template-rules one-of           ;2 cases
                    atomic-distinct  ;0
                    compound         ;(add1 Natural)
                    self-reference)  ;(sub1 n) is Natural

(define (fn-for-natural n)
  (cond [(zero? n) (...)]
        [else
         (... ;n                       ;template rules would not normally
                                       ;put this here, but we will see that
                                       ;we would otherwise almost always end
                                       ;up having to add it
          (fn-for-natural (sub1 n)))]))

;; Natural is a well-formed self-referential data definition because:

;; A. It has a base case.
;; B. It has a self-referential case.
;; C. It has a base case and a self-referential case.
;; D. It uses add1.





;; QUESTION [30 seconds]
;; 
;; A self-referential data definition for natural numbers makes sense because:
;;
;; A. Zero is the base case.
;; B. It's easy to create example data.
;; C. There are an arbitrary number of natural numbers.





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























