#include <math.h>
#include <stdio.h>

void main(void)
{	
	signed char a, b, c, d, f;
	
	a = 127;
	b = 127;
	
	c = a + b;	
	d = a * b;
	
	f = (-8) >> 1;

	printf("c = %d \n", c );
	printf("d = %d \n", d );
	printf("f = %d \n", f );
}
