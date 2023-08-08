
(@htdd ListOfPos)

(define-type ListOfPos
  (one-of empty
          (cons Pos
                ListOfPos)))


(@fn-for ListOfPos)

(define (fn-for-lop lop)
  (cond [(empty? lop) (...)]
        [else
         (... (fn-for-pos (first lop))
              (fn-for-lop (rest lop)))]))


(@htdf all-x-coords)
(@signature ListOfPos -> ListOfNumber)

(@template-origin ListOfPos)

(define (all-x-coords lop)
  (cond [(empty? lop) empty]
        [else
         (cons (pos-x (first lop))
               (fn-for-lop (rest lop)))]))



(@htdd Door)  ;because of define-type and @fn-for can do this instead of multi-arg @htdd
(@htdd Room)
(@htdd ListOfString)
(@htdd ListOfDoor)

(define-struct Door (keys to))
(define-struct Room (name exits))
  
(define-type Door (make-door (listof String) Room))

(define-type Room (make-room String (listof Door)))

(define-type ListOfString
  (one-of empty
          (cons Pos
                ListOfString)))

(define-type ListOfDoor
  (one-of empty
          (cons Door
                ListOfString)))

(@fn-for Door) ;could this just be (@template-origin Door)
;              ;yes, it's just a copy here for using,
;              ;can be checked here and in functions

(define (fn-for-door d)
  (... (fn-for-los (door-keys d))
       (fn-for-room (door-to d))))

(@fn-for Room)

(define (fn-for-room r)
  (... (room-name r)
       (fn-for-lod (room-exits r))))

(@fn-for ListOfString)

(define (fn-for-los los)
  (cond [(empty? los) (...)]
        [else
         (... (first los)
              (fn-for-los (rest los)))]))

;; what's the difference between @fn-for and @template?
;; specifically when do you switch from using one to the other


(@template-origin encapsulated tail-recursive)
(define (fn-for-room r)
  (local [
          (@template-origin Room genrec)
          (define (fn-for-room r)
            (... (room-name r)
                 (fn-for-lod (room-exits r))))
          
          (@template-origin (listof Door))
          (define (fn-for-lod lod)
            (cond ...))

          

          ]

    ))
