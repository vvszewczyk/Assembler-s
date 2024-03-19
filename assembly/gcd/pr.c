#include <stdio.h>
#include <stdlib.h>

unsigned int gcd(unsigned int,unsigned int);

unsigned int a,b,c;

int main(int argc,char** argv)
{

if (argc!=3) return(-1);

a = atoi(argv[1]);
b = atoi(argv[2]);

c=gcd(a,b);

printf("\nGCD(%u,%u) = %u\n",a,b,c);

return(0);
}
