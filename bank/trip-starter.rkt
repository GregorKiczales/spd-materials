;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname trip-starter) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require spd/tags)

(@assignment bank/compound-p4)
(@cwl ???)

;; =================
;; Data definitions:

(@problem 1)
;; Design a data definition to help travellers plan their next trip. 
;; A trip should specify an origin, destination, mode of transport and 
;; duration (in days).



;; =================
;; Functions:

(@problem 2)
;; You have just found out that you have to use all your days off work 
;; on your next vacation before they expire at the end of the year. 
;; Comparing two options for a trip, you want to take the one that 
;; lasts the longest. Design a function that compares two trips and 
;; returns the trip with the longest duration.
;; 
;; Note that the rule for templating a function that consumes two 
;; compound data parameters is for the template to include all 
;; the selectors for both parameters.
