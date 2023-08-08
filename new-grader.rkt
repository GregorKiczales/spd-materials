

(define (listof-X x-type)
  (lambda (stx0)
    (walk...
     (addprop 'nr stx)
     (addprop <nh-or-mr> stx))))

(walk-local has to connect things up right)

need some flow analysis for lambda, could do that later

(define (try-catch)
  (lambda (stx0)
    (walk...
     (if (and "(not (false?"
              (getprop nh-or-mr ...))
         ...))))
