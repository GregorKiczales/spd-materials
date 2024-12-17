;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-advanced-reader.ss" "lang")((modname max-exits-from-solution) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require spd/tags)

(@assignment bank/graphs-p4)
(@cwl ???)

(@problem 1)
;; Using the following data definition, design a function that produces the room
;; with the most exits (in the case of a tie you can produce any of the rooms in
;; the tie).


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

(@htdf max-exits-from)
(@signature Room Map -> Room)
;; produce the room with the most exits
(check-expect (max-exits-from (lookup-room "F" ROOMS) ROOMS)
              (make-room "F" (list)))
(check-expect (max-exits-from (lookup-room "B" ROOMS) ROOMS)
              (make-room "B" (list "C" "E")))
(check-expect (max-exits-from (lookup-room "D" ROOMS) ROOMS)
              (make-room "E" (list "F" "A")))

;; structural recursion only (not tail recursion)
(@template-origin genrec arb-tree accumulator)
#;
(define (max-exits-from r0 map)
  ;; path is (listof String); context preserving accumulator, names of rooms
  (local [(define (fn-for-room r path) 
            (cond [(member (room-name r) path) false]
                  [else
                   (max-exits r
                              (fn-for-lor (room-exits r) 
                                          (cons (room-name r) path)))]))
          (define (fn-for-lor lor path)
            (cond [(empty? lor) false]
                  [else
                   (max-exits (fn-for-room (lookup-room (first lor) map) path)
                              (fn-for-lor (rest lor) path))]))
          
          (define (max-exits r1 r2)
            (cond [(false? r1) r2]
                  [(false? r2) r1]
                  [(>= (length (room-exits r1))
                       (length (room-exits r2)))
                   r1]
                  [else r2]))]
    
    (fn-for-room r0 empty)))

;; tail recursive version
(@template-origin genrec Room (listof String) accumulator encapsulated)

(define (max-exits-from r0 map)
  ;; todo is (listof String); a worklist accumulator of room names
  ;; visited is (listof String); context preserving accumulator, names of rooms
  ;;                             already visited
  ;; rsf is Room; the room with the most exits of rooms seen so far
  (local [(define (fn-for-room r todo visited rsf) 
            (if (member (room-name r) visited)
                (fn-for-lor todo visited rsf) 
                (fn-for-lor (append (room-exits r) todo)
                            (cons (room-name r) visited) 
                            (max-exits r rsf)))) 
          (define (fn-for-lor todo visited rsf)
            (cond [(empty? todo) rsf]
                  [else
                   (fn-for-room (lookup-room (first todo) map)
                                (rest todo)
                                visited rsf)]))
          ; helper
          (define (max-exits r rsf) 
            (if (>= (length (room-exits rsf)) (length (room-exits r)))
                rsf
                r))] 
    (fn-for-room r0 empty empty r0)))


;; Consider this to be a primitive function that comes with the data definitions
;; and that given a room name it produces the corresponding room.  Because
;; this consumes a string and generates a room calling it will amount to a
;; generative step in a recursion through a graph of rooms.

;; You should not edit this function, but you can experiment with it to see how
;; it works.

;;(@htdf lookup-room)
;;(@signature String Map -> Room)
(define (lookup-room name map)
  (local [(define alist (with-input-from-string map read))
          (define entry (assoc name alist))]
    (if (false? entry)
        (error "Room with given name does not exist." name)
        (apply make-room entry))))


(define ROOMS "((\"A\" (\"B\" \"D\")) (\"B\" (\"C\" \"E\")) (\"C\" (\"B\"))
                (\"D\" (\"E\")) (\"E\" (\"F\" \"A\")) (\"F\" ()))")
