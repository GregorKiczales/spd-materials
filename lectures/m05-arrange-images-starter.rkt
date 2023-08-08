;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname m05-arrange-images-starter) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #t)))
(require spd/tags)
(require 2htdp/image)

(@assignment lectures/m05-arrange-images)

(@cwl ???) ;replace ??? with your cwl


;; arrange-images-starter.rkt (problem statement)


(@problem 1)
#|

In this problem imagine you have a bunch of pictures that you would like to 
store as data and present in different ways. We'll do a simple version of that 
here, and set the stage for a more elaborate version later.

(A) Design a data definition to represent an arbitrary number of images.

(B) Design a function called arrange-images that consumes an arbitrary number
    of images and lays them out left-to-right in increasing order of size.

|#
