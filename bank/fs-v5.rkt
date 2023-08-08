;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname fs-v5) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
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

;; The examples for the data definition model this tree:
;; https://cs110.students.cs.ubc.ca/bank/elt-tree.png

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

(@problem 1)
;; Design a function that consumes Element and produces the sum of all the file
;; data in the tree.


(@htdf sum-data)
(@signature Element -> Integer)
;; produce the sum of all the data in element (and its subs)
(check-expect (sum-data F1) 1)
(check-expect (sum-data D5) 3)
(check-expect (sum-data D4) (+ 1 2))
(check-expect (sum-data D6) (+ 1 2 3))

(@template-origin Element ListOfElement encapsulated)

; re-developed with encapsulated templates
(define (sum-data e)
  (local [(define (fn-for-element e)
            (+ (elt-data e)
               (fn-for-loe (elt-subs e))))
          
          (define (fn-for-loe loe)
            (cond [(empty? loe) 0]
                  [else
                   (+ (fn-for-element (first loe))
                      (fn-for-loe (rest loe)))]))]
    
    (fn-for-element e)))

#;
(define (sum-data e)
  (local [(define (sum-data--element e)
            (if (zero? (elt-data e))
                (sum-data--loe (elt-subs e))
                (elt-data e))) 
          
          (define (sum-data--loe loe)
            (cond [(empty? loe) 0]
                  [else
                   (+ (sum-data--element (first loe))
                      (sum-data--loe (rest loe)))]))]
    
    (sum-data--element e))) 


(@problem 2)
;; Design a function that consumes Element and produces a list of the names of
;; all the elements in the tree. 


(@htdf all-names)
(@signature Element -> ListOfString)
;; produce list of the names of all the elements in the tree
(check-expect (all-names F1) (list "F1"))
(check-expect (all-names D5) (list "D5" "F3"))
(check-expect (all-names D4) (list "D4" "F1" "F2"))
(check-expect (all-names D6) (list "D6" "D4" "F1" "F2" "D5" "F3"))
(check-expect (all-names D6)
              (cons "D6"  (append (list "D4" "F1" "F2") (list "D5" "F3"))))

;(define (all-names e) empty) ;stub

(@template-origin Element ListOfElement encapsulated)

(define (all-names e)
  (local [(define (all-names--element e)
            (cons (elt-name e)  
                  (all-names--loe (elt-subs e))))
          
          (define (all-names--loe loe)
            (cond [(empty? loe) empty]
                  [else
                   (append (all-names--element (first loe))
                           (all-names--loe (rest loe)))]))]
    
    (all-names--element e)))


(@problem 3)
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

(@template-origin Element ListOfElement encapsulated try-catch)

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


(@problem 4)
;; Design a function that consumes Element and produces a rendering of the tree.
;; For example: 
;;
;; (render-tree D6) should produce something like the following:
;; https://cs110.students.cs.ubc.ca/bank/elt-tree.png
;;
;; HINTS:
;;   - This function is not very different than the first two functions above.
;;   - Keep it simple! Start with a not very fancy rendering like the one above.
;;     Once that works you can make it more elaborate if you want to.
;;   - And... be sure to USE the recipe. Not just follow it, but let it help
;;     you.
;;     For example, work out a number of examples BEFORE you try to code the
;;     function.

