;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname student-solution) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require spd/tags)

(@assignment bank/compound-p3)
(@cwl ???)

;; =================
;; Data definitions:

(@problem 1)
;; Design a data definition to help a teacher organize their next field trip. 
;; On the trip, lunch must be provided for all students. For each student, track
;; their name, their grade (from 1 to 12), and whether or not they have
;; allergies.

(@htdd Student)
(define-struct student (name grade allergies?))
;; Student is (make-student String Natural Boolean)
;; interp. a student with a name, grade (restricted to [1, 12]),
;;         and true if they have allergies
(define S1 (make-student "Bob" 2 true))
(define S2 (make-student "Hannah" 5 false))

(@dd-template-rules compound) ;3 fields

#;
(define (fn-for-student s)
  (... (student-name s)         ;String
       (student-grade s)        ;Natural
       (student-allergies? s))) ;Boolean



;; =================
;; Functions:

(@problem 2)
;; To plan for the field trip, if students are in grade 6 or below, the teacher 
;; is responsible for keeping track of their allergies. If a student has
;; allergies, and is in a qualifying grade, their name should be added to a
;; special list. Design a function to produce true if a student name should be
;; added to this list.


(@htdf track-allergies?)
(@signature Student -> Boolean)
;; produce true if the given student is at or below grade 6 and has allergies
(check-expect (track-allergies? (make-student "Ari" 5 true)) true)
(check-expect (track-allergies? (make-student "Azi" 6 true)) true)
(check-expect (track-allergies? (make-student "Ali" 7 true)) false)
(check-expect (track-allergies? (make-student "Ari" 5 false)) false)
(check-expect (track-allergies? (make-student "Azi" 6 false)) false)
(check-expect (track-allergies? (make-student "Ali" 7 false)) false)

;(define (track-allergies? s) true)   ; stub

(@template-origin Student)

(@template
 (define (track-allergies? s)
   (... (student-name s)
        (student-grade s) 
        (student-allergies? s))))

(define (track-allergies? s)
  (and (<= (student-grade s) 6)
       (student-allergies? s)))
