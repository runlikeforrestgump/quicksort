(load-option 'format)
(load "ec.scm")
(define (quicksort x)
    (if (= 0 (length x)) '() 
        (append
            (quicksort (delete #f (list-ec (: i (sublist x 1 (length x))) (if (< i (list-ref x 0)) i #f))))
            (list (list-ref x 0))
            (quicksort (delete #f (list-ec (: i (sublist x 1 (length x))) (if (>= i (list-ref x 0)) i #f))))
        )
    )
)
(define test_list (list 4 8 1 6 3 7 2 5))
(format #t "~%Unsorted list: ~a~%" test_list)
(format #t "Sorted list:   ~a~%" (quicksort test_list))