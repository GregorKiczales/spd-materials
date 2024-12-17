;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-advanced-reader.ss" "lang")((modname graphs-gen-v4) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require spd/tags)

(@assignment bank/graphs-l1)
(@cwl ???)

(@problem 1)
;; Imagine you are suddenly transported into a mysterious house, in which all
;; you can see is the name of the room you are in, and any doors that lead OUT
;; of the room.  One of the things that makes the house so mysterious is that
;; the doors only go in one direction. You can't see the doors that lead into
;; the room.
;;
;; Here are some examples of such a house:
;;
;; https://cs110.students.cs.ubc.ca/bank/H1.png
;; https://cs110.students.cs.ubc.ca/bank/H2.png
;; https://cs110.students.cs.ubc.ca/bank/H3.png
;; https://cs110.students.cs.ubc.ca/bank/H4.png
;;
;; In computer science, we refer to such an information structure as a directed
;; graph. Like trees, in directed graphs the arrows have direction. But in a
;; graph it is  possible to go in circles, as in the second example above. It
;; is also possible for two arrows to lead into a single node, as in the fourth
;; example.
;;
;;   
;; Design a data definition to represent such houses. Also provide example data
;; for the four houses above.


;; =================
;; Data Definitions: 

;; Images corresponding to the example data are in the links above each example

(@htdd Room)
(define-struct room (name exits))
;; Room is (make-room String (listof String))
;; interp. the room's name, and list of names of rooms that the exits lead to

;; Link to image of ROOMS:
;; https://cs110.students.cs.ubc.ca/bank/H4.png

(define ROOMS (list (make-room "A" (list "B" "D"))
                    (make-room "B" (list "C" "E"))
                    (make-room "C" (list "B"))
                    (make-room "D" (list "E"))
                    (make-room "E" (list "F" "A"))
                    (make-room "F" (list))))

(define RA (first ROOMS))
(define RB (second ROOMS))
(define RF (sixth ROOMS))

;; Consider this to be a primitive function that comes with the data definitions
;; and that given a room name it produces the corresponding room.  Because
;; this consumes a string and generates a room calling it will amount to a
;; generative step in a recursion through a graph of rooms.

;; You should not edit this function, but you can experiment with it to see how
;; it works.

;;(@htdf lookup-room)
;;(@signature String -> Room)
(define (lookup-room name)
  (local [(define (scan lst)
            (cond [(empty? lst) (error "No room named " name)]
                  [else
                   (if (string=? (room-name (first lst)) name)
                       (first lst)
                       (scan (rest lst)))]))]
    (scan ROOMS)))

(@template-origin genrec Room (listof String) accumulator encapsulated)

#;
(define (fn-for-house r0)
  ;; path is (listof String); context preserving accumulator, names of rooms
  (local [(define (fn-for-room r path) 
            (if (member (room-name r) path)
                (... path)
                (fn-for-lor (room-exits r) 
                            (cons (room-name r) path)))) 
          (define (fn-for-lor lor path)
            (cond [(empty? lor) (...)]
                  [else
                   (... (fn-for-room (lookup-room (first lor)) path)
                        (fn-for-lor (rest lor) path))]))]
    (fn-for-room r0 empty)))

(@template-origin genrec Room (listof String) accumulator encapsulated)

#;
(define (fn-for-house r0)
  ;; todo is (listof String); a worklist accumulator of room names
  ;; visited is (listof String); context preserving accumulator, names of rooms
  ;;                             already visited
  (local [(define (fn-for-room r todo visited) 
            (if (member (room-name r) visited)
                (fn-for-lor todo visited)
                (fn-for-lor (append (room-exits r) todo)
                            (cons (room-name r) visited)))) ;(... (room-name r))
          (define (fn-for-lor todo visited)
            (cond [(empty? todo) (...)]
                  [else
                   (fn-for-room (lookup-room (first todo))
                                (rest todo)
                                visited)]))]
    (fn-for-room r0 empty empty)))

