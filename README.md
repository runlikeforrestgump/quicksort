# Quicksort #

Quicksort sorts and partitions a list recursively, which is the opposite of what merge sort does (merge sort partitions a list and then sorts). A pivot (i.e., a randomly selected value from the list) is used to control sorting and partitioning: all other values in the list are compared against the pivot. Each partition selects its own pivot. The list is sorted such that all the values to the left of the pivot are less than or equal to it, and all the values to the right of the pivot are greater than or equal to it.

As an exercise, I implemented the quicksort algorithm in the following programming languages:
* C;
* Java;
* Lisp (MIT Scheme);
* Python;
* Ruby;
* and x86 Assembly (GAS syntax).

## Performance ##

* C

        real    0m0.002s
        user    0m0.004s
        sys     0m0.000s

* Java

        real    0m0.246s
        user    0m0.196s
        sys     0m0.052s

* Lisp (MIT Scheme)

        real    0m0.703s
        user    0m0.644s
        sys     0m0.064s

* Python

        real    0m0.021s
        user    0m0.012s
        sys     0m0.008s

* Ruby

        real    0m0.011s
        user    0m0.000s
        sys     0m0.008s

* x86 Assembly (GAS syntax)

        real    0m0.002s
        user    0m0.004s
        sys     0m0.000s
