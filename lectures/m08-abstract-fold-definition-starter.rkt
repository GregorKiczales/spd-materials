;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname m08-abstract-fold-definition-starter) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #t)))
;; DO NOT PUT ANYTHING PERSONALLY IDENTIFYING BEYOND YOUR CWL IN THIS FILE.
;; YOUR CWLs WILL BE SUFFICIENT TO IDENTIFY YOU AND, IF YOU HAVE ONE, YOUR 
;; PARTNER.
;;
(require spd/tags)
(@assignment lectures/m08-abstract-fold-definition)
(@cwl ???) ;replace ??? with your cwl

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

(define (fn-for-course c)
  (local [(define (fn-for-course c)
            (... (course-number c)
                 (course-credits c)
                 (fn-for-loc (course-dependents c))))

          (define (fn-for-loc loc)
            (cond [(empty? loc) (...)]
                  [else
                   (... (fn-for-course (first loc))
                        (fn-for-loc (rest loc)))]))]

    (fn-for-course c)))


(@problem 1)
;;
;; Design an abstract function called foldr2 based on the (listof X) template.
;; Work backwards through the HtDF recipe starting from the fn definition.
;;










(@template-origin ListOfNumber)

(define (fn-for-lox lox)
  (cond [(empty? lox) (...)]
        [else
         (... (first lox)
              (fn-for-lox (rest lox)))]))




(@problem 1)
#|

The first step in designing an abstract fold function is always the same -
copy the encapsulated templates, and add one parameter for each set of ...

By convention the parameters that stand for functions go first, the parameters
that stand for base values go after that, and the data always goes last. We
have done this first step for you below.

Complete the design of the following abstract fold function for Course.
Note that we have already given you the actual function definition and the
template tag. You must complete the design with a signature, purpose,
function definition and the two following check-expects:

  - uses the fold function to produce a copy of C110
  - uses the fold function to count the total number of courses,
    in the C110 tree, including C110


|#

(@htdf fold-course)





(@template-origin Course (listof Course) encapsulated)

(define (fold-course c1 c2 b1 c0)
  (local [(define (fn-for-course c)
            (c1 (course-number c)
                (course-credits c)
                (fn-for-loc (course-dependents c))))

          (define (fn-for-loc loc)
            (cond [(empty? loc) b1]
                  [else
                   (c2 (fn-for-course (first loc))
                       (fn-for-loc (rest loc)))]))]

    (fn-for-course c0)))

