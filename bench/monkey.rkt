;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname monkey) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require spd/tags)

(@htdd Config)
(define-struct config (mpos bpos banana?))
;; Config is (make-config Pos Pos Boolean)
;; interp.
;;   where the monkey is in the room 
;;   where the banana is in the room 
;;   is the monkey holding the banana

(@htdd Pos)
;; Pos is one of:
;;  - "at door"
;;  - "at middle"
;;  - "at window"
;;  - "on box"
;; interp. where the monkey is in the room

(@htdd Move)
(define-struct move (pre action post))
;; Move is (make-move Config Action Config)
;; interp. a move from one configuration to another



;; (listof (Config -> (listof Config))
(define LEGAL-MOVES
  (list
   ;; Grasp
   (lambda (c)
     (if (and (string=? (config-mpos c) "on box")
              (string=? (config-bpos c) "at middle")
              (false? (config-banana? c)))
         (list (make-config "on box" "at middle" true))
         empty))
   ;; Climb
   (lambda (c)
     (if (string=? (config-mpos c) (config-bpos c))
         (list (make-config "on box" (config-bpos c) (config-banana? c)))
         empty))
   ;; Push
   (lambda (c)
     (if (string=? (config-mpos c) (config-bpos c))
         (map (lambda (np)
                (make-config np np (config-banana? c)))
              '("at door" "at middle" "at window"))
         empty))
   ;; Walk
   (lambda (c)
     (if (not (string=? (config-mpos c) "on box"))
         (map (lambda (np)
                (make-config np (config-bpos c) (config-banana? c)))
              '("at door" "at middle" "at window"))
         empty))))


(@signature Config -> Config or false)

(define (solve init)
  (local [(define (solve/one c path)
            (cond [(member? c path) false]
                  [(solved? c)      (reverse (cons c path))]                  
                  [else
                   (local [(define result (solve/lst (next-configs c)
                                                     (cons c path)))]
                     (if (not (false? result)) 
                         result
                         false))]))
          
          (define (solve/lst loc path)
            (cond [(empty? loc) false]
                  [else             
                   (local [(define try (solve/one (first loc) path))]
                     (if (not (false? try))
                         try 
                         (solve/lst (rest loc) path)))]))

          (define solved? config-banana?)

          (define (next-configs c)
            (foldr append empty
                   (map (lambda (f) (f c)) LEGAL-MOVES)))]
    
    (solve/one init '())))


(solve (make-config "at door" "at window" false))
