;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname hanoi2) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require spd/tags)

;;
;; The analysis would produce the picture Cinda drew, which shows that the key
;; operation is move a pile of n-1 disks off of a single disk, then move that
;; disk.
;;
;; So it's a straight generative recursion, almost exactly like quicksort.
;; 

(@htdd Tower)
;; Tower is one of: 1 2 3
;; interp.  one of the three towers in a game

(@htdd Goal)
(define-struct goal (n from free to))
;; Goal is (make-goal Natural Tower Tower Tower)
;; interp. a (potentially intermediate) goal when solving towers of hanoi
;;         the goal is to move the top n rings from from to to
;;         CONSTRAINTs:
;;           all the towers have legal stacks of rings
;;           the smallest ring on B and C are smaller than the biggest ring on A

(@htdd Move)
(define-struct move (x y))
;; Move is (make-move Tower Tower)
;; interp. a move operation - the top ring on tower x is moved to tower y



(@htdf hanoi)
(@signature Goal -> (listof Move))
;; Given a goal state produce the list of moves required to reach it
(@template-origin genrec Goal)

(define (hanoi g)
  (local [(define n    (goal-n g))
          (define from (goal-from g))
          (define free (goal-free g))
          (define to   (goal-to g))]
    ;; Termination:
    ;;  end state: all n rings have been moved from a to c
    ;;  reduction: move n-1 rings to intermediate tower
    ;;  correctness: bottom ring goes a to c, and
    ;;               top n-1 rings do so in two steps
    (if (zero? n)
        empty
        (append (hanoi (make-goal (sub1 n) from to free))
                (list (make-move from to))
                (hanoi (make-goal (sub1 n) free from to))))))


(check-expect (hanoi (make-goal 1 1 2 3)) (list (make-move 1 3)))
(check-expect (hanoi (make-goal 1 1 3 2)) (list (make-move 1 2)))
(check-expect (hanoi (make-goal 1 2 3 1)) (list (make-move 2 1)))

(check-expect (hanoi (make-goal 2 1 2 3))
              (list (make-move 1 2) (make-move 1 3) (make-move 2 3)))

(check-expect (hanoi (make-goal 3 1 2 3))
              (list (make-move 1 3)
                    (make-move 1 2)
                    (make-move 3 2)
                    (make-move 1 3)
                    (make-move 2 1)
                    (make-move 2 3)
                    (make-move 1 3)))