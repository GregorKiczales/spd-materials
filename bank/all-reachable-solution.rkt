;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-advanced-reader.ss" "lang")((modname all-reachable-solution) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require spd/tags)

(@assignment bank/graphs-p1)
(@cwl ???)

(@problem 1)


;; =================
;; Data Definitions: 

(@htdd Room)
(define-struct room (name exits))
;; Room is (make-room String (listof String))
;; interp. the room's name, and list of names of rooms that the exits lead to


(@htdd Map)
;; A Map is AN OPAQUE DATA STRUCTURE. OPAQUE means you can't look inside it.
;; THE ONLY THING YOU ARE  ALLOWED TO DO WITH IT IS PASS IT TO GET-ROOM.
;;
;; The bottom of the file defines a map called MAP for this graph:
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
                            (cons (room-name r) visited)))) ;(... (room-name r))
          (define (fn-for-lor rn-wl visited)
            (cond [(empty? rn-wl) (...)]
                  [else
                   (fn-for-room (lookup-room (first rn-wl) map)
                                (rest rn-wl)
                                visited)]))]
    (fn-for-room r0 empty empty))) 

 



;; =================
;; Functions:

(@htdf all-reachable)
(@signature Room Map -> (listof String))
;; produce names of rooms reachable from the given room

(check-expect (all-reachable (lookup-room "F" ROOMS) ROOMS)
              (list "F"))
(check-expect (all-reachable (lookup-room "B" ROOMS) ROOMS)
              (list "B" "C" "E" "F" "A" "D"))
(check-expect (all-reachable (lookup-room "A" ROOMS) ROOMS)
              (list "A" "B" "C" "E" "F" "D"))

;; ordinary recursion:

(@template-origin genrec arb-tree accumulator)
#;
(define (all-reachable r0 map)
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
                   (union (fn-for-room (lookup-room (first lor) map) path)
                          (fn-for-lor (rest lor) path))]))

          (define (union l1 l2)
            (cond [(empty? l1) l2]
                  [(empty? l2) l1]
                  [else
                   (cons (first l1)
                         (union (rest l1)
                                (remove (first l1) l2)))]))]
    (fn-for-room r0 empty)))


;; tail recursive version:

(@template-origin genrec arb-tree accumulator)

(define (all-reachable r0 map)
  ;; rn-wl is (listof String);   worklist accumulator of room names
  ;; visited is (listof String); names of rooms already visited in the tr
  (local [(define (fn-for-room r rn-wl visited) 
            (if (member (room-name r) visited) 
                (fn-for-lor rn-wl visited)
                (fn-for-lor (append (room-exits r) rn-wl) 
                            (append visited (list (room-name r))))))
          (define (fn-for-lor rn-wl visited)
            (cond [(empty? rn-wl) visited] 
                  [else
                   (fn-for-room (lookup-room (first rn-wl) map)
                                (rest rn-wl)
                                visited)]))]
    (fn-for-room r0 empty empty))) 





(@htdf lookup-room)
(@signature String Map -> Room)
(define (lookup-room name map)
  (local [(define alist (with-input-from-string map read))
          (define entry (assoc name alist))]
    (if (false? entry)
        (error "Room with given name does not exist." name)
        (apply make-room entry))))


(define ROOMS "((\"A\" (\"B\" \"D\")) (\"B\" (\"C\" \"E\")) (\"C\" (\"B\"))
                (\"D\" (\"E\")) (\"E\" (\"F\" \"A\")) (\"F\" ()))")
