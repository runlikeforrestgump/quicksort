import java.util.List;
import java.util.ArrayList;

public class Quicksort {
    public static void quicksort(List<Integer> unsorted_list) {
        int size = unsorted_list.size();

        if (size > 1) {
            int pivot = unsorted_list.get(0);
            int L_idx = 0;
            int R_idx = size - 1; 

            while (L_idx < R_idx) {
                while (unsorted_list.get(L_idx) < pivot && L_idx < size) {
                    L_idx++;
                }
                while (unsorted_list.get(R_idx) > pivot && R_idx > 0) {
                    R_idx--;
                }
                int temp = unsorted_list.get(L_idx);
                unsorted_list.set(L_idx, unsorted_list.get(R_idx));
                unsorted_list.set(R_idx, temp);
            }
            quicksort(unsorted_list.subList(0, L_idx + 1));
            quicksort(unsorted_list.subList(L_idx + 1, size));
        }
    }

    public static void main(String[] args) {
        List<Integer> test_list = new ArrayList<Integer>();
        test_list.add(4);
        test_list.add(8);
        test_list.add(1);
        test_list.add(6);
        test_list.add(3);
        test_list.add(7);
        test_list.add(2);
        test_list.add(5);
        System.out.println("Unsorted list: " + test_list);
        quicksort(test_list);
        System.out.println("\nSorted list:   " + test_list);
    }
}
