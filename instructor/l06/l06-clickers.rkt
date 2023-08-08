;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname l06-clickers) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #t)))


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

;; A. empty
;; B. (cons "e" empty)
;; C. "e"







































;; QUESTION [30 seconds]
;;
;; What is the result of (first (rest (rest L2)))?

(define L2 (cons "a" (cons "b" (cons "c" (cons "d" (cons "e" empty))))))

;; A. "a"
;; B. "b"
;; C. "c"
;; D. "d"
;; E. "e"



