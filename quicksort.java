//https://www.baeldung.com/java-quicksort
import java.util.Arrays;

public class quicksort{
    public static void quickSort(int arr[], int begin, int end) {
        if (begin < end) {
            int partitionIndex = partition(arr, begin, end);
    
            quickSort(arr, begin, partitionIndex-1);
            quickSort(arr, partitionIndex+1, end);
        }
    }
    
    private static int partition(int arr[], int begin, int end) {
        int pivot = arr[end];
        int i = (begin-1);
    
        for (int j = begin; j < end; j++) {
            if (arr[j] <= pivot) {
                i++;
    
                int swapTemp = arr[i];
                arr[i] = arr[j];
                arr[j] = swapTemp;
            }
        }
    
        int swapTemp = arr[i+1];
        arr[i+1] = arr[end];
        arr[end] = swapTemp;
    
        return i+1;
    }

    public static void main(String[] args) {
        int[] array = {76, 32, 21, 44, 21, 90, 1, 11, 61, 81, 92, 3, 5, 2, 8, 38, 63};
        System.out.println("Unsorted Array: \n"+Arrays.toString(array));
        quickSort(array,0,array.length-1);
        System.out.println("Sorted Array: \n"+Arrays.toString(array));
    }
}
