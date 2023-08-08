;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname house-path-solution) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require spd/tags)

(@assignment bank/accumulators-p11)
(@cwl ???)

;; Consider the following house diagram:
;; 
;; https://cs110.students.cs.ubc.ca/bank/house.png
;; 
;; Starting from the porch, there are many paths through the house that you can
;; follow without retracing your steps.  If we represent these paths as lists:
;; (list 
;;  (list "Porch")
;;  (list "Porch" "Living Room")
;;  (list "Porch" "Living Room" "Hall")
;;  ...)
;;
;; you can see that a lot of these paths start with the same sequence of rooms.
;; We can represent these paths, and capture their shared initial parts, by 
;; using a tree:
;; 
;; https://cs110.students.cs.ubc.ca/bank/housetree.png
;; 
;; The following data definition does exactly this.


(@htdd Path)
(define-struct path (room nexts))
;; Path is (make-path String (listof Path))
;; interp. An arbitrary-arity tree of paths.
;;  - (make-path room nexts) represents all the paths downward from room
;;  - room is the name of the room
;;  - nexts is a list of paths you can follow from that room
(define P0 (make-path "A" empty)) ; a room from which there are no paths

(define PH 
  (make-path "Porch"
   (list 
    (make-path "Living Room"
      (list (make-path "Dining Room"
              (list (make-path"Kitchen"
                      (list (make-path "Hall"
                              (list (make-path "Study" (list))
                                    (make-path "Bedroom" (list))
                                    (make-path "Bathroom" (list))))))))
            (make-path "Hall"
              (list (make-path "Kitchen"
                      (list (make-path "Dining Room" (list))))
                    (make-path "Study" (list))
                    (make-path "Bedroom" (list))
                    (make-path "Bathroom" (list)))))))))
   
#;
(define (fn-for-path p)
  (local [(define (fn-for-path p)
            (... (path-room p)
                 (fn-for-lop (path-nexts p))))
          (define (fn-for-lop lop)
            (cond [(empty? lop) (...)]
                  [else
                   (... (fn-for-path (first lop))
                        (fn-for-lop (rest lop)))]))]
    (fn-for-path p)))


;; The problems below also make use of the following data definition and
;; functions:

(@htdd Result)
;; Result is one of:
;; - Boolean
;; - "never"
;; interp. three possible answers to a question
(define R0 true)
(define R1 false)
(define R2 "never")

#;
(define (fn-for-result r)
  (cond 
    [(boolean? r) (... r)] ;template ok?
    [else (...)]))


(@htdf and-result)
(@signature Result Result -> Result)
;; produce the logical combination of two results

;;Cross Product of Types Table:
;;
;; ╔════════════════╦═══════════════╦══════════════╗
;; ║                ║               ║              ║
;; ║            r0  ║   Boolean     ║   "never"    ║
;; ║                ║               ║              ║
;; ║    r1          ║               ║              ║
;; ╠════════════════╬═══════════════╬══════════════╣
;; ║                ║               ║              ║
;; ║   Boolean      ║ (and r0 r1)[1]║              ║
;; ║                ║               ║              ║
;; ╠════════════════╬═══════════════╣  r1[2]       ║
;; ║                ║               ║              ║
;; ║   "never"      ║  r0[3]        ║              ║
;; ║                ║               ║              ║
;; ╚════════════════╩═══════════════╩══════════════╝

(check-expect (and-result false false) false)
(check-expect (and-result false true) false)
(check-expect (and-result false "never") false)
(check-expect (and-result true false) false)
(check-expect (and-result true true) true)
(check-expect (and-result true "never") true)
(check-expect (and-result "never" true) true)
(check-expect (and-result "never" false) false)
(check-expect (and-result "never" "never") "never")

(@template-origin 2-one-of)

(define (and-result r0 r1)
  (cond [(and (boolean? r0) (boolean? r1)) (and r0 r1)] ;(1)
        [(string? r0) r1] ;(2)
        [else r0]))       ;(3)


(@htdf or-result)
(@signature Result Result -> Result)
;; produce the logical combination of two results

;;Cross Product of Types Table:
;;
;; ╔════════════════╦═══════════════╦══════════════╗
;; ║                ║               ║              ║
;; ║            r0  ║   Boolean     ║   "never"    ║
;; ║                ║               ║              ║
;; ║    r1          ║               ║              ║
;; ╠════════════════╬═══════════════╬══════════════╣
;; ║                ║               ║              ║
;; ║   Boolean      ║ (or r0 r1)[1] ║              ║
;; ║                ║               ║              ║
;; ╠════════════════╬═══════════════╣  r1[2]       ║
;; ║                ║               ║              ║
;; ║   "never"      ║  r0[3]        ║              ║
;; ║                ║               ║              ║
;; ╚════════════════╩═══════════════╩══════════════╝

(check-expect (or-result false false) false)
(check-expect (or-result false true) true)
(check-expect (or-result false "never") false)
(check-expect (or-result true false) true)
(check-expect (or-result true true) true)
(check-expect (or-result true "never") true)
(check-expect (or-result "never" true) true)
(check-expect (or-result "never" false) false)
(check-expect (or-result "never" "never") "never")

(@template-origin 2-one-of)

(define (or-result r0 r1)     
  (cond [(and (boolean? r0) (boolean? r1)) (or r0 r1)] ;(1)
        [(string? r0) r1] ;(2)
        [else r0]))       ;(3)


(@problem 1)
;; Design a function called always-before that takes a path tree p and two room
;; names b and c, and determines whether starting from p:
;; 1) you must pass through room b to get to room c (produce true),
;; 2) you can get to room c without passing through room b (produce false), or
;; 3) you just can't get to room c (produce "never").
;; 
;; Note that if b and c are the same room, you should produce false since you 
;; don't need to pass through the room to get there.


(@htdf always-before)
(@signature Path String String -> Result)
;; produce true if must pass b to get to c, "never" if can't go to c, else false
(check-expect (always-before PH    "Hall" "Hall")         false)
(check-expect (always-before PH    "Hall"  "Study")       true)
(check-expect (always-before PH    "Hall"  "Dining Room") false)
(check-expect (always-before PH    "Study" "Hall")        false)
(check-expect (always-before PH    "Dining Room" "Bathroom") false)
(check-expect (always-before PH    "Kitchen" "Porch")     false)
(check-expect (always-before PH    "Porch"   "Kitchen")   true)
(check-expect (always-before PH    "Living Room" "Dining Room") true)
(check-expect (always-before PH    "Study" "Office") "never")

(@template-origin Path (listof Path) accumulator encapsulated)

(define (always-before path b c)
  ;; Accumulator: passed? is Boolean
  ;; Invariant:   true if we've passed through b on path so far, else false
  (local [(define (always-before--path p passed?)
            (if  (string=? (path-room p) c)
                 passed?
                 (if (string=? (path-room p) b)
                     (always-before--lop (path-nexts p) true)
                     (always-before--lop (path-nexts p) passed?))))
          (define (always-before--lop lop passed?)
            (cond [(empty? lop) "never"]
                  [else
                   (and-result (always-before--path (first lop) passed?)
                               (always-before--lop (rest lop) passed?))]))]
    (always-before--path path false)))


(@problem 2)
;; OPTIONAL EXTRA PRACTICE PROBLEM:
;; 
;; Once you have always-before working, make a copy of it, rename the copy to
;; always-before-tr, and then modify the function to be tail recursive.


(@htdf always-before--tail)
(@signature Path String String -> Result)
;; produce true if must pass b to get to c, "never" if can't go to c, else false
(check-expect (always-before--tail PH    "Hall"  "Study")       true)
(check-expect (always-before--tail PH    "Hall"  "Dining Room") false)
(check-expect (always-before--tail PH    "Study" "Hall")        false)
(check-expect (always-before--tail PH    "Dining Room" "Bathroom") false)
(check-expect (always-before--tail PH    "Kitchen" "Porch")     false)
(check-expect (always-before--tail PH    "Porch"   "Kitchen")   true)
(check-expect (always-before--tail PH    "Living Room" "Dining Room") true)
(check-expect (always-before--tail PH    "Study" "Office") "never")
(check-expect (always-before--tail PH    "Dining Room" "Kitchen") false)

(@template-origin Path (listof Path) accumulator encapsulated) ;NOTE: use-abstract-fn
                                                        ;could be added

(define (always-before--tail path b c)
  ;; Accumulator: todo is (listof (list Path Boolean))
  ;; Invariant:   paths not visited and if b is passed on path to that room
  
  ;; Accumulator: result is Result
  ;; Invariant: combination of everything we have seen so far
  (local [(define (always-before--path p passed? todo result)
            ;; Accumulator: passed? is Boolean
            ;; Invariant:   true if we've passed through b on path so far,
            ;;              false otherwise
            (if (string=? (path-room p) c)
                (always-before--lop todo (and-result result passed?))
                (if (string=? (path-room p) b)
                    (always-before--lop (append todo 
                                                (map (λ (r) (list r true))
                                                     (path-nexts p)))
                                        result)
                    (always-before--lop (append todo 
                                                (map (λ (r) (list r passed?))
                                                     (path-nexts p)))
                                        result))))
          
          (define (always-before--lop todo result)
            (cond [(empty? todo) result]
                  [else
                   (local [(define path (first (first todo)))
                           (define passed? (second (first todo)))]
                     (always-before--path path 
                                          passed?
                                          (rest todo)
                                          result))]))]
    (always-before--path path false empty "never")))
