;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-advanced-reader.ss" "lang")((modname tour) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #t #t none #f () #t)))




(define (solve RANK)
  (local [(define (solve/one p path)
            (cond [(member p path) false]
                  [(= (length path) (sqr RANK)) (reverse path)]
                  [else
                   (solve/lop (next-moves p) #;(sort (remove-all path (next-moves p))
                                                     (lambda (a b)
                                                       (fewest-next-moves a b path)))
                              (cons p path))]))

          (define (solve/lop lop path)
            (cond [(empty? lop) false]
                  [else
                   (local [(define try (solve/one (first lop) path))]
                     (if (not (false? try))
                         try
                         (solve/lop (rest lop) path)))]))

          (define (next-moves p)
            (local [(define x (pos->x p))
                    (define y (pos->y p))]
              (filter (lambda (p)
                        (and (<= 0 (pos->x p) (sub1 RANK))
                             (<= 0 (pos->y p) (sub1 RANK))))
                      (list (x-y->pos (- x 1) (- y 2))  ;x +/- 1
                            (x-y->pos (- x 1) (+ y 2))
                            (x-y->pos (+ x 1) (- y 2))
                            (x-y->pos (+ x 1) (+ y 2))

                            (x-y->pos (- x 2) (- y 1))  ;x +/- 2
                            (x-y->pos (- x 2) (+ y 1))
                            (x-y->pos (+ x 2) (- y 1))
                            (x-y->pos (+ x 2) (+ y 1))))))
          
          (define (pos->x p) (remainder p RANK))
          (define (pos->y p) (quotient  p RANK))

          (define (x-y->pos x y) (+ x (* y RANK)))

          ;; NOT PART OF SOLUTION

          (define (fewest-next-moves a b path)
            (< (length (remove-all path (next-moves a)))
               (length (remove-all path (next-moves b)))))

          (define (remove-all r lst)
            (foldr remove lst r))]

    (solve/one 0 empty)))
                  
(solve 4)
          

