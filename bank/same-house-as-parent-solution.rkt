;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-advanced-reader.ss" "lang")((modname same-house-as-parent-solution) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
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


(@htdf same-house-as-parent)
(@signature Wizard -> (listof String))
;; Produce the names of every descendant in the same house as their parent.
(check-expect (same-house-as-parent Wa) empty)
(check-expect (same-house-as-parent Wh) empty)
(check-expect (same-house-as-parent Wg) (list "A"))
(check-expect (same-house-as-parent Wk) (list "A" "F" "E"))

;; with tandem worklists
(@template-origin Wizard (listof Wizard) accumulator encapsulated)

(define (same-house-as-parent w) 
  ;; w-wl is (listof Wizard); wizard worklist
  ;; h-wl is (listof String); parent worklist - corresponds with w-wl
  ;; rsf  is (listof String); a result so far accumulator
  ;; INVARIANT: w-wl and h-wl always have same length
  (local [(define (fn-for-wiz w-wl h-wl w ph rsf)
            (fn-for-low (append                            (wiz-kids w)  w-wl)
                        (append (map (λ (k) (wiz-house w)) (wiz-kids w)) h-wl)
                        (if (string=? (wiz-house w) ph)
                            (cons (wiz-name w) rsf)
                            rsf)))
          (define (fn-for-low w-wl h-wl rsf)
            (cond [(empty? w-wl) rsf]
                  [else
                   (fn-for-wiz (rest w-wl)
                               (rest h-wl)
                               (first w-wl)
                               (first h-wl) 
                               rsf)]))]
    (fn-for-wiz empty empty w "" empty)))



#;#;
;; with compound worklist entries
(@template-origin Wizard (listof Wizard) accumulator encapsulated)

(define (same-house-as-parent w) 
  ;; todo is (listof WLE); a worklist accumulator
  ;; rsf  is (listof String); a result so far accumulator
  (local [
          (define-struct wle (w ph))
          ;; WLE (worklist entry) is (make-wle Wizard String)
          ;; interp. a worklist entry with the wizard to pass to fn-for-wiz,
          ;;         and that wizard's parent house
          
          (define (fn-for-wiz todo w ph rsf)
            (fn-for-low (append (map (λ (k) 
                                       (make-wle k (wiz-house w)))
                                     (wiz-kids w)) 
                                todo)
                        (if (string=? (wiz-house w) ph)
                            (cons (wiz-name w) rsf)
                            rsf)))
          (define (fn-for-low todo rsf)
            (cond [(empty? todo) rsf]
                  [else
                   (fn-for-wiz (rest todo) 
                               (wle-w  (first todo))
                               (wle-ph (first todo))
                               rsf)]))]
    (fn-for-wiz empty w "" empty)))


(@template-origin Wizard (listof Wizard) accumulator encapsulated)

#;
(define (same-house-as-parent w)          
  ;; parent-house is String; the house of this wizard's immediate parent
  ;;                         ("" for root of tree)
  ;; (same-house-as-parent Wk)
  ;; (fn-for-wiz Wk "")
  ;; (fn-for-wiz Wh "G")
  ;; (fn-for-wiz Wc "S")
  ;; (fn-for-wiz Wd "S")
  ;; (fn-for-wiz Wi "G")
  (local [(define (fn-for-wiz w parent-house)
            (if (string=? (wiz-house w) parent-house)
                (cons (wiz-name w)
                      (fn-for-low (wiz-kids w)
                                  (wiz-house w)))
                (fn-for-low (wiz-kids w)
                            (wiz-house w))))
          (define (fn-for-low low parent-house)
            (cond [(empty? low) empty]
                  [else
                   (append (fn-for-wiz (first low) parent-house)
                           (fn-for-low (rest low)  parent-house))]))]
    (fn-for-wiz w "")))


(@problem 3)
;; Design a new function definition for same-house-as-parent that is tail 
;; recursive. You will need a worklist accumulator.


(@problem 4)
;; Design a function that consumes a wizard and produces the number of wizards 
;; in that tree (including the root). Your function should be tail recursive.


(@htdf count)
(@signature Wizard -> Natural)
;; produces the number of wizards in that tree (including the root)
(check-expect (count Wa) 1)
(check-expect (count Wk) 11)

;(define (count w) 0)

(@template-origin Wizard (listof Wizard) accumulator encapsulated)

(define (count w)     
  ;; rsf is Natural; the number of wizards seen so far
  ;; todo is (listof Wizard) ; wizards we still need to visit with fn-for-wiz
  ;; (count Wk)
  ;; (fn-for-wiz Wk 0)
  ;; (fn-for-wiz Wh 1)
  ;; (fn-for-wiz Wc 2)
  (local [(define (fn-for-wiz w todo rsf)
            (fn-for-low (append (wiz-kids w) todo) 
                        (add1 rsf))) 
          (define (fn-for-low todo rsf)
            (cond [(empty? todo) rsf]
                  [else
                   (fn-for-wiz (first todo) (rest todo) rsf)]))]
    (fn-for-wiz w empty 0)))
