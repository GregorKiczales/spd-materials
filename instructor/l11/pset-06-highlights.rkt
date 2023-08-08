;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname pset-06-highlights) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(define (fn-for-course c)
  (... (course-number c)
       (course-credits c)
       (fn-for-loc (course-dependents c))))

(define (fn-for-loc loc)
  (cond [(empty? loc) (...)]
        [else
         (... (fn-for-course (first loc))
              (fn-for-loc (rest loc)))]))




(@template Course)

(define (all-course-numbers--course c)
  (cons (course-number c)
        (all-course-numbers--loc (course-dependents c))))

(@template ListOfCourse)

(define (all-course-numbers--loc loc)
  (cond [(empty? loc) empty]
        [else
         (append (all-course-numbers--course (first loc))
                 (all-course-numbers--loc (rest loc)))]))




(@template Course)

(define (courses-w-credits--course c credits)
  (if (>= (course-credits c) credits)
      (cons c (courses-w-credits--loc (course-dependents c) credits))
      (courses-w-credits--loc (course-dependents c) credits)))

(@template ListOfCourse)

(define (courses-w-credits--loc loc credits)
  (cond [(empty? loc) empty]
        [else
         (append (courses-w-credits--course (first loc) credits)
                 (courses-w-credits--loc (rest loc) credits))]))



(@template Course)

(define (max-course-num--course c)
  (max (course-number c)
       (max-course-num--loc (course-dependents c))))

(@template ListOfCourse)

(define (max-course-num--loc loc)
  (cond [(empty? loc) 0]
        [else
         (max (max-course-num--course (first loc))
              (max-course-num--loc (rest loc)))]))




(@template Course backtracking)

(define (find-course--course c course-num)
  (if (= (course-number c) course-num)
      c
      (find-course--loc (course-dependents c) course-num)))

(@template ListOfCourse backtracking)

(define (find-course--loc loc course-num)
  (cond [(empty? loc) false]
        [else
         (if (not (false? (find-course--course (first loc) course-num)))
             (find-course--course (first loc) course-num)
             (find-course--loc (rest loc) course-num))]))
