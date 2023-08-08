;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname trip-solution) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require spd/tags)

(@assignment bank/compound-p4)
(@cwl ???)

;; =================
;; Data definitions:

(@problem 1)
;; Design a data definition to help travellers plan their next trip. 
;; A trip should specify an origin, destination, mode of transport and 
;; duration (in days).


(@htdd Trip)
(define-struct trip (origin destination mot duration))
;; Trip is (make-trip String String String Natural)
;; interp. a trip with origin, destination, mode of transport,
;;         and duration in days

(define T1 (make-trip "Vancouver" "Cancun" "Flight" 10))
(define T2 (make-trip "Calgary" "Ottawa" "Car" 14))
(define T3 (make-trip "Montreal" "New York" "Flight" 5))

(@dd-template-rules compound) ;4 fields

#;
(define (fn-for-trip t)
  (... (trip-origin t)       ;String
       (trip-destination t)  ;String
       (trip-mot t)          ;String
       (trip-duration t)))   ;Natural



;; =================
;; Functions:

(@problem 2)
;; You have just found out that you have to use all your days off work 
;; on your next vacation before they expire at the end of the year. 
;; Comparing two options for a trip, you want to take the one that 
;; lasts the longest. Design a function that compares two trips and 
;; returns the trip with the longest duration.
;; 
;; Note that the rule for templating a function that consumes two 
;; compound data parameters is for the template to include all 
;; the selectors for both parameters.


(@htdf longer-trip)
(@signature Trip Trip -> Trip)
;; produce trip with longer duration, if durations are equal produce 2nd trip
(check-expect (longer-trip T2 T3) T2)
(check-expect (longer-trip T3 T1) T1)
(check-expect (longer-trip T3 (make-trip "Houston" "Dallas" "Car" 5))
              (make-trip "Houston" "Dallas" "Car" 5))

;(define (longer-trip t1 t2) T1)  ; stub

(@template-origin Trip)

(@template
 (define (fn-for-trip t1 t2)
   (... (trip-origin t1)
        (trip-destination t1)
        (trip-mot t1)
        (trip-duration t1)
        (trip-origin t2)
        (trip-destination t2)
        (trip-mot t2)
        (trip-duration t2))))

(define (longer-trip t1 t2)
  (if (> (trip-duration t1) (trip-duration t2))
      t1
      t2))
