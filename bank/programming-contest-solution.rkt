;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname programming-contest-solution) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #t)))
(require spd/tags)
;; DO NOT PUT ANY PERSONALLY IDENTIFYING INFORMATION IN THIS FILE. 
;; YOUR COMPUTER SCIENCE IDs WILL BE SUFFICIENT TO IDENTIFY YOU 
;; AND, IF YOU HAVE ONE, YOUR PARTNER
(@assignment bank/search-p4)

(@cwl ???)

#|

In a programming competition, students have a set of problems to solve.
Their goal is to reach >= the winning score threshold in < the time limit.
Each problem is worth a different amount of points. The point total is
based on the difficulty of the problem in combination with the expected
length of time required to solve the problem.

Your team needs to get ready for the competition, and they need to chose
which set of problems they are going to try to solve.  To help with that
you need to design a function that consumes a Competition and produces
a representation of all the different sets of problems that total to enough
points without reaching the time limit.

For example, (plans-to-win C3) should produce:

      (list (list P1 P6)
            (list P8)))

Which represents that it is possible to get to the target score in
less than the target time either by solving problems P1 and P6,
or by solving just P8.

Some additional advice:
  - This is a search problem.
  - You will need a representation of the internal search state.
  - As you go through the generated tree, you will be faced with
    a series of binary decisions to either include the next
    possible problem in the current set of chosen problems or
    not include the next possible problem. 

|#

(@htdd Problem)
(define-struct problem (topic points time))
;; Problem is (make-problem String Natural Natural)
;; interp. one of the problems found in a programming competition,
;;         with a computer science topic area,
;;         the points awarded for correctly solving the problem,
;;         and the expected time to successfully solve the problem in minutes
(define P1 (make-problem "Sorting"          9 14))
(define P2 (make-problem "Graphs"           6 11))
(define P3 (make-problem "Algorithms"      10 12))
(define P4 (make-problem "Recursion"        8 16))
(define P5 (make-problem "Data Structures" 20 35))
(define P6 (make-problem "Proofs"          15 25))
(define P7 (make-problem "Backtracking"    18 30))
(define P8 (make-problem "Searching"       25 44))
(define P9 (make-problem "Trees"            3  8))

(define (fn-for-problem p)
  (... (problem-topic p)
       (problem-points p)
       (problem-time p)))


(@htdd Competition)
(define-struct competition (points-to-win time-limit problems))
;; Competition is (make-comp Natural Natural (listof Problem)
;; interp. a programming competition with year of the competition,
;;         the number of points required to win,
;;         the total time limit in minutes competitors have to solve problems,
;;         and a list of problems competitors can choose from to solve
;;         in the competition.
(define C1 (make-competition 15 24 (list P1 P2 P3)))
(define C2 (make-competition 23 20 (list P1 P2 P3 P4 P9)))
(define C3 (make-competition 24 45 (list P1 P4 P5 P6 P8 P9)))
(define C4 (make-competition 15 50 (list P2 P6 P7 P8)))

(define (fn-for-competition c)
  (... (competition-time-limit c)
       (competition-points-to-win c)
       (fn-for-lop (competition-problems c))))





(@htdd PlanState)
(define-struct ps (points time chosen to-decide))
;; PlanState is (make-ps Natural Integer (listof Problem) (listof Problem))
;; interp. The state of coming up with a planned set of problems in a
;;         competition, with:
;;          total number of points of problems chosen
;;          total time required for problems chosen
;;          problems chosen
;;          problems not yet decided on
(define PS1 (make-ps 10 15 (list)       (list P1 P2 P3)))
(define PS2 (make-ps  0 40 (list P1 P4) (list P5 P6 P7)))



(@htdf plans-to-win)
(@signature Competition Natural -> (listof (listof Problem)))
;; produce list of sets of problem that can win the competition
(check-expect (plans-to-win C1) (list (list P2 P3)))
(check-expect (plans-to-win C2) empty)
(check-expect (plans-to-win C3) (list (list P1 P6) (list P8)))
(check-expect (plans-to-win C4)
              (list (list P2 P6) (list P2 P7) (list P6) (list P7) (list P8)))

(@template-origin encapsulated genrec bin-tree)

(define (plans-to-win c)
  (local [(define (fn-for-ps ps)
            (cond
              ;; trivial - took too long (has to be first test)
              [(>=  (ps-time  ps)  (competition-time-limit c))
               empty]
              ;; trivial - enough points to win! include this set of problems
              [(>= (ps-points ps) (competition-points-to-win c))
               (list (ps-chosen ps))]
              ;; trivial - no problems left to choose, this path is a dud
              [(empty? (ps-to-decide ps))
               empty]
              [else
               (append (fn-for-ps (choose-next ps))
                       (fn-for-ps (skip-next ps)))]))

          ;; (@signature PlanState -> PlanState)
          ;; new plan state by choosing first "to-decide" problem
          ;; CONSTRAINT: there is at least one problem left in (ps-to-decide ps)
          (define (choose-next ps)
            (local [(define p (first (ps-to-decide ps)))]
              (make-ps (+ (ps-points ps) (problem-points p))
                       (+ (ps-time   ps) (problem-time   p))
                       (append (ps-chosen ps) (list p))
                       (rest (ps-to-decide ps)))))

          ;; (@signature PlanState -> PlanState)
          ;; new plan state by skipping first "to-decide" problem
          ;; CONSTRAINT: there is at least one problem left in (ps-to-decide ps)
          (define (skip-next ps)
            (local [(define p (first (ps-to-decide ps)))]
              (make-ps (ps-points ps)
                       (ps-time  ps)
                       (ps-chosen ps) 
                       (rest (ps-to-decide ps)))))]
    
    (fn-for-ps (make-ps 0
                        0
                        empty
                        (competition-problems c)))))


