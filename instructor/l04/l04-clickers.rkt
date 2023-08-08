;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname l04-clickers) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require spd/tags)





;; QUESTION [50 seconds]
;;
;; In the context of the cat problem seen in the video, what is
;; the purpose of next-cat?

(@signature Natural -> Natural)

(big-bang 0
          (on-tick next-cat)    ; Natural -> Natural
          (to-draw render-cat)) ; Natural -> Image

;; A. Display the current cat on the screen.
;; B. Produce an image of a cat one tick farther to the right.
;; C. Advance the world state by 1 tick.
;; D. Produce a natural a little larger.
































;; QUESTION [30 seconds]
;;
;; In the context of the cat problem seen in the video, what 
;; is the purpose of the number 0 in the following code?


(@signature Natural -> Natural)

(big-bang 0
          (on-tick next-cat)    ; Natural -> Natural
          (to-draw render-cat)) ; Natural -> Image

;; A. Specifies number of seconds per tick of the world clock. 
;; B. Specifies the size of the image drawn on the screen.
;; C. Specifies the initial value for the world state (the cat).
;; D. Specifies the number of times to move the cat before the program ends.




































;; QUESTION [45 seconds]
;;
;; In the context of the cat problem seen in the video, what 
;; is the purpose of the number 1 in the following code?


(@signature Natural -> Natural)

(big-bang 0
          (on-tick next-cat 1)  ; Natural -> Natural
          (to-draw render-cat)) ; Natural -> Image

;; A. Specifies number of seconds per tick of the world clock.
;; B. Specifies the size of the image drawn on the screen.
;; C. Specifies the initial value for the cat.
;; D. Specifies the number of times to move the cat before the program ends.





























;; QUESTION [45 seconds]
;;
;; The following expression produces an image of a rectangle with a red dot:


(place-image (circle 10 "solid" "red")
             80
             20
             (rectangle 100 100 "outline" "black"))


;; Where is the dot?
;;
;; A. In the upper left corner.
;; B. In the upper right corner.
;; C. In the lower left corner.
;; D. In the lower right corner.














;; QUESTION [30 seconds]
;; 
;; Which office hours should you attend? 
;; 
;; A. In 110, students from any section can attend any office hours.
;; B. In 110, students from any section can attend any office hours.
;; C. In 110, students from any section can attend any office hours.
;; D. In 110, students from any section can attend any office hours.
;;






;; QUESTION
;;
;; When working on a problem set, I am allowed to:
;;
;; A. Consult any online resources I find, including posted solutions from
;;    previous terms, or for example Chegg.
;;
;; B. Ask other students in the class to let me look over what they have
;;    done and then write my solution.
;;
;; C. Post detailed questions about the problem set on Piazza.
;;
;; D. Only discuss the problem set with one other student, my partner, and
;;    when we submit every submission has both our CWLs.  <<< YES
;;
;; E. Do the problem set entirely alone, consulting only the edX site, the
;;    cs110.students.cs.ubc website, and Piazza.  <<< YES
;;
;; F. Ask detailed questions about similar problem bank problems on Piazza
;;    or any other forum.  <<< YES
