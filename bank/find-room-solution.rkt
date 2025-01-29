;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-advanced-reader.ss" "lang")((modname find-room-solution) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require spd/tags)

(@assignment bank/graphs-p3)
(@cwl ???)

(@problem 1)
;; Using the following data definition, design a function that consumes a room
;; and a room name and tries to find a room with the given name starting at the
;; given room. Your function should be tail recursive.


;; =================
;; Data Definitions: 

(@htdd Room)
(define-struct room (name exits))
;; Room is (make-room String (listof String))
;; interp. the room's name, and list of names of rooms that the exits lead to

(@htdd Map)
;; A Map is AN OPAQUE DATA STRUCTURE. OPAQUE means you can't look inside it.
;; THE ONLY THING YOU ARE ALLOWED TO DO WITH IT IS PASS IT TO LOOKUP-ROOM.
;;
;; The bottom of the file defines a map called ROOMS for this graph:
;;
;; https://cs110.students.cs.ubc.ca/bank/H4.png
;;
;; But the function you design must work for any map.
;;

(@template-origin genrec arb-tree accumulator)

#;
(define (fn-for-house r0 map)
  ;; path is (listof String); context preserving accumulator, names of rooms
  (local [(define (fn-for-room r path) 
            (if (member (room-name r) path)
                (... path)
                (fn-for-lor (room-exits r) 
                            (cons (room-name r) path)))) 
          (define (fn-for-lor lor path)
            (cond [(empty? lor) (...)]
                  [else
                   (... (fn-for-room (lookup-room (first lor) map) path)
                        (fn-for-lor (rest lor) path))]))]
    (fn-for-room r0 empty)))

(@template-origin genrec arb-tree accumulator encapsulated)

#;
(define (fn-for-house r0 map)
  ;; rn-wl is (listof String);   worklist accumulator of room names
  ;; visited is (listof String); names of rooms already visited in the tr
  (local [(define (fn-for-room r rn-wl visited) 
            (if (member (room-name r) visited)
                (fn-for-lor rn-wl visited)
                (fn-for-lor (append (room-exits r) rn-wl)
                            (cons (room-name r) visited)))) 
          (define (fn-for-lor rn-wl visited)
            (cond [(empty? rn-wl) (...)]
                  [else
                   (fn-for-room (lookup-room (first rn-wl) map)
                                (rest rn-wl)
                                visited)]))]
    (fn-for-room r0 empty empty)))  



;; =================
;; Functions:

(@htdf find-room)
(@signature Room String Map -> Room or false)
;; produce the room with the given name, false if it doesn't exist 

(check-expect (find-room (lookup-room "F" ROOMS) "F" ROOMS)
              (make-room "F" (list)))
(check-expect (find-room (lookup-room "F" ROOMS) "A" ROOMS)
              false)
(check-expect (find-room (lookup-room "B" ROOMS) "A" ROOMS)
              (make-room "A" (list "B" "D"))) 
(check-expect (find-room (lookup-room "A" ROOMS) "X" ROOMS)
              false)


;; structural recursion only (not tail recursion)
(@template-origin genrec arb-tree accumulator)
#;
(define (find-room r0 rn map)
  ;; path is (listof String); context preserving accumulator, names of rooms
  (local [(define (fn-for-room r  path) 
            (cond [(member (room-name r) path) false]
                  [(string=? (room-name r) rn) r]
                  [else
                   (fn-for-lor (room-exits r) 
                               (cons (room-name r) path))]))
          (define (fn-for-lor lor path)
            (cond [(empty? lor) false]
                  [else
                   (local [(define try
                             (fn-for-room (lookup-room (first lor) map)
                                          path))]
                     (if (not (false? try))
                         try
                         (fn-for-lor (rest lor) path)))]))]
    (fn-for-room r0 empty)))

;; tail recursive version
(@template-origin genrec Room (listof String) accumulator encapsulated)

(define (find-room r0 rn map) 
  ;; todo is (listof String); a worklist accumulator of room names
  ;; visited is (listof String); context preserving accumulator,
  ;;                             names of rooms already visited
  (local [(define (fn-for-room r todo visited) 
            (cond [(string=? (room-name r) rn) r]
                  [(member (room-name r) visited)
                   (fn-for-lor todo visited)]
                  [else
                   (fn-for-lor (append (room-exits r) todo)
                               (cons (room-name r) visited))]))
          (define (fn-for-lor todo visited)
            (cond [(empty? todo) false]
                  [else
                   (fn-for-room (lookup-room (first todo) map)
                                (rest todo)
                                visited)]))]
    (fn-for-room r0 empty empty)))

;; Consider this to be a primitive function that comes with the data definitions
;; and that given a room name it produces the corresponding room.  Because
;; this consumes a string and generates a room calling it will amount to a
;; generative step in a recursion through a graph of rooms.

;; You should not edit this function, but you can experiment with it to see how
;; it works.

(@htdf lookup-room)
(@signature String Map -> Room)
;; produce room with given name in Map
(define (lookup-room name map)
  (local [(define alist (with-input-from-string map read))
          (define entry (assoc name alist))]
    (if (false? entry)
        (error "Room with given name does not exist." name)
        (apply make-room entry))))


(define ROOMS "((\"A\" (\"B\" \"D\")) (\"B\" (\"C\" \"E\")) (\"C\" (\"B\"))
                (\"D\" (\"E\")) (\"E\" (\"F\" \"A\")) (\"F\" ()))")
