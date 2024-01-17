;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname room-schedule) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require spd/tags)

#|
You did such a good job scheduling TAs into labs that the department has decided
to give you another scheduling problem.  Fortunately for you, you know that all
search problems are basically the same, so you can attack this systematically.

The department wants you to design a function that will consume a list of
classes and a list of classroom slots, and assign each class to a slot if
possible.

At a bare minimum every class has to be assigned to a room slot big enough to
hold it.  It is OK if there are unused slots left.

For !!! extra points you have the option of trying to also produce the list
of pairs with the least wasted classroom space.

For !!! additional extra points you have the option of making your solution
tail recursive.

NOTE that:

 - you must use the data definitions we provide below

 - as a simplification we are representing time slots as integers. So we have
   time 1, time 2, etc.

 - a correct minimal solution will get more points than an incorrect solution
   with extra features, so only try to add the extra features if you are
   confident you can do so correctly

 - if you decide to try and minimize wasted space CIRCLE THIS LINE HERE

 - if you decide to ALSO make your solution tail recursive CIRCLE THIS LINE HERE

 - extra tail recursion points are only available if you also do minimal
   wasted space

|#


(@htdd Class)
(define-struct class (num size))
;; Class is (make-class Natural Natural)
;; A class with course number and number of students.

(@htdd Slot)
(define-struct slot (room time size))
;; Slot is (make-slot Integer String Natural)
;; interp. A time slot with the room name, time, and room size

(@htdd Pairs)
;; Pairs is (list (list Class Slot))
;; interp. pairs is a schedule saying what class is in what slot

(define C110 (make-class 110 280))
(define C121 (make-class 121 220))
(define C210 (make-class 210 270))
(define C221 (make-class 221 180))
(define C213 (make-class 213 180))


(define SA10 (make-slot "A" 1000 300))
(define SA11 (make-slot "A" 1100 300))
(define SB10 (make-slot "B" 1000 350))
(define SB11 (make-slot "B" 1100 350))
(define SC10 (make-slot "C" 1000 250))
(define SC11 (make-slot "C" 1100 200))

#|
The function you design must consume a list of classes and a list of slots
and produce a list of pairs, or false if no schedule is possible.

|#

(check-expect (solve-schedule (list C110) empty) false)
(check-expect (solve-schedule (list C121 C210 C221 C213 C110)
                              (list SA10 SB10 SB11 SC10 SC11))
              (list (list C110 SA10)
                    (list C213 SB10)
                    (list C221 SC11)
                    (list C210 SB11)
                    (list C121 SC10)))

(@template backtracking genrec arb-tree #;accumulator)

(define (solve-schedule classes slots)
  (local [(define-struct ss (classes slots pairs))

          (define (solve/one ss)
            (cond [(solved? ss) (ss-pairs ss)]
                  [(failed? ss) false]
                  [else
                   (solve/lst (next-sss ss))]))

          #;
          (define (solve/lst loss)
            (cond [(empty? loss) false]
                  [else
                   (local [(define try (solve/one (first loss)))]
                     (if (not (false? try))
                         try
                         (solve/lst (rest loss))))]))

          
          (define (solve/lst loss)
            (cond [(empty? loss) false]
                  [else
                   (best (solve/one (first loss))
                         (solve/lst (rest loss)))]))

          (define (best pairs1 pairs2)
            (cond [(false? pairs1) pairs2]
                  [(false? pairs2) pairs1]
                  [else
                   (if (< (wasted-space pairs1) (wasted-space pairs2))
                       pairs1
                       pairs2)]))
                   
          (define (next-sss ss)
            (local [(define classes (ss-classes ss))
                    (define slots   (ss-slots ss))
                    (define pairs   (ss-pairs ss))]
    
              (map (lambda (s)
                     (make-ss (rest classes)
                              (remove s slots)
                              (cons (list (first classes) s) pairs)))
                   (filter (lambda (s)
                             (>= (slot-size s) (class-size (first classes))))
                           slots))))

          (define (wasted-space pairs)
            (- (foldr + 0 (map class-size (map first  pairs)))
               (foldr + 0 (map  slot-size (map second pairs)))))

          (define (solved? ss) (empty? (ss-classes ss)))
          (define (failed? ss) (empty? (ss-slots  ss)))]

    (solve/one (make-ss classes slots empty))))

