#include <stdio.h>
#include <stdlib.h>

int isNULL(int *tab, int rozmiar)
{
	int ilosc=0;
	for(int i=0; i<rozmiar; i++)
	{
		if(tab[i]==0)
		{
			ilosc+=1;
		}
	}
	return ilosc;
}
