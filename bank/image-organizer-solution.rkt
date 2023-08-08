;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname image-organizer-solution) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/image)
(require spd/tags)

(@assignment bank/mutual-ref-p1)
(@cwl ???)


(@problem 1)
;; Complete the design of a hierarchical image organizer.  The information and
;; data for this problem are similar to the file system example in the
;; fs-starter.rkt file.
;; But there are some key differences:
;;   - this data is designed to keep a hierchical collection of images
;;   - in this data a directory keeps its sub-directories in a separate list
;;     from images it contains
;;   - as a consequence data and images are two clearly separate types
;;  
;; Start by carefully reviewing the partial data definitions below.  


;; =================
;; Constants:

(define LABEL-SIZE 24)
(define LABEL-COLOR "black")



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


;; PART A:
;;
;; Annotate the type comments with reference arrows and label each one to say 
;; whether it is a reference, self-reference or mutual-reference.

;; Here is the solution:
;; https://cs110.students.cs.ubc.ca/bank/mref-p1A.png

;; PART B:
;;
;; Write out the templates for Dir, ListOfDir and ListOfImage. Identify for each
;; call to a template function which arrow from part A it corresponds to.

;; Below are the templates, and here are the arrows for PART B:
;; https://cs110.students.cs.ubc.ca/bank/mref-p1B.png


(define (fn-for-dir d)
  (... (dir-name d)
       (fn-for-lod (dir-sub-dirs d))
       (fn-for-loi (dir-images d))))

(define (fn-for-lod lod)
  (cond [(empty? lod) (...)]
        [else
         (... (fn-for-dir (first lod))
              (fn-for-lod (rest lod)))]))

(define (fn-for-loi loi)
  (cond [(empty? loi) (...)]
        [else
         (... (first loi)
              (fn-for-loi (rest loi)))]))



;; =================
;; Functions:

(@problem 2)
;; Design a function to calculate the total size (width* height) of all the
;; images in a directory and its sub-directories.


(@htdf total-area--dir total-area--lod total-area--loi)
(@signature Dir -> Natural)
(@signature ListOfDir -> Natural)
(@signature ListOfImage -> Natural)
;; produce total area of all images in dir
(check-expect (total-area--lod empty) 0)
(check-expect (total-area--lod (list D4 D5)) (+ (* 10 10) (* 12 12) (* 13 14)))
(check-expect (total-area--loi empty) 0)
(check-expect (total-area--loi (list I1 I2)) (+ (* 10 10) (* 12 12)))
(check-expect (total-area--dir D6) (+ (* 10 10) (* 12 12) (* 13 14)))

(@template-origin Dir)

(define (total-area--dir d)
  (+ (total-area--lod (dir-sub-dirs d))
     (total-area--loi (dir-images d))))

(@template-origin ListOfDir)

(define (total-area--lod lod)
  (cond [(empty? lod) 0]
        [else
         (+ (total-area--dir (first lod))
            (total-area--lod (rest lod)))]))

(@template-origin ListOfImage)

(define (total-area--loi loi)
  (cond [(empty? loi) 0]
        [else
         (+ (image-area (first loi))          ;knowledge domain shift
            (total-area--loi (rest loi)))]))


(@htdf image-area)
(@signature Image -> Natural)
;; produce area of image (width * height)
(check-expect (image-area I3) (* 13 14))

(@template-origin Image)

(define (image-area img)
  (* (image-width img)
     (image-height img)))


(@problem 3)
;; Design a function to produce rendering of a directory with its images. Keep 
;; it simple and be sure to spend the first 10 minutes of your work with paper
;; and pencil!


(@htdf render--dir render--lod render--loi)
(@signature Dir -> Image)
(@signature ListOfDir -> Image)
(@signature ListOfImage -> Image)
;; produce VERY simple rendering of all images in dir
(check-expect (render--loi empty) empty-image)
(check-expect (render--lod empty) empty-image)
(check-expect (render--loi (list I1 I2)) (beside I1 I2 empty-image))
(check-expect (render--dir D4)
              (beside (text "D4" LABEL-SIZE LABEL-COLOR)
                      (render--loi (list I1 I2))))   ;ok to call render--loi
                                                     ;here since it is
                                                    ;tested in previous test
(check-expect (render--lod (list D4 D5))
              (above (render--dir D4)
                     (render--dir D5)
                     empty-image))
(check-expect (render--dir D6)
              (beside (text "D6" LABEL-SIZE LABEL-COLOR)
                      (above (render--dir D4)
                             (render--dir D5)
                             empty-image)))

(@template-origin Dir)

(define (render--dir d)
  (beside (text (dir-name d) LABEL-SIZE LABEL-COLOR)
          (render--lod (dir-sub-dirs d))
          (render--loi (dir-images d))))

(@template-origin ListOfDir)

(define (render--lod lod)
  (cond [(empty? lod) empty-image]
        [else
         (above (render--dir (first lod))
                (render--lod (rest lod)))]))

(@template-origin ListOfImage)

(define (render--loi loi)
  (cond [(empty? loi) empty-image]
        [else
         (beside (first loi)
                 (render--loi (rest loi)))]))

