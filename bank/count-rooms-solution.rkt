;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-advanced-reader.ss" "lang")((modname count-rooms-solution) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #t #t none #f () #f)))
(require spd/tags)

(@assignment bank/graphs-p2)
(@cwl ???)

(@problem 1)
;; Using the following data definition, design a function that consumes a room 
;; and produces the total number of rooms reachable from the given room. Include
;; the starting room itself. Your function should be tail recursive, but you
;; should not use the primitive length function.


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
(define (fn-for-house r0 m)
  ;; path is (listof String); context preserving accumulator, names of rooms
  (local [(define (fn-for-room r path) 
            (if (member (room-name r) path)
                (... path)
                (fn-for-lor (room-exits r) 
                            (cons (room-name r) path)))) 
          (define (fn-for-lor lor path)
            (cond [(empty? lor) (...)]
                  [else
                   (... (fn-for-room (lookup-room (first lor) m) path)
                        (fn-for-lor (rest lor) path))]))]
    (fn-for-room r0 empty)))

(@template-origin genrec arb-tree accumulator encapsulated)

#;
(define (fn-for-house r0 m)
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
                   (fn-for-room (lookup-room (first rn-wl) m)
                                (rest rn-wl)
                                visited)]))]
    (fn-for-room r0 empty empty)))  



;; =================
;; Functions:

(@htdf count-rooms)
(@signature Room Map -> Natural)
;; produces the number of rooms reachable from the given room
(check-expect (count-rooms (lookup-room "F" ROOMS) ROOMS) 1)
(check-expect (count-rooms (lookup-room "B" ROOMS) ROOMS) 6)
(check-expect (count-rooms (lookup-room "A" ROOMS) ROOMS) 6)

;; structural recursion only (not tail recursion)
(@template-origin genrec arb-tree accumulator)
#;
(define (count-rooms r0 m)
  ;; path is (listof String); context preserving accumulator, names of rooms
  (local [(define (fn-for-room r path) 
            (if (member (room-name r) path)
                empty
                (cons (room-name r)
                      (fn-for-lor (room-exits r) 
                            (cons (room-name r) path)))))
          (define (fn-for-lor lor path)
            (cond [(empty? lor) empty]
                  [else
                   (union (fn-for-room (lookup-room (first lor) m) path)
                          (fn-for-lor (rest lor) path))]))]
    (foldr + 0 (map (lambda (r) 1) (fn-for-room r0 empty)))))


;; tail recursive version
(@template-origin genrec Room (listof String) accumulator encapsulated)

(define (count-rooms r0 m)
  ;; todo is (listof String); a worklist accumulator of room names
  ;; visited is (listof String); context preserving accumulator, names of rooms
  ;;                             already visited
  ;; rsf is Natural; the number of rooms seen so far
  (local [(define (fn-for-room r todo visited rsf) 
            (if (member (room-name r) visited)
                (fn-for-lor todo visited rsf)
                (fn-for-lor (append (room-exits r) todo)
                            (cons (room-name r) visited)
                            (add1 rsf))))
          (define (fn-for-lor todo visited rsf)
            (cond [(empty? todo) rsf]
                  [else
                   (fn-for-room (lookup-room (first todo) m) 
                                (rest todo)
                                visited rsf)]))] 
    (fn-for-room r0 empty empty 0)))


(@htdf union)
(@signature (listof X) (listof X) -> (listof X))
;; produce list containing all elements of l1 and l2 w/ no duplicates
;; ASSUME: l1 and l2 have no duplicates themselves
(check-expect (union empty empty) empty)
(check-expect (union empty (list "a")) (list "a"))
(check-expect (union (list "b") empty) (list "b"))
(check-expect (union (list "a") (list "b")) (list "a" "b"))
(check-expect (union (list "a") (list "a")) (list "a"))
(check-expect (union (list "a" "b" "c" "e") (list "b" "c" "d" "e"))
              (list "a" "b" "c" "e" "d"))



(@template-origin 2-one-of) ;actually has some genrec in it too

#|
Cross Product of Types 

              l1        empty         (cons x (listof X))    
                                                             
  l2
 
  empty                              l1 [2]         
                                                             

                        l2 [1]                                                             
  (cons X (listof X))                (cons (first l1)           [3] 
                                           (union (rest l1)    
                                                  (remove (first l1) l2)))
|#


(define (union l1 l2)
  (cond [(empty? l1) l2]  ;(1)
        [(empty? l2) l1]  ;(2)
        [else
         (cons (first l1) ;(3)
               (union (rest l1)
                      (remove
                       (first l1) l2)))]))


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
