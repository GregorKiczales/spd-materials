;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-advanced-reader.ss" "lang")((modname same-house-as-parent-v2) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #t #t none #f () #f)))
(require spd/tags)

(@assignment bank/accumulators-l3)
(@cwl ???)

(@problem 1)
;; In the Harry Potter movies, it is very important which of the four houses a
;; wizard is placed in when they are at Hogwarts. This is so important that in 
;; most families multiple generations of wizards are all placed in the same
;; house.
;;
;; Design a representation of wizard family trees that includes, for each 
;; wizard, their name, the house they were placed in at Hogwarts and their 
;; children. We encourage you to get real information for wizard families from: 
;;    http://harrypotter.wikia.com/wiki/Main_Page
;;
;; The reason we do this is that designing programs often involves collecting
;; domain information from a variety of sources and representing it in the 
;; program as constants of some form. So this problem illustrates a fairly
;; common scenario.
;;
;; That said, for reasons having to do entirely with making things fit on the
;; screen in later videos, we are going to use a wizard family tree in which
;; wizards and houses both have 1 letter names. (Sigh)


;; =================
;; Data definitions:

(@htdd Wizard)
(define-struct wiz (name house kids))
;; Wizard is (make-wiz String String (listof Wizard))
;; interp. A wizard, with name, house and list of children.

(define Wa (make-wiz "A" "S" empty))
(define Wb (make-wiz "B" "G" empty))
(define Wc (make-wiz "C" "R" empty))
(define Wd (make-wiz "D" "H" empty))
(define We (make-wiz "E" "R" empty))
(define Wf (make-wiz "F" "R" (list Wb)))
(define Wg (make-wiz "G" "S" (list Wa)))
(define Wh (make-wiz "H" "S" (list Wc Wd)))
(define Wi (make-wiz "I" "H" empty))
(define Wj (make-wiz "J" "R" (list We Wf Wg)))
(define Wk (make-wiz "K" "G" (list Wh Wi Wj)))

(define (fn-for-wiz w)          
  (local [(define (fn-for-wiz w)
            (... (wiz-name w)
                 (wiz-house w)
                 (fn-for-low (wiz-kids w))))
          (define (fn-for-low low)
            (cond [(empty? low) (...)]
                  [else
                   (... (fn-for-wiz (first low))
                        (fn-for-low (rest low)))]))]
    (fn-for-wiz w)))



;; =================
;; Functions:

(@problem 2)
;; Design a function that consumes a wizard and produces the names of every 
;; wizard in the tree that was placed in the same house as their immediate
;; parent. 


(@problem 3)
;; Design a new function definition for same-house-as-parent that is tail 
;; recursive. You will need a worklist accumulator.


(@problem 4)
;; Design a function that consumes a wizard and produces the number of wizards 
;; in that tree (including the root). Your function should be tail recursive.
