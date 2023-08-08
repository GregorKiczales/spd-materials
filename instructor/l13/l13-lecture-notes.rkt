;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname l12-lecture-notes) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
#|

One of the most important ideas in software is abstraction. What that means
basically is:
  - recognize that some functionality seems to be repeated/common
  - package that common behaviour in a reusable way
  - so that future (and current) uses of that common behaviour
    can be easier to develop, easier to understand, more reliable etc.


We have already seen one form of abstraction:

(@template encapsulated Region ListOfRegion)
(define ..



(@template encapsulated Region ListOfRegion try-catch)
(define ..

Very powerful...


There's another way to go about it, which works in fewer cases, but
provides much greater abstraction when it does work.  The idea is to
make a function that captures the reusable behaviour, with special
arguments for each of the ...  That's our focus this week.

After this week we will use both kinds of abstraction as appropriate.





|#