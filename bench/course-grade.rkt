;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname course-grade) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require spd/tags)
(require racket/list)
(require racket/function)

(@htdf course-grade)

(@signature (listof Number)  ;problem set grades
            (listof Number)  ;lab grades
            (listof Number)  ;clicker grades
            Number           ;midterm 1
            Number           ;midterm 2
            Number           ;final
            -> Number)       ;course grade
;; Given set of individal percent grades compute course grade

(check-expect (course-grade
                  '(1 1 1 1 1 1) '(1 1 1 1 1) '(1 1 1 1 1 1 1 1 1 1 1) 1 1 1)
              100)

(check-expect (course-grade
                  '(1 1 1 1 1 1) '(1 1 1 1 1) '(1 1 1 1 1 1 1 1 1 1 1) 1 1 0)
              95)

(check-expect (course-grade
                  '(1 1 1 1 1 1 1 1 1 1 0 0 -1)
                '(1 1 1 1 1 1 1 1 1 1 0 0 -1)
                '(1 1 1 1 1 1 1 1 1 1 1)
                1 1 1)
              98)

(define (course-grade psets labs clickers mt1 mt2 final)
  (local [(define psets*    (trim-grades psets 1))
          (define labs*     (trim-grades labs 1))
          (define clickers* (trim-grades clickers 8))

          (define pset    (/ (sum psets*)    (length psets*)))
          (define lab     (/ (sum labs*)     (length labs*)))
          (define clicker (/ (sum clickers*) (length clickers*)))

          (define w/o-final
            (+ (* .15 pset)               
               (* .10 lab)                
               (* .10 clicker)            
               (* .05 (max lab clicker))      ;edX weight -> max of lab,clicker
               (* .15 mt1)
               (* .20 (max mt1 mt2 final))))] ;mt2 weight -> max of 3 exams

    (round (* 100 
              (max (+ w/o-final
                      (* .25 final))          ;25% final
                   
                   (+ w/o-final
                      (* .05 final)
                      (* .10 pset)
                      (* .05 lab) 
                      (* .05 clicker)))))))   ; 5% final
            


(@htdf trim-grades)
(@signature (listof Number) -> (listof Number))
;; remove -1 and n smallest numbers from lon
(check-expect (trim-grades '() 1) '())
(check-expect (trim-grades '(.8 -1 .9 .2) 1) '(.8 .9))

(define (trim-grades lon n)
  (local [(define trimmed (sort (remove-all -1 lon) <))]
    (drop trimmed (min n (length trimmed)))))

(define sum (curry foldr + 0))
  
