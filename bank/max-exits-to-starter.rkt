;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-advanced-reader.ss" "lang")((modname max-exits-to-gen-starter) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require spd/tags)

(@assignment bank/graphs-p5)
(@cwl ???)

(@problem 1)
;; Using the following data definition, design a function that produces the room
;; to which the greatest number of other rooms have exits (in the case of a tie
;; you can produce any of the rooms in the tie).


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

(@htdf lookup-room)
(@signature String -> Room)
;; produce room with given name in Map
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
