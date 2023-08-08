;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname fold-dir-solution) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/image)
(require spd/tags)

(@assignment bank/abstraction-p8)
(@cwl ???)


;; In this problem you will need to remember the following DDs 
;; for an image organizer.


;; =================
;; Data definitions:

(@htdd Dir ListOfDir ListOfImage)
(define-struct dir (name sub-dirs images))
;; Dir is (make-dir String ListOfDir ListOfImage)
;; interp. a directory in the organizer, with a name, a list
;;         of sub-dirs and a list of images.


;; ListOfDir is one of:
;;  - empty
;;  - (cons Dir ListOfDir)
;; interp. A list of directories, this represents the sub-directories of
;;         a directory.


;; ListOfImage is one of:
;;  - empty
;;  - (cons Image ListOfImage)
;; interp. a list of images, this represents the sub-images of a directory.
;; NOTE: Image is a primitive type, but ListOfImage is not.

(define I1 (square 10 "solid" "red"))
(define I2 (square 12 "solid" "green"))
(define I3 (rectangle 13 14 "solid" "blue"))
(define D4 (make-dir "D4" empty (list I1 I2)))
(define D5 (make-dir "D5" empty (list I3)))
(define D6 (make-dir "D6" (list D4 D5) empty))



;; =================
;; Functions:

(@problem 1)
;; Design an abstract fold function for Dir called fold-dir. 


(@htdf fold-dir)
(@signature (String Y Z -> X) (X Y -> Y) (Image Z -> Z) Y Z Dir -> X)
;; the abstract fold function for Dir
(check-expect (fold-dir make-dir cons cons empty empty D6) D6)
(check-expect  (local [(define (c1 n rlod rloi) (+ 1 rlod rloi))
                       (define (c2 rdir rlod)   (+ rdir rlod))
                       (define (c3 img rloi)    (+ 1 rloi))]          
                 (fold-dir c1 c2 c3 0 0 D6))
               6)

(@template-origin Dir (listof Dir) (listof Image) encapsulated)

(define (fold-dir c1 c2 c3 b1 b2 d)
  (local [(define (fn-for-dir d)         ; Dir -> X
            (c1 (dir-name d)
                (fn-for-lod (dir-sub-dirs d))
                (fn-for-loi (dir-images d))))
          
          (define (fn-for-lod lod)       ; (listof Dir) -> Y
            (cond [(empty? lod) b1]
                  [else
                   (c2 (fn-for-dir (first lod))
                       (fn-for-lod (rest lod)))]))
          
          (define (fn-for-loi loi)       ; (listof Image) -> Z
            (cond [(empty? loi) b2]
                  [else
                   (c3 (first loi)
                       (fn-for-loi (rest loi)))]))]
    (fn-for-dir d)))


(@problem 2)
;; Design a function that consumes a Dir and produces the number of 
;; images in the directory and its sub-directories. 
;; Use the fold-dir abstract function.


(@htdf count-images)
(@signature Dir -> Natural)
;; count total number of Images in dir and all its subdirs
(check-expect (count-images D4) 2)
(check-expect (count-images D6) 3)

(@template-origin use-abstract-fn)

(define (count-images d)
  (local [(define (c1 n rlod rloi) (+ rlod rloi))
          (define (c2 rdir rlod)   (+ rdir rlod))
          (define (c3 img rloi)    (+ 1 rloi))]          
    (fold-dir c1 c2 c3 0 0 d)))


(@problem 3)
;; Design a function that consumes a Dir and a String. The function looks in
;; dir and all its sub-directories for a directory with the given name. If it
;; finds such a directory it should produce true, if not it should produce  
;; false. Use the fold-dir abstract function.


(@htdf find)
(@signature String Dir -> Boolean)
;; look for a dir named name, if found produce true, otherwise produce false
(check-expect (find "D4" D6) true)
(check-expect (find "D8"  D4) false)

(@template-origin use-abstract-fn)

(define (find name dir)
  (local [(define (c1 n rdirs rimgs)
            (or (string=? name n)
                rdirs))
          (define (c2 rdir rdirs)
            (or rdir rdirs))
          (define (c3 img rimgs)
            false)]
    (fold-dir c1 c2 c3 false false dir)))


(@problem 4)
;; Is fold-dir really the best way to code the function from part C? Why or 
;; why not?


;; No. Consider the case where the directory we are looking for is at the very 
;; root of the tree. As we have written the function in part C with fold-dir, 
;; even though find will produce true for the root node it will search the whole
;; tree anyways. 
;;
;; When we use fold-dir it isn't possible to implement find so that it stops 
;; searching as soon as it finds a directory with the right name. Instead it 
;; will always search the whole tree.
