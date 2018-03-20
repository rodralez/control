#include <math.h>
#include <stdio.h>
#include <stdint.h>

void main(void)
{	
	signed char a, b;
	
	int16_t c, d, s1, s2, s3;
	
	a = 127;
	b = 127;
	
	c = (int16_t) (a + b) ;	
	d = (int16_t) a * (int16_t) b ;
	
	s1 = (int16_t) ((-8) >> 2);
	s2 = (int16_t) ((-1) >> 5);

	s3 = (int16_t) ((-8) << 5);

	printf("c = %d \n", c );
	printf("d = %d \n", d );
	printf("s1 = %d \n", s1 );
	printf("s2 = %d \n", s2 );
	printf("s3 = %d \n", s3 );
}
