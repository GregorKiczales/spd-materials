#lang racket
(require spd-grader/check-template)
(require spd-grader/grader)
(require spd-grader/walker)
(provide grader)


(define grader
  (lambda ()
    (grade-submission
      (weights (*)
        (grade-problem 1
          (grade-htdf all-labels
            (let* ([htdf  (car (context))]
                   [defns (htdf-defns htdf)]
                   [locs  (cdr (defines defns))]
                   [names (map caadr locs)])
              (weights (*)
                (grade-submitted-tests 2)
                (grade-template-origin (Region ListOfRegion encapsulated))

                (rubric-item 'other (= (length defns) 1) "Only one top-level function")
                (rubric-item 'other (= (length locs) 2)  "With 2 locally defined functions")
                (rubric-item 'other 
                             (and (member (car  names) (free (caddr (cadr locs))))
                                  (member (cadr names) (free (caddr (car  locs)))))
                             "That are in mutual recursion")

                (grade-additional-tests 1
                  (check-expect (all-labels S1) (list "one"))
                  (check-expect (all-labels G4) (list "one" "two" "three" "four" "five" "six")))))))

        (grade-problem 2
          (grade-htdf all-with-color
            (let* ([htdf  (car (context))]
                   [defns (htdf-defns htdf)]
                   [locs  (cdr (defines defns))]
                   [names (map caadr locs)])
              (weights (*)
                (grade-submitted-tests 2)
                (grade-template-origin (Region ListOfRegion encapsulated))

                (rubric-item 'other (= (length defns) 1) "Only one top-level function")
                (rubric-item 'other (= (length locs) 2)  "With 2 locally defined functions")
                (rubric-item 'other
                             (and (member (car  names) (free (caddr (cadr locs))))
                                  (member (cadr names) (free (caddr (car  locs)))))
                             "That are in mutual recursion")
                (grade-additional-tests 1
                  (check-expect (all-with-color "red" S1) (list S1))
                  (check-expect (all-with-color "blue" S1) '())
                  (check-expect (all-with-color "red"
                                                (make-group "blue"
                                                            (list G4
                                                                  (make-single "X" 90 "red"))))
                                (list G1 S1 (make-single "X" 90 "red"))))))))))))

            


  
