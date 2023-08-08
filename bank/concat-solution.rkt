;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname concat-solution) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require spd/tags)

(@assignment bank/concat)
(@cwl ???)

(@problem 1)

;; =================
;; Data Definitions:

(@htdd ListOfString)
;; ListOfString is one of:
;;  - empty
;;  - (cons String ListOfString)
;; interp. a list of strings
(define LOS1 empty)
(define LOS2 (cons "a" (cons "b" empty)))



;; =================
;; Functions:

(@htdf concat)
(@signature ListOfString ListOfString -> ListOfString)
;; append the two lists
(check-expect (concat empty empty) empty)
(check-expect (concat empty (list "a")) (list "a"))
(check-expect (concat (list "a") empty) (list "a"))

(check-expect (concat (list "a" "b") (list "x" "y"))
              (list "a" "b" "x" "y"))

;(define (concat lsta lstb) empty)

(@template-origin 2-one-of)

#|
 CROSS PRODUCT OF TYPE COMMENTS TABLE      

   lsta     lstb        empty         (cons String LOS)

   empty                              lstb  (2)

                       lsta (1)                                 
   (cons String LOS)                  (cons (first a)              (3)
                                            (concat (rest a) b)) 
  
|#

(define (concat lsta lstb)
  (cond [(empty? lstb) lsta] ;(1)
        [(empty? lsta) lstb] ;(2)
        [else                ;(3)
         (cons (first lsta)
               (concat (rest lsta) lstb))]))
