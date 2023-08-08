;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname l19-clickers) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require spd/tags)

;; QUESTION 1 [45 seconds]
;;
;; Is the call to positive? in tail position?

(define (positive-only lon)
  (cond [(empty? lon) empty]
        [else 
         (if (positive? (first lon))
             (cons (first lon) 
                   (positive-only (rest lon)))
             (positive-only (rest lon)))]))



;; A. Yes
;; B. No










;; QUESTION 2 [30 seconds]
;;
;; Is the recursive call to positive-only labeled (1) in tail position?

(define (positive-only lon)
  (cond [(empty? lon) empty]
        [else 
         (if (positive? (first lon))
             (cons (first lon) 
                   (positive-only (rest lon))) ;(1)
             (positive-only (rest lon)))]))    ;(2)


;; A. Yes
;; B. No



;; QUESTION 3 [20 seconds]
;;
;; Is the recursive call to positive-only labeled (2) in tail position?

(define (positive-only lon)
  (cond [(empty? lon) empty]
        [else 
         (if (positive? (first lon))
             (cons (first lon) 
                   (positive-only (rest lon))) ;(1)
             (positive-only (rest lon)))]))    ;(2)

;; A. Yes
;; B. No



;; QUESTION 4 [40 seconds]
;;
;; Is positive-only tail-recursive?

(define (positive-only lon)
  (cond [(empty? lon) empty]
        [else 
         (if (positive? (first lon))
             (cons (first lon) 
                   (positive-only (rest lon)))
             (positive-only (rest lon)))]))   

;; A. Yes
;; B. No



;; QUESTION 5
;;
;; Is positive-only tail-recursive? [40 seconds]

(define (positive-only lon0)
  (local [(define (positive-only lon rsf)
            (cond [(empty? lon) (reverse rsf)]
                  [else 
                   (if (positive? (first lon))
                       (positive-only (rest lon) (cons (first lon) rsf))
                       (positive-only (rest lon) rsf))]))]
    
    (positive-only lon0 empty)))

;; A. Yes
;; B. No