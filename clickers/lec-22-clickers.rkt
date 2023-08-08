;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname lec-22-clickers) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #t)))
#|

Question 1:

Consider a new version of the maze solver, that will operate on
relatively small mazes, so we do not care about redundant work. It
should produce the actual path through the maze if there is one,
or false if there isn't. Which design elements will this version of
the solve/p and solve/lop functions need? (Select all that apply.)

A. path accumulator            YES
B. visited accumulator         NO
C. worklist accumulator        NO
D. result so far accumulator   path will be like RSF
E. tandem worklists            NO
F. genrec arb-tree             YES
G. try-catch                   YES

|#










#|

Question 2:

Now consider yet another new version of the maze solver, like in
question 1, that will operate on relatively small mazes, so we do
not care about redundant work. It should produce the shortest
path through the maze if there is one, or false if there isn't. Which
design elements will this version of the solve/p and solve/lop
functions need?  (Select all that apply.)

A. path accumulator
B. visited accumulator
C. worklist accumulator
D. result so far accumulator
E. tandem worklists
F. genrec arb-tree
G. try-catch

|#

#|

Question 3:

Finally consider yet another version of the maze solver. This one
must be tail recursive. It should produce the length of the first
path through the maze it finds if there is one, or false if there isn't.
You are not allowed to call length or othe wise compute the
length of a list; instead you must count as you go. Which design
elements will this version of the solve/p and solve/lop functions
need? (Select all that apply.)

A. path accumulator
B. visited accumulator
C. worklist accumulator
D. result so far accumulator
E. tandem worklists
F. genrec arb-tree
G. try-catch

|#