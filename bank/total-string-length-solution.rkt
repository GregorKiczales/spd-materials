;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname total-string-length-solution) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require spd/tags)

(@assignment bank/self-ref-p1)
(@cwl ???)

;; =================
;; Data definitions:

;; Recall the data definition for a list of strings:
;; (if this data definition does not look familiar, please review it)


(@htdd ListOfString)
;; ListOfString is one of: 
;;  - empty
;;  - (cons String ListOfString)
;; interp. a list of strings
(define LS0 empty) 
(define LS1 (cons "a" empty))
(define LS2 (cons "a" (cons "b" empty)))
(define LS3 (cons "c" (cons "b" (cons "a" empty))))

(@dd-template-rules one-of               ;2 cases
                    atomic-distinct      ;empty
                    compound             ;(cons String ListOfString)
                    self-ref)            ;(rest los) is ListOfString

#;
(define (fn-for-los los) 
  (cond [(empty? los) (...)]
        [else
         (... (first los)
              (fn-for-los (rest los)))]))



;; =================
;; Functions:

(@problem 1)
;; Design a function that consumes a list of strings and determines the total 
;; number of characters (single letters) in the list. Call it
;; total-string-length.


(@htdf total-string-length)
(@signature ListOfString -> Natural)
;; calculates the total number of characters in the given list
(check-expect (total-string-length empty) 0)
(check-expect (total-string-length LS3) 3)
(check-expect (total-string-length (cons "function" (cons "design" empty))) 14)

;(define (total-string-length los) 0)  ;stub

(@template-origin ListOfString)

(@template
 (define (total-string-length los) 
   (cond [(empty? los) (...)]
         [else
          (... (first los)
               (total-string-length (rest los)))])))

(define (total-string-length los) 
  (cond [(empty? los) 0]
        [else
         (+ (string-length (first los))
            (total-string-length (rest los)))]))
