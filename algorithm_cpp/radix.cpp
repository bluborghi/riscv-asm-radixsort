// C++ implementation of Radix Sort 
#include<iostream> 
using namespace std; 

// A utility function to print an array 
void print(int arr[], int n) 
{ 
	for (int i = 0; i < n; i++) 
		cout << arr[i] << " "; 
} 

// A utility function to get maximum value in arr[] 
int getMax(int arr[], int n) 
{ 
	int mx = arr[0]; 
	for (int i = 1; i < n; i++) 
		if (arr[i] > mx) 
			mx = arr[i]; 
	return mx; 
} 

// A function to do counting sort of arr[] according to 
// the digit represented by exp. 
void countSort(int arr[], int n, int exp) 
{ 
	int output[n]; // output array 
	int i, count[10] = {0}; 
	// Store count of occurrences in count[] 
	for (i = 0; i < n; i++) 
		count[ (arr[i]/exp)%10 ]++; 
	// Change count[i] so that count[i] now contains actual 
	// position of this digit in output[] 
	for (i = 1; i < 10; i++) 
		count[i] += count[i - 1]; 
	// Build the output array 
	for (i = n - 1; i >= 0; i--) { 
		count[ (arr[i]/exp)%10 ]--; 
		output[ count[(arr[i]/exp)%10] ] = arr[i]; 
	} 
	// Copy the output array to arr[], so that arr[] now 
	// contains sorted numbers according to current digit 
	for (i = 0; i < n; i++) 
		arr[i] = output[i]; 
} 

// The main function to that sorts arr[] of size n using 
// Radix Sort 
void radixsort(int arr[], int n) 
{ 
	// Find the maximum number 
	// to know number of digits 
	int max = getMax(arr, n); 

	// Do counting sort for every digit.
	// Note that instead of passing digit
	// number, exp is passed. exp is 10^i 
	// where i is current digit number 
	for (int exp = 1; max >= exp; exp *= 10) 
		countSort(arr, n, exp); 
}

// Driver program to test above functions 
int main() 
{ 
	int arr[] = {170, 45, 75, 90, 802, 69, 4, 20}; 
	//int arr[] = {27,552,36}; 
	int n = sizeof(arr)/sizeof(arr[0]); 
	radixsort(arr, n); 
	print(arr, n); 
	cout<<endl;
	return 0; 
} 


