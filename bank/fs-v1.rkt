;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname fs-v1) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/image)
(require spd/tags)

(@assignment bank/mutual-ref-l1)
(@cwl ???)

;; fs-starter.rkt (type comments and examples)
;; fs-v1.rkt (complete data-definition plus function problems)

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
  (... (elt-name e)    ;String
       (elt-data e)    ;Integer
       (fn-for-loe (elt-subs e))))

#;
(define (fn-for-loe loe)
  (cond [(empty? loe) (...)]
        [else
         (... (fn-for-element (first loe))
              (fn-for-loe (rest loe)))])) 


;; Functions:

(@problem 1)
;; Design a function that consumes Element and produces the sum of all the file
;; data in the tree.


(@problem 2)
;; Design a function that consumes Element and produces a list of the names of
;; all the elements in the tree.


(@problem 3)
;; Design a function that consumes String and Element and looks for a data
;; element with the given name. If it finds that element it produces the data,
;; otherwise it produces false.


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





