def quicksort(unsorted_list):
    # Base case: nothing left to partition, so return an empty list,
    # and don't make a recursive call.
    if unsorted_list == []:
        return []
    else:
        # First, select a pivot.
        pivot = unsorted_list[0]
        # Retrieve all the values less than the pivot to create the
        # left partition.
        L_partition = [x for x in unsorted_list[1:] if x < pivot]
        # Sort the left partition.
        lesser = quicksort(L_partition)
        # Retrieve all the values greater than or equal to the pivot to
        # create the right partition.
        R_partition = [x for x in unsorted_list[1:] if x >= pivot]
        # Sort the right partition.
        greater = quicksort(R_partition)
        # Return the sorted list.
        return lesser + [pivot] + greater

if __name__ == "__main__":
    test_list = [4, 8, 1, 6, 3, 7, 2, 5]
    print "Unsorted list: ",
    print test_list
    test_list = quicksort(test_list)
    print "\nSorted list:   ",
    print test_list 
