
Ada Lovelace Day? (second Tuesday in October)

People make a lot of the first programmer being a woman.  That's insulting - why couldn't a woman be the first programmer.

The real thing that's amazing is when it happened.

Turing worked in the late 30s to his death in 54
Shannon lived much longer, so 30s to 2001.
They were brilliant, no doubt.

But Babbage started working on his ideas a hundred years earlier.  It
was too early to build the real machine and have it work, so his work
on it was on paper, and Lovelaces ideas about programming it were
theoretical.  Brass gears are not an easy way to build a computer.

But its incredible how far ahead they were.



5  MT1 results

it's very good to have done well
- but course starts slowly on purpose so everyone can master fundamentals
- course will get harder and faster
- grade curve will shift down
- talk about percentage of class with higher grade
   - that's an indicator of how well you have mastered
     material so far compared to rest of class

10  clicker


this week recursive types pay back in a big way!



20 present   BST intro up through type comment
                compound, arb size - on left and right
                there's a null tree under here
@35

10 class     complete DD

10 present   setup render
             simple setup only, analysis of geometry
             show picture w/ 10:why and 2 RNRs under it

@55
   class     complete design of render
               use call to tested case in RHS of ce
               combination spreads around it's a concept, not a single place


remember no need for try-catch searching a BST (could be in BT)
they are introduced in l10




how long to find number in list?  in sorted list?

So here's a thing we would never expect you to invent. But we would
like you to be able to read about it and then design a program.  Start
IN THE DOMAIN OF THE INFORMATION





(@htdd BST)
(define-struct node (key val l r))
;; A BST (Binary Search Tree) is one of:
;;  - false
;;  - (make-node Integer String BST BST)
;; interp. false means empty BST
;;         key is the node key
;;         val is the node val
;;         l and r are left and right subtrees
;; CONSTRAINT: (INVARIANT) for a given node:
;;     key is > all keys in its l(eft)  child
;;     key is < all keys in its r(ight) child
;;     the same key never appears twice in the tree

;; An example tree is at
;; https://cs110.students.cs.ubc.ca/lectures/m06-bst.png



(define BST0 false)
(define BST1 (make-node 1 "abc" false false))
(define BST4 (make-node 4 "dcj" false (make-node 7 "ruf" false false)))
(define BST3 (make-node 3 "ilk" BST1 BST4))


#|
PROBLEM: Complete the data definition.  Include example constants for nodes 27,
42, and 10. Also write a template. As of module 6A you are no longer required
to have a @dd-template-rules tag.  But you must still follow the rules!
|#

(define BST27 (make-node 27 "wit"
                         (make-node 14 "olp" false false)
                         false))
(define BST42 (make-node 42 "ily"
                         BST27
                         (make-node 50 "dug" false false)))
(define BST10 (make-node 10 "why" BST3 BST42))

(define (fn-for-bst t)
  (cond [(false? t) (...)]
        [else
         (... (node-key t) 
              (node-val t) 
              (fn-for-bst (node-l t))
              (fn-for-bst (node-r t)))]))



;; Function:



#|
PROBLEM: Design a function that consumes a bst and produces a SIMPLE
rendering of that bst. Emphasis on SIMPLE. You might want to skip the lines 
for example.
|#

(@htdf render-bst)
(@signature BST -> Image)
;; Produce simple rendering of tree
(check-expect (render-bst false) empty-image)
(check-expect (render-bst (make-node 1 "abc" false false))
              (text "1:abc" TEXT-SIZE TEXT-COLOR))
(check-expect (render-bst (make-node 1 "abc" false false))
              (above (text "1:abc" TEXT-SIZE TEXT-COLOR)
                     (beside empty-image empty-image)))
(check-expect (render-bst (make-node 1 "abc" false false))  ;add later
              (above (text "1:abc" TEXT-SIZE TEXT-COLOR)
                     (beside (render-bst false) (render-bst false))))
(check-expect (render-bst (make-node 1 "abc" false false))  ;add later
              (above (text (string-append (number->string 1) ":" "abc")
                           TEXT-SIZE TEXT-COLOR)
                     (beside (render-bst false) (render-bst false))))
(check-expect (render-bst BST4)
              (above (text "4:dcj" TEXT-SIZE TEXT-COLOR)
                     (beside (render-bst false)
                             (render-bst (make-node 7 "ruf" false false)))))
(check-expect (render-bst BST27)
              (above (text "27:wit" TEXT-SIZE TEXT-COLOR)
                     (beside (render-bst (make-node 14 "olp" false false))
                             (render-bst false))))

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
