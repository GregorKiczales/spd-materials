;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname fs-v6) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/image)
(require spd/tags)

(@assignment bank/local-l1)
(@cwl ???)

;; fs-starter.rkt (type comments and examples)
;; fs-v1.rkt (complete data-definition plus function problems)
;; fs-v2.rkt (complete data-definition and sum-data function)
;; fs-v3.rkt (complete data-definition, sum-data function, all-names function)
;; fs-v4.rkt (complete data-definition, sum-data, all-names and find functions)
;; fs-v5.rkt (data-definition, encapsulated template, encapsulated functions)

;; Data definitions:

(@htdd Element ListOfElement)
(define-struct elt (name data subs))
;; Element is (make-elt String Integer ListOfElement)
;; interp. An element in the file system, with name, and EITHER data or subs.
;;         If data is 0, then subs is considered to be list of sub elements.
;;         If data is not 0, then subs is ignored.

;; ListOfElement is one of:
;;  - empty
;;  - (cons Element ListOfElement)
;; interp. A list of file system Elements

(define F1 (make-elt "F1" 1 empty))
(define F2 (make-elt "F2" 2 empty))
(define F3 (make-elt "F3" 3 empty))
(define D4 (make-elt "D4" 0 (list F1 F2)))
(define D5 (make-elt "D5" 0 (list F3)))
(define D6 (make-elt "D6" 0 (list D4 D5)))

#;
(define (fn-for-element e)
  (local [(define (fn-for-element e)
            (... (elt-name e)    ;String
                 (elt-data e)    ;Integer
                 (fn-for-loe (elt-subs e))))
          
          (define (fn-for-loe loe)
            (cond [(empty? loe) (...)]
                  [else
                   (... (fn-for-element (first loe))
                        (fn-for-loe (rest loe)))]))]
    
    (fn-for-element e)))


;; Functions:


(@htdf make-skinny)
(@signature Natural -> Element)
;; produce a skinny tree n+1 deep, leaf has name "Y" data 1
(check-expect (make-skinny 0) (make-elt "Y" 1 empty))
(check-expect (make-skinny 2)
              (make-elt "X" 0
                        (list (make-elt "X" 0 (list (make-elt "Y" 1 empty))))))

(define (make-skinny n)
  (cond [(zero? n) (make-elt "Y" 1 empty)]
        [else
         (make-elt "X" 0 (list (make-skinny (sub1 n))))]))


(@problem 1)
;; Design a function that consumes String and Element and looks for a data
;; element with the given name. If it finds that element it produces the data,
;; otherwise it produces false.


(@htdf find)
(@signature String Element -> Integer or false)
;; search given tree for elt with given name, produce data if found; else false
(check-expect (find "F3" F1) false)
(check-expect (find "F3" F3) 3)
(check-expect (find "D4" D4) 0)
(check-expect (find "D6" D6) 0)
(check-expect (find "F3" D4) false)
(check-expect (find "F1" D4) 1)
(check-expect (find "F2" D4) 2)
(check-expect (find "F1" D6) 1)
(check-expect (find "F3" D6) 3)

;(define (find n e) false) ;stubs

(@template-origin Element ListOfElement try-catch encapsulated)

(define (find n e)
  (local [(define (find--element n e)
            (if (string=? (elt-name e) n)
                (elt-data e) 
                (find--loe n (elt-subs e))))
          
          (define (find--loe n loe)
            (cond [(empty? loe) false]
                  [else
                     (if (not (false? (find--element n (first loe)))) 
                         (find--element n (first loe))
                         (find--loe n (rest loe)))]))]
    
    (find--element n e)))



(time (find "Y" (make-skinny 10)))
(time (find "Y" (make-skinny 11)))
(time (find "Y" (make-skinny 12)))
(time (find "Y" (make-skinny 13)))
(time (find "Y" (make-skinny 14)))
(time (find "Y" (make-skinny 15)))


