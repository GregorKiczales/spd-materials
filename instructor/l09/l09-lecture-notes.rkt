;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname l09-lecture-notes) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))



#|

A lot of programs end up going through (traversing) data (stored information)
and operating on that information somehow.  We have already seen examples of
that. Biggest number in a list, advance all the balls, see if a ball hits the
paddle, and so on.

There's lots more to come.  The big difference as we go forward is the
complexity of the data.  So far we have just traversed lists.

Now what you've learned so far is really going to pay off.  Many intro courses
are mechanism based - they show you a language mechanism and how to code with
it.  What we have done is to give you a theory (recursive types) and shown you
how to use it to construct correct code.  Today we are going to learn how to
work with trees and, happily, we have to learn very little new in order to do
it.

But first...
|#

#|

Question 1  [45 seconds]

Which of the following is equivalent to 

(cons 3 (cons 2 (cons 1 empty)))

 A. (list 3 (list 2 (list 1)))
 B. (list 3 2 1)
 C. (list 3 2 1 empty)

|#

#|
Question 2 [45 seconds]

Given the variable definition

(define L1 (list 3 2 1))

What is the value of the following expression?

(append (list 1 2) L1)

 A. (list 1 2 3 2 1)
 B. (list (list 1 2) (list 3 2 1))
 C. (list (list 1 2) 3 2 1)
|#



#|
Question 3 [20 seconds]

Given the variable definition

(define L1 (list 3 2 1));

What is the value of the following expression?

(cons 0 L1)

 A. (list 3 2 1 0)
 B. (list 0 3 2 1)
 C. (list 0 (list 3 2 1)) 
 D. (list (list 0) (list 3 2 1))
|#


#|

[present simple explanation of BST, starting from list]

10:why  42:ily   3:ilk   4:dcj   27:wit... on average n/2.  Which is not good
enough if n is large. (Think twitter account passwords.)

So CS invented BSTs. Show picture. Explain how search works. Say invariant but
don't call it out that comes in a minute.

Derive DD with class.  What information do we see? Compound and arb-sized,
but arb-size in two directions.  Two self references, will mean two natural
recursions.

But we need the invariant too.  So now BST means what the type comment says,
PLUS the invariant.

Present DD and template from slide.

Do the template.  @dd-template-rules no longer required. But that's not because
they don't matter anymore. Still need to know and use them!

Call out two natural recursions. That's really all that's new here, two
self-refs so two NRs.

MUST DO COUNT AND LOOKUP BECAUSE NEED TO EXPLAIN OR FALSE


[35 - 50] count class 
 - interrupt at ~ 5 mins to do sig, purpose stub
 - stop at 14 to finish
 - then at ~10 for tests and finish

[50 - 75] render
render class does count, then interactive follow up, stress point about using previously tested cases in check-expects


lookup class does later

|#

(@htdf count)
(@signature BST -> Natural)
;; count the number of nodes in the bst
(check-expect (count BST0) 0)
(check-expect (count BST1) 1)
(check-expect (count BST42) 4)
(check-expect (count BST10) 9)

(@template-origin BST)
(define (count t)
  (cond [(false? t) 0]
        [else   
         (+ 1
            (count (node-l t))
            (count (node-r t)))]))

(@htdf render-bst)
(@signature BST -> Image)
;; Produce simple rendering of tree
(check-expect (render-bst false) empty-image)
(check-expect (render-bst (make-node 1 "abc" false false))
              (text "1:abc" TEXT-SIZE TEXT-COLOR))
(check-expect (render-bst (make-node 1 "abc" false false))
              (above (text "1:abc" TEXT-SIZE TEXT-COLOR)
                     (beside empty-image empty-image)))
(check-expect (render-bst (make-node 1 "abc" false false))
              (above (text "1:abc" TEXT-SIZE TEXT-COLOR)
                     (beside (render-bst false) (render-bst false))))
(check-expect (render-bst (make-node 1 "abc" false false))
              (above (text (string-append (number->string 1) ":" "abc")
                           TEXT-SIZE TEXT-COLOR)
                     (beside (render-bst false) (render-bst false))))


(@template-origin BST)

(define (render-bst t)
  (cond [(false? t) empty-image]
        [else                
         (above (text (string-append (number->string (node-key t))
                                     ":"   
                                     (node-val t))
                      TEXT-SIZE
                      TEXT-COLOR)     
                (beside (render-bst (node-l t))
                        (render-bst (node-r t))))]))

(@htdf lookup)
(@signature BST Integer -> String or false)
;; produce val associated w/ key or fail if there is none
(check-expect (lookup BST1   1) "abc")
(check-expect (lookup BST1   0) false) ;L fail
(check-expect (lookup BST1  99) false) ;R fail
(check-expect (lookup BST10  1) "abc") ;L L succeed
(check-expect (lookup BST10  4) "dcj") ;L R succeed
(check-expect (lookup BST10 27) "wit") ;R L succeed
(check-expect (lookup BST10 50) "dug") ;R R succeed


;(define (lookup t v) false)
(@template-origin BST)

(define (lookup t k)
  (cond [(false? t) false]
        [else
         (cond [(= k (node-key t)) (node-val t)]     
               [(< k (node-key t)) (lookup (node-l t) k)] 
               [(> k (node-key t)) (lookup (node-r t) k)])]))

