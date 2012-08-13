#include <stdio.h>

int quicksort(int *unsorted_list, int size) {

    /* Base case: nothing left to partition. */
    if (size < 2) {
        return 0;
    }
    else {
        /* First, select a pivot. */
        int pivot = unsorted_list[0];
        /* Set the left pointer to the leftmost index, which will
           always be 0. */
        int L_idx = 0;
        /* Set the right pointer to the rightmost index, which will
           always be the size of the array - 1. */
        int R_idx = size - 1;
        /* Swap elements until the L and R idx collide. */
        while (L_idx < R_idx) {
            /* Increment L_idx until its value is greater than pivot. */
            while (unsorted_list[L_idx] < pivot && L_idx < size) {
                L_idx++;
            }
            /* Decrement R_idx until its value is less than pivot. */
            while (unsorted_list[R_idx] > pivot && R_idx > 0) {
                R_idx--; 
            }
            /* Swap the left and right elements. */
            int temp = unsorted_list[L_idx];
            unsorted_list[L_idx] = unsorted_list[R_idx];
            unsorted_list[R_idx] = temp;
        }
        /* Sort the left partition. */
        quicksort(unsorted_list, L_idx);
        /* Sort the right partition. */
        quicksort(&unsorted_list[L_idx + 1], size - L_idx - 1);
        
        return 0;
    }
} 

int print_list(int *list, int size) {
    int i = 0;

    for (i = 0; i < size; i++) {
        printf("%d ", list[i]);
    }

    printf("\n");

    return 0;
}

int main(void) {
    int list_size = 8;
    int test_list[] = {4, 8, 1, 6, 3, 7, 2, 5};
    printf("Unsorted list: ");
    print_list(test_list, list_size);
    quicksort(test_list, list_size);
    printf("\nSorted list:   ");
    print_list(test_list, list_size);

    return 0;
}
