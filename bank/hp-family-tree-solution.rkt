;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname hp-family-tree-solution) (read-case-sensitive #t) (teachpacks ((lib "batch-io.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "batch-io.rkt" "teachpack" "2htdp")) #f)))
(require spd/tags)

(@assignment bank/mutual-ref-p3)
(@cwl ???)

;; In this problem set you will represent information about descendant family 
;; trees from Harry Potter and design functions that operate on those trees.
;;
;; To make your task much easier we suggest two things:
;;   - you only need a DESCENDANT family tree
;;   - read through this entire problem set carefully to see what information 
;;     the functions below are going to need. Design your data definitions to
;;     only represent that information.
;;   - you can find all the information you need by looking at the individual 
;;     character pages like the one we point you to for Arthur Weasley.


(@problem 1)
;; Design a data definition that represents a family tree from the Harry Potter
;; wiki, which contains all necessary information for the other problems.  You 
;; will use this data definition throughout the rest of the homework.


(@problem 2)
;; Define a constant named ARTHUR that represents the descendant family tree for
;; Arthur Weasley. You can find all the infomation you need by starting 
;; at: http://harrypotter.wikia.com/wiki/Arthur_Weasley.
;;
;; You must include all of Arthur's children and these grandchildren: Lily, 
;; Victoire, Albus, James.
;;
;;
;; Note that on the Potter wiki you will find a lot of information. But for some
;; people some of the information may be missing. Enter that information with a 
;; special value of "" (the empty string) meaning it is not present. Don't
;; forget this special value when writing your interp.


;; =================
;; Data definitions:

(@htdd Wizard ListOfWizard)
(define-struct wiz (name wand patronus kids))
;; Wizard is (make-wiz String String String ListOfWizard)
;; interp. a wizard in a descendant family tree
;;         name is the first name
;;         wand is the wood their primary wand is made of ("" if unknown)
;;         patronus is their patronus  ("" if unknown)
;;         kids is their immediate children


;; ListOfWizard is one of:
;;  - empty
;;  - (cons Wizard ListOfWizard)
;; interp. a list of wizards

(define ARTHUR
  (make-wiz "Arthur" "" "Weasel"
            (list (make-wiz "Bill" "" ""
                            (list (make-wiz "Victoire"  "" "" empty)
                                  (make-wiz "Dominique" "" "" empty)  ;optional
                                  (make-wiz "Louis"     "" "" empty)));optional
                  (make-wiz "Charlie" "ash" "" empty)
                  (make-wiz "Percy" "" ""
                            (list (make-wiz "Molly" "" "" empty)          
                                  (make-wiz "Lucy"  "" "" empty)))
                  (make-wiz "Fred"    ""    "" empty)
                  (make-wiz "George"  ""    ""
                            (list (make-wiz "Fred" "" "" empty)     
                                  (make-wiz "Roxanne"  "" "" empty)))
                  (make-wiz "Ron"     "ash" "Jack Russell Terrier"
                            (list (make-wiz "Rose" "" "" empty)
                                  (make-wiz "Hugo" "" "" empty)))
                  (make-wiz "Ginny"   ""    "horse" 
                            (list (make-wiz "James" "" "" empty)
                                  (make-wiz "Albus" "" "" empty)
                                  (make-wiz "Lily"  "" "" empty))))))

#;#;
(define (fn-for-wizard w)
  (... (wiz-name w)
       (wiz-wand w)
       (wiz-patronus w)
       (fn-for-low (wiz-kids w))))

(define (fn-for-low low)
  (cond [(empty? low) (...)]
        [else
         (... (fn-for-wizard (first low))
              (fn-for-low (rest low)))]))


(@htdd ListOfPair)
;; ListOfPair is one of:
;;  - empty
;;  - (cons (list String String) ListOfPair)
;; interp. used to represent an arbitrary number of pairs of strings
(define LOP1 empty)
(define LOP2 (list (list "Harry" "stag") (list "Hermione" "otter")))

#;
(define (fn-for-lop lop)
  (cond [(empty? lop) (...)]
        [else
         (... (first (first lop))
              (second (first lop)) ;(first (rest (first lop)))
              (fn-for-lop (rest lop)))]))


(@htdd ListOfString)
;; ListOfString is one of:
;; - empty
;; - (cons String ListOfString)
;; interp. a list of strings
(define LOS1 empty)
(define LOS2 (list "a" "b"))

#;
(define (fn-for-los los)
  (cond [(empty? los) ...]
        [else
         (... (first los)
              (fn-for-los (rest los)))]))



;; =================
;; Functions

(@problem 3)
;; Design a function that produces a pair list (i.e. list of two-element lists)
;; of every person in the tree and his or her patronus. For example, assuming 
;; that HARRY is a tree representing Harry Potter and that he has no children
;; (even though we know he does) the result would be:
;;
;; (list (list "Harry" "Stag")).
;;
;; You must use ARTHUR as one of your examples.


(@htdf patroni--wiz patroni--low)
(@signature Wizard -> ListOfPair)
(@signature ListOfWizard -> ListOfPair)
;; produce every wizard in tree together with their patronus
(check-expect (patroni--low empty) empty)
(check-expect (patroni--wiz (make-wiz "a" "b" "c" empty)) (list (list "a" "c")))
(check-expect (patroni--low (list (make-wiz "Harry" "holly" "Stag" empty)
                                  (make-wiz "Lily" "" "" empty)))
              (list (list "Harry" "Stag")
                    (list "Lily" "")))
(check-expect (patroni--wiz ARTHUR)
              (list
               (list "Arthur" "Weasel")
               (list "Bill" "")
               (list "Victoire" "")
               (list "Dominique" "")
               (list "Louis" "")
               (list "Charlie" "")
               (list "Percy" "")
               (list "Molly" "")
               (list "Lucy" "")
               (list "Fred" "")
               (list "George" "")
               (list "Fred" "")
               (list "Roxanne" "")
               (list "Ron" "Jack Russell Terrier")
               (list "Rose" "")
               (list "Hugo" "")
               (list "Ginny" "horse")
               (list "James" "")
               (list "Albus" "")
               (list "Lily" "")))

(@template-origin Wizard)

(define (patroni--wiz w)
  (cons (list (wiz-name w)
              (wiz-patronus w))
        (patroni--low (wiz-kids w))))

(@template-origin ListOfWizard)

(define (patroni--low low)
  (cond [(empty? low) empty]
        [else
         (append (patroni--wiz (first low))
                 (patroni--low (rest low)))]))


(@problem 4)
;; Design a function that produces the names of every person in a given tree 
;; whose wands are made of a given material. 
;;
;; You must use ARTHUR as one of your examples.


(@htdf has-wand-of-wood--wiz has-wand-of-wood--low)
(@signature Wizard String -> ListOfString)
(@signature ListOfWizard String -> ListOfString)
;; produce names of all descendants with wand made of given wood (including wiz)
(check-expect (has-wand-of-wood--low empty "x") empty)
(check-expect (has-wand-of-wood--wiz (make-wiz "a" "b" "c" empty) "x") empty)
(check-expect (has-wand-of-wood--wiz (make-wiz "a" "b" "c" empty) "b")
              (list "a"))
(check-expect (has-wand-of-wood--low (list (make-wiz "a" "b" "c" empty)
                                           (make-wiz "d" "e" "f" empty))
                                     "e")
              (list "d"))
(check-expect (has-wand-of-wood--wiz ARTHUR "ash") (list "Charlie" "Ron"))

(@template-origin Wizard)

(define (has-wand-of-wood--wiz w wood)
  (if (string=? (wiz-wand w) wood)
      (cons (wiz-name w)
            (has-wand-of-wood--low (wiz-kids w) wood))
      (has-wand-of-wood--low (wiz-kids w) wood)))

(@template-origin ListOfWizard)

(define (has-wand-of-wood--low low wood)
  (cond [(empty? low) empty]
        [else
         (append (has-wand-of-wood--wiz (first low) wood)
                 (has-wand-of-wood--low (rest low) wood))]))
