#include <iostream>

using namespace std;

int CheckSumPossibility(int , int [], int );



int main()
{
    int arraySize;
    int num;
    cout << "Please enter size of the array: ";
    cin >> arraySize;
    cout << "Plese enter the target number: ";
    cin >> num;
    
    int* arr = new int[num];		// bonus
    
    for(int i=0; i<arraySize; i++){
        
        cin >> arr[i];
    
    }
    
    cout << "Result is: ";
    
    int returnVal = CheckSumPossibility( num, arr, arraySize);

    if(returnVal == 1){
        cout << "are the elements gives summation. Possible!" << endl;
    }
    else{
        cout << "Not possible!" << endl;
    }

    return 0;
}


int CheckSumPossibility(int num, int arr[], int size){
    
    if( num == 0)
        return 1;
    
    if( size ==  0)
        return 0;
     
    if( num < 0)
        return 0;
    
    int curr = arr[size-1];
    
    if ( curr > num)
        return CheckSumPossibility(num, arr, size-1);
        
    int returnValue = CheckSumPossibility(num-curr, arr, size-1);
    
    if(returnValue == 0 )
        returnValue = CheckSumPossibility(num, arr, size-1);
    else
        cout << curr << " ";
        
    return returnValue;
        
    
}
