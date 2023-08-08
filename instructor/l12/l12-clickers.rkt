;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname l12-clickers) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))


































;; Question 1 [60 seconds]
;; 
;; What value does running this program produce?

(define s "summer")
(local [(define s "spring")
        (define (is-favourite? x)
          (string=? x s))]
   (is-favourite? "summer"))

;; A. true
;; B. false
 














;; Question 2 [60 seconds]
;; 
;; Consider the following expression. Which of the following 
;; is the correct first evaluation step? 

(local [(define x 3)
        (define (timesx y)
          (* x y))]
  (timesx 5))

;; A. (define x_0 3)
;;    (local [(define (timesx y)
;;              (* x_0 y))]
;;      (timesx 5))
  
;; B. (define x_0 3)
;;    (define (timesx_0 y)
;;      (* x_0 y))
;;    (timesx_0 5)
  
;; C. (define (timesx_0 y)
;;      (* 3 y))
;;    (timesx_0 5)






;; Question 3
;; 
;; When the following expression is evaluated how many times is the + primitive
;; called?

(local [(define a (+ 2 3))]
  (* a a))

;; A. 0
;; B. 1
;; C. 2
;; D. 3











;; Question 4
;; 
;; How many definitions are lifted when the following program is run?

(define (play-with-strings s t)
  (local [(define s2 (substring s 0 3))
          (define (t2 x) (string-append t x "turquoise"))
          (define s3 "purple")]
    (string-append s2 (t2 "white") s3)))

(string-append (play-with-strings "orange" "red")
               (play-with-strings "yellow" "green"))

;; A. 3
;; B. 2
;; C. 5
;; D. 6