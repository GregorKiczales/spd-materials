;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname movie-solution) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require spd/tags)

(@assignment bank/compound-p1)
(@cwl ???)

;; =================
;; Data definitions:

(@problem 1)
;; Design a data definition to represent a movie, including  
;; title, budget, and year released.
;;
;; To help you to create some examples, find some interesting movie facts below:
;; "Titanic" - budget: 200000000 released: 1997
;; "Avatar" - budget: 237000000 released: 2009
;; "The Avengers" - budget: 220000000 released: 2012
;;
;; However, feel free to research more on your own!


(@htdd Movie)
(define-struct movie (title budget year))
;; Movie is (make-movie String Natural Natural)
;; interp. a movie with title, budget in USD, and year released
(define M1 (make-movie "Titanic" 200000000 1997))
(define M2 (make-movie "Avatar" 237000000 2009))
(define M3 (make-movie "The Avengers" 220000000 2012))

(@dd-template-rules compound) ;3 fields

#;
(define (fn-for-movie m)
  (... (movie-title m)    ;String
       (movie-budget m)   ;Natural
       (movie-year m)))   ;Natural



;; =================
;; Functions:

(@problem 2)
;; You have a list of movies you want to watch, but you like to watch your 
;; rentals in chronological order. Design a function that consumes two movies 
;; and produces the title of the most recently released movie.
;;
;; Note that the rule for templating a function that consumes two compound data 
;; parameters is for the template to include all the selectors for both 
;; parameters.


(@htdf most-recent-title)
(@signature Movie Movie -> String)
;; produce title of most recently released movie, or m1 if same release year
(check-expect (most-recent-title M1 M2) "Avatar")
(check-expect (most-recent-title M2 M1) "Avatar")
(check-expect (most-recent-title M3 M2) "The Avengers")
(check-expect (most-recent-title M3
                                 (make-movie "Name"
                                             0
                                             (movie-year M3)))
              "The Avengers")

; (define (most-recent-title m1 m2) "")   ; stub

(@template-origin Movie)

(@template
 (define (fn-for-movie m)
   (... (movie-title m)
        (movie-budget m)
        (movie-year m))))

#;
(define (fn-for-movie m1 m2)
  (... (movie-title m1)
       (movie-budget m1)
       (movie-year m1)
       (movie-title m2)
       (movie-budget m2)
       (movie-year m2)))

(define (most-recent-title m1 m2)
  (if (>= (movie-year m1) (movie-year m2))
      (movie-title m1)
      (movie-title m2)))
