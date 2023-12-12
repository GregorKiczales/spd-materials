;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname f-p2-starter) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #t #t none #f () #f)))
;; DO NOT PUT ANYTHING PERSONALLY IDENTIFYING BEYOND YOUR CWL IN THIS FILE.
(require spd/tags)
(require 2htdp/image)

(@assignment bank/max-of-mins)

(@cwl ???)

(@problem 1)


#|

Complete the design of the function below by writing the template origin tag
and the function definition.

You will probably find it useful to use the max and min primitive functions
which work as follows:

(max a b)  produces larger of a and b
(min a b)  produces smaller of a and b

 - The function definition MUST call one or more built-in abstract functions.

 - You must define a single top-level function with the given name. You are
   permitted to define helpers, but they must be defined within the the
   top-level function using local.

 - The function definition and any helper functions you design MUST NOT be
   recursive.

 - The result of the function must directly be the result of one of the
   built-in abstract functions. So, for example, the following would not
   be a valid function body:

       (define (foo x)
         (empty? (filter ...)))

   This would be a valid function body:

       (define (foo x)
         (local [(define (helper y) (foldr ... ... ...))]
           (helper ...)))

|#

(@htdf max-of-mins)
(@signature (listof (listof Natural)) -> Natural)
;; produce the largest among the smallest element of each sublist
;; CONSTRAINT: lolon and every sublist must have at least one element
(check-expect (max-of-mins (list (list 2))) 2)
(check-expect (max-of-mins (list (list 3 2 6)
                                 (list 2 40 2 7)
                                 (list 30 20 10)))
              10)

;; *** Must not edit any line above here. ***

(define (max-of-mins lolon) 0)

