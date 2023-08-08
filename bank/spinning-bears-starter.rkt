;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname spinning-bears-starter) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/image)
(require 2htdp/universe)
(require spd/tags)

(@assignment bank/ref-p2)
(@cwl ???)

(@problem 1)
;; In this problem you will design another world program. In this program the
;; changing information will be more complex - your type definitions will
;; involve arbitrary sized data as well as the reference rule and compound data.
;; But by doing your design in two phases you will be able to manage this 
;; complexity. As a whole, this problem will represent an excellent summary of 
;; the material covered so far in the course, and world programs in particular.
;;
;; This world is about spinning bears. The world will start with an empty 
;; screen. Clicking anywhere on the screen will cause a bear to appear at that
;; spot. The bear starts out upright, but then rotates counterclockwise at a 
;; constant speed. Each time the mouse is clicked on the screen, a new upright
;; bear appears and starts spinning.
;;
;; So each bear has its own x and y position, as well as its angle of rotation.
;; And there are an arbitrary amount of bears.
;;
;; To start, design a world that has only one spinning bear. Initially, the 
;; world will start with one bear spinning in the center at the screen. Clicking
;; the mouse at a spot on the world will replace the old bear with a new bear at
;; the new spot. You can do this part with only material up through compound.
;;
;; Once this is working you should expand the program to include an arbitrary
;; number of bears.
;;
;; Here is an image of a bear for you to use:
;;
;; https://cs110.students.cs.ubc.ca/bank/bear-img.png


