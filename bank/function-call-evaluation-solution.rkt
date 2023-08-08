;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname foo-evaluation-solution) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require spd/tags)

(@assignment bank/function-call-evaluation)
(@cwl ???)

(@problem 1)
;;
;; Solution:
;;

(define (foo s)
  (if (string=? (substring s 0 1) "a")
      (string-append s "a")
      s))

(foo (substring "abcde" 0 3))

(foo "abc")

(if (string=? (substring "abc" 0 1) "a")
    (string-append "abc" "a")
    "abc")

(if (string=? "a" "a")
    (string-append "abc" "a")
    "abc")

(if true
    (string-append "abc" "a")
    "abc")

(string-append "abc" "a")

"abca"

(@problem 2)
;;
;; Solution:
;;
(define (bee s)
  (substring s 0 1))


(define (bar s t)
  (if (> (string-length s) (string-length t))
      (bee s)
      (bee t)))


(bar "def" "hij")

(if (> (string-length  "def") (string-length "hij"))
    (bee "def")
    (bee "hij"))

(if (> 3 (string-length "hij"))
    (bee "def")
    (bee "hij"))

(if (> 3 3)
    (bee "def")
    (bee "hij"))

(if false
    (bee "def")
    (bee "hij"))

(bee "hij")

(substring "hij" 0 1)

"h"

(@problem 3)

(define (farfle s)
  (string-append s s))

(farfle (substring "abcdef" 0 2))

(farfle "ab")

(string-append "ab" "ab")

"abab"
