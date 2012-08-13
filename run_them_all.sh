#!/bin/bash

echo "==========================================="
echo -e "\nx86 Assembly (GAS syntax)"
time qs_assembly/qs_assembly &> /dev/null

echo -e "\n==========================================="
echo -e "\nC"
time qs_c/qs_c &> /dev/null

echo -e "\n==========================================="
echo -e "\nJava"
time java qs_java/Quicksort &> /dev/null

echo -e "\n==========================================="
echo -e "\nPython"
time python qs_python/quicksort.py &> /dev/null

echo -e "\n==========================================="
echo -e "\nRuby"
time ruby qs_ruby/quicksort.rb &> /dev/null

echo -e "\n==========================================="
echo -e "\nLisp"
cd qs_lisp
time mit-scheme < quicksort.scm &> /dev/null
cd ..

echo -e "\n==========================================="
