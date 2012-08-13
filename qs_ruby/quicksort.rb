def quicksort(unsorted_list)
    if unsorted_list == []
        return []
    else
        pivot = unsorted_list[0]
        left_partition = unsorted_list[1, unsorted_list.length].find_all{|x| x < pivot}
        lesser = quicksort(left_partition)
        right_partition = unsorted_list[1, unsorted_list.length].find_all{|x| x >= pivot}
        greater = quicksort(right_partition)
        return lesser + [pivot] + greater
    end
    
end

if __FILE__ == $PROGRAM_NAME
    test_list = [4, 8, 1, 6, 3, 7, 2, 5]
    print "Unsorted list: #{test_list}"
    test_list = quicksort(test_list) 
    print "\nSorted list:   #{test_list}\n"
end
