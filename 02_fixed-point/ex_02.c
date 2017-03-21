#include <math.h>
#include <stdio.h>

typedef char  int8_t;
typedef short int16_t;
typedef int   int32_t;
typedef long long int   int64_t;

// Q15.16
#define iNTEGER_BITS 15
#define FRACTIONAL_BITS 16

int32_t fp2fx(double x, int32_t n)
{
	int32_t y;

	y = (int32_t) round ( x * (1 << n) );

	return y;
}

void main(void)
{	
	double fp1;
	int32_t a;

	fp1 = 34.67854545;

	a = fp2fx(fp1, FRACTIONAL_BITS);
	
	printf("fp1 = %f \n", fp1 );
	printf("a = %d \n", a );
}

