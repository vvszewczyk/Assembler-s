#include <stdio.h>

double exec(double *arr, int size)
{
	double licznik=0;
	for(int i=0; i<size; i++)
		licznik+=arr[i];
	return licznik;
}
