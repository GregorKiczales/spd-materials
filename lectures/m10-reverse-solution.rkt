;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname m10-reverse-solution) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #t)))
(require spd/tags)
(@assignment lectures/m10-reverse)
(@cwl ???) ;replace ??? with your cwl


(@problem 1)


(@htdf rev)

(@signature (listof X) -> (listof X))
;; produce list of same elements in the opposite order
(check-expect (rev empty) empty)
(check-expect (rev (list 1)) (list 1))
(check-expect (rev (list "a" "b" "c")) (list "c" "b" "a"))

(@template-origin encapsulated (listof X)
           accumulator)

(define (rev lox0)
  ;; rsf is (listof X)
  ;; all elements of lox0 before (first lox), in reverse order
  (local [(define (fn-for-lox lox rsf)
            (cond [(empty? lox) rsf]
                  [else
                   ;;
                   ;; For a function operating on a list (a fn based on the
                   ;; (listof X) template), and the "regular" version has a
                   ;; combination position that somehow operates on the
                   ;; result of the natural recursion. For example:
                   ;;
                   ;;  (append (fn-for-lox (rest lox)) (list (first lox)))
                   ;;
                   ;; or in general:
                   ;;
                   ;;  (c...1 (first lox) (fn-for-lox (rest lox)))
                   ;;
                   ;; then the way to make the function tail recursive
                   ;; is to:
                   ;;   - start with the (listof X) template
                   ;;   - add a result so far accumulator template to that
                   ;;   - and refactor the natural recursion to:
                   ;;
                   ;;   (fn-for-lox (rest lox) (c...2 (first lox) rsf))
                   ;;
                   ;; or in this particular case:
                   ;;
                   ;;   (fn-for-lox (rest lox) (cons (first lox) rsf))
                   ;;
                   ;; NOTE: ask yourself under what circumstances both
                   ;;       combinations c...1 and c...2 are the same.
                   ;;
                   (fn-for-lox (rest lox) (cons (first lox) rsf))]))]
    
    (fn-for-lox lox0 empty)))
