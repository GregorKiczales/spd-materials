;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname simple-text-editor-starter) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/image)
(require 2htdp/universe)
(require spd/tags)

(@assignment bank/compound-p10)
(@cwl ???)

(@problem 1)
;; In this problem, you will be designing a simple one-line text editor.
;; 
;; The constants and data definitions are provided for you, so make sure 
;; to take a look through them after completing your own Domain Analysis. 
;; 
;; Your text editor should have the following functionality:
;; - when you type, characters should be inserted on the left side of the
;;   cursor 
;; - when you press the left and right arrow keys, the cursor should move
;;   accordingly  
;; - when you press backspace (or delete on a mac), the last character on the
;;   left of the cursors should be deleted
 

;; A simple editor

(@htdw Editor)

;; =================
;; Constants:

(define WIDTH 300)
(define HEIGHT 20)
(define MTS (empty-scene WIDTH HEIGHT))

(define CURSOR (rectangle 2 14 "solid" "red"))

(define TEXT-SIZE 14)
(define TEXT-COLOUR "black")



;; =================
;; Data Definitions:

(@htdd Editor)
(define-struct editor (pre post))
;; Editor is (make-editor String String)
;; interp. pre is the text before the cursor, post is the text after
(define E0 (make-editor "" ""))
(define E1 (make-editor "a" ""))
(define E2 (make-editor "" "b"))

(@dd-template-rules compound) ;2 fields

#;
(define (fn-for-editor e)
  (... (editor-pre e)
       (editor-post e)))



