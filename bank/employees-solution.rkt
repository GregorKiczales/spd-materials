;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname employees-solution) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require spd/tags)

(@assignment bank/htdd-p1)
(@cwl ???)

;; =================
;; Data definitions:

(@problem 1)
;; You work in the Human Resources department at a ski lodge. 
;; Because the lodge is busier at certain times of year, 
;; the number of employees fluctuates. 
;; There are always more than 10, but the maximum is 50.
;; 
;; Design a data definition to represent the number of ski lodge employees. 
;; Call it Employees.


(@htdd Employees)
;; Employees is Natural
;; interp. range of employees working at a ski lodge at one time
;; CONSTRAINT: Employees are restricted to (10, 50]
(define E1 11)
(define E2 40)
(define E3 50)

(@dd-template-rules atomic-non-distinct) ;Natural

#;
(define (fn-for-employees e)
  (... e)) 



;; =================
;; Functions:

(@problem 2)
;; Now design a function that will calculate the total payroll for the quarter.
;; Each employee is paid $1,500 per quarter. Call it calculate-payroll.


(@htdf calculate-payroll)
(@signature Employees -> Natural)
;; calculates the ski lodge's payroll based on $1,500/employee
(check-expect (calculate-payroll  E1) 16500)
(check-expect (calculate-payroll  E2) 60000)
(check-expect (calculate-payroll  E3) 75000)    

;(define (calculate-payroll e) 0)  ;stub

(@template-origin Employees)

(@template
 (define (calculate-payroll e)
   (... e)))

(define (calculate-payroll e)
  (* e 1500))
