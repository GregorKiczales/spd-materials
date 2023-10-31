;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname m08-abstract-fold-complications-starter) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #t)))
;; DO NOT PUT ANYTHING PERSONALLY IDENTIFYING BEYOND YOUR CWL IN THIS FILE.
;; YOUR CWLs WILL BE SUFFICIENT TO IDENTIFY YOU AND, IF YOU HAVE ONE, YOUR 
;; PARTNER.
;;
(require spd/tags)
(@assignment lectures/m08-abstract-fold-complications)
(@cwl ???) ;replace ??? with your cwl

(@problem 1)
(@htdd Course)
(define-struct course (number credits dependents))
;; Course is (make-course Natural Natural (listof Course))
;; interp. a course with a course number,
;;         the number of credits the course is worth,
;;         a list of courses that have this course as a pre-requisite

(define LOC0 empty)
(define C322 (make-course 322 3 LOC0))
(define C320 (make-course 320 3 LOC0))
(define C319 (make-course 319 4 LOC0))
(define C317 (make-course 317 3 LOC0))
(define C314 (make-course 314 3 LOC0))
(define C313 (make-course 313 3 LOC0))
(define C312 (make-course 312 3 LOC0))
(define C311 (make-course 311 3 LOC0))
(define LOC1 (list C319))
(define C310 (make-course 310 4 LOC1))
(define C304 (make-course 304 3 LOC0))
(define C302 (make-course 302 3 LOC0))
(define C303 (make-course 303 3 LOC0))
(define LOC2 (list C304 C313 C314 C317 C320 C322))
(define C221 (make-course 221 4 LOC2))
(define LOC3 (list C313 C317))
(define C213 (make-course 213 4 LOC3))
(define LOC4 (list C213 C221 C310 C311 C312))
(define C210 (make-course 210 4 LOC4))
(define C203 (make-course 203 3 LOC0))
(define C189 (make-course 189 1 LOC0))
(define LOC5 (list C189 C203 C210 C302 C303))
(define C110 (make-course 110 4 LOC5))
(define C100 (make-course 100 3 LOC0))

(@template-origin Course (listof Course) encapsulated)

(define (fn-for-course c0)
  (local [(define (fn-for-course c)
            (... (course-number c)
                 (course-credits c)
                 (fn-for-loc (course-dependents c))))

          (define (fn-for-loc loc)
            (cond [(empty? loc) (...)]
                  [else
                   (... (fn-for-course (first loc))
                        (fn-for-loc (rest loc)))]))]

    (fn-for-course c0)))




(@htdf fold-course)
(@signature (Natural Natural Y -> X) (X Y -> Y) Y Course -> X)
;; abstract fold for Course
(check-expect (fold-course make-course cons empty C110) C110)
(check-expect (local [(define (c1 n cr rmr) (add1 rmr))
                      (define (c2 rmr rnr) (+ rmr rnr))
                      (define b1 0)]
                (fold-course c1 c2 b1 C110))
              20)

(@template-origin Course (listof Course) encapsulated)

(define (fold-course c1 c2 b1 c0)
  (local [(define (fn-for-course c)  ;--> X
            (c1 (course-number c)
                (course-credits c)
                (fn-for-loc (course-dependents c))))

          (define (fn-for-loc loc)   ;--> Y
            (cond [(empty? loc) b1]
                  [else
                   (c2 (fn-for-course (first loc))
                       (fn-for-loc (rest loc)))]))]

    (fn-for-course c0)))



;;
;; Complete the design of the following function.
;;
;; NOTE: you are going to run into a problem doing it with the use-abstract-fn
;;       try to do that anyways so we can talk about the problem
;;
(@htdf courses-w-credits)
(@signature Course Natural -> (listof Course))
;; produce list of courses in tree that have >= credits
(check-expect (courses-w-credits C100 4) empty)
(check-expect (courses-w-credits C100 3) (list C100))
(check-expect (courses-w-credits C100 2) (list C100))
(check-expect (courses-w-credits C110 3)
              (list C110 C203 C210 C213 C313 C317 C221 C304 C313 C314 C317 C320
                    C322 C310 C319 C311 C312 C302 C303))

(define (courses-w-credits c n) empty)


(@problem 2)
;;
;; Design a function that takes two arguments: a Course and a Natural, in that
;; order. If found produce the number of credits that course has. Otherwise
;; fail.
;;

(@htdf find-w-credits)
(@signature Course Natural -> Natural or false)
;; produce course number of first course w/ given number of credits; or fail
(check-expect (find-w-credits C189 1) 189)
(check-expect (find-w-credits C189 4) false)
(check-expect (find-w-credits C110 3) 203)
(check-expect (find-w-credits C110 5) false)


;;
;; This approach produces the correct answer with the fold function, but
;; does it really meet the purpose of the function?
;;
(@template-origin use-abstract-fn)

(define (find-w-credits c0 n)
  (local [(define (c1 num creds rmr)
            (if (= creds n)
                num
                rmr))
          (define (c2 rmr rnr)
            (if (not (false? rmr))
                rmr
                rnr))]

    (fold-course c1 c2 false c0)))
