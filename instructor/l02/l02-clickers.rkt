;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname l02-clickers) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #t)))
(require spd/tags)




;; QUESTION
;;
;; What percentage of your total grade in the course comes from attendance and
;; completing lecture starter files?
;;
;; A.  5
;; B. 10
;; C. 15
;; D. 20
;; E. 25


































;; When working on a problem set I am allowed to (check all that apply):
;;
;;  - A. discuss my understanding of the *problem* (not solution) with
;;       other students
;;
;;  - B. show my solution file to other students
;;
;;  - C. post messages to Piazza that include parts of my solution
;;
;;  - D. work with one partner per problem set
;;
;;  - E. copy and paste from problem bank problem solution

















































;; QUESTION
;;
;; The 110 course staff will provide:
;;  - state of the art content based on research and practice in programming
;;    and software engineering
;;  - delivered using state of the art pedagogy in active and online learning
;;  - supported by significant investment in materials and resources
;;  - 50 person team, extensive office hours, rapid response to questions on
;;    Piazza
;; To succeed in the course you must:
;;  - work hard (12+ hours/week)
;;  - stay up to date – do not get behind by even a day
;;  - trust the design recipes to get you to a solution
;;  - follow course rules of decorum and academic honesty
;;
;; I have read and acknowledge the above
;;
;;   [A] Yes




























;; QUESTION [60 seconds]
;;
;; Given the following definitions:

(define FOO 1)
(define BAR 2)

(define (frotz x)
  (+ (< x FOO) BAR x))

;; What is the next step in the evaluation of (frotz 3)?
;;
;; A. (+ (< 3 FOO) BAR x)
;; B. (+ (< 3 1) 2 x)
;; C. (+ (< 3 FOO) BAR 3)
;; D. (+ (< 3 1) BAR x)
;; E. (+ (< 3 1) 2 3)































;; QUESTION [30 seconds]
;;
;; When the following expression is evaluated, which arithmetic operations
;; are performed?

(+ (* 2 3)
   (/ 1 2)
   (- 6 5))

;; A. Just the *
;; B. The *, /, and -
;; C. The * and the /
;; D. The +, *, /, and -





































;; QUESTION [40 seconds]
;;
;; When the following expression is evaluated, which arithmetic operations
;; are performed?

(if (< 2 1) 
    (> 3 2)
    (= 4 4))

;; A. All three <, >, and =
;; B. Just the <
;; C. Just the >
;; D. The < and the >
;; E. The < and the =


































;; QUESTION [30 seconds]
;;
;; Which comparisons are performed when the following expression is evaluated?

(and (> 2 1) 
     (< 3 2)
     (= 4 4))

;; A. Just the <
;; B. Just the >
;; C. The > and the <
;; D. The < and the =
;; E. All three <, >, and =































