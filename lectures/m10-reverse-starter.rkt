;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname m10-find-path-starter) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #t)))
(require spd/tags)
(@assignment lectures/m10-reverse)
(@cwl ???) ;replace ??? with your cwl


(@problem 1)

;;
;; Consider this silly little function - all it does is to copy its argument.
;;
(@signature (listof X) -> (listof X))

(check-expect (rev empty) empty)
(check-expect (rev (list 1)) (list 1))
(check-expect (copy (list 1 2 3)) (list 1 2 3))

(@template-origin (listof X))

(define (copy lox)
  (cond [(empty? lox) empty]                ;base is empty
        [else
         (cons (first lox)                  ;combination is cons
               (copy (rest lox)))]))

;;
;; Is it tail recursive?
;;
;; Let's try to make it tail recursive by adding an rsf accummulator
;; and pushing the combination into an argument to the function.
;;
;; We'll call it rev, for reasons that will become apparent.
;;
;;
;; You MUST NOT rename the locally defined template function.
;;
(@htdf rev)

(@signature (listof X) -> (listof X))

(check-expect (rev (list "a" "b" "c")) (list "c" "b" "a"))

(@template-origin (listof X) accumulator)

(define (rev lox0)
  ;; don't forget the accumulator type and invariant as well
  ;; as examples here!
  (local [(define (fn-for-lox lox rsf)
            (cond [(empty? lox) (... rsf)]
                  [else
                   (... rsf
                        (first lox)
                        (fn-for-lox (rest lox) ...rsf))]))]
    
    (fn-for-lox lox0 ...)))



(check-expect (foldr cons empty (list 1 2 3)) (list 1 2 3))

;recursive call is (cons 1 (foldr cons empty (list 2 3))

(check-expect (foldl cons empty (list 1 2 3)) (list 3 2 1))

;recursive call is (foldl cons (cons 1 empty) (list 2 3))

;foldl is tail recursive fold, fn operates on leftmost value first


