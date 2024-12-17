;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-advanced-reader.ss" "lang")((modname same-house-as-parent-v1) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
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
