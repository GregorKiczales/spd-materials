;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname compound-evaluation-solution) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require spd/tags)
(require 2htdp/image) ;!!!

(@assignment bank/compound-evaluation)
(@cwl ???)

(@problem 1)
;;
;; Solution:
;;

(define-struct census-data (city population))

(define (add-newborn cd)
  (make-census-data (census-data-city cd)
                    (add1 (census-data-population cd))))


(add-newborn (make-census-data "Vancouver" 603502))

(make-census-data (census-data-city (make-census-data "Vancouver" 603502))
                  (add1 (census-data-population
                         (make-census-data "Vancouver" 603502))))

(make-census-data "Vancouver"
                  (add1 (census-data-population (make-census-data "Vancouver" 603502))))

(make-census-data "Vancouver"
                  (add1 603502))

(make-census-data "Vancouver" 603503)
