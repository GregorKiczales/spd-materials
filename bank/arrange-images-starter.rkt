;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname arrange-images-starter) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/image)
(require spd/tags)

(@assignment bank/helpers-l1)
(@cwl ???)

;; > arrange-images-starter.rkt (problem statement)
;;   arrange-images-v1.rkt      (includes ListOfImage)
;;   arrange-images-v2.rkt      (includes arrange-images and
;;                               2 wish-list entries)
;;   arrange-images-v3.rkt      (includes arrange-images and layout-images,
;;                               stub for sort-images)
;;   arrange-images-v4.rkt      (includes arrange-images, layout-images,
;;                               sort and stub for insert)
;;   arrange-images-v5.rkt      (includes arrange-images, layout-images, sort,
;;                               insert, stub for larger?)
;;   arrange-images-v6.rkt      (complete)

(@problem 1)
;; In this problem imagine you have a bunch of pictures that you would like to 
;; store as data and present in different ways. We'll do a simple version of 
;; that here, and set the stage for a more elaborate version later.
;;
;; (A) Design a data definition to represent an arbitrary number of images.
;;
;; (B) Design a function called arrange-images that consumes an arbitrary number
;;     of images and lays them out left-to-right in increasing order of size.

