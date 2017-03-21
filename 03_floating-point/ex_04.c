#include <stdio.h>
#include <float.h>
#include <math.h>
#define _GNU_SOURCE 1
#include <fenv.h>
#include <signal.h>
#include <stdlib.h>
     
void fpe_handler(int sig){
	
	if (sig != SIGFPE)
		return;
	
	printf ("UPS! Floating Point Exception \n");
	
	// exit(EXIT_FAILURE);
}

int main(void)
{	
	float a, b, c, d, e, f;
	int ROUND_MODE;

	signal(SIGFPE, fpe_handler);

	feenableexcept(FE_INVALID   | 
				   FE_INEXACT   | 
                   FE_DIVBYZERO | 
                   FE_OVERFLOW  | 
                   FE_UNDERFLOW);
                   
	ROUND_MODE = fegetround();
	printf("Current Round Mode = %d \n", ROUND_MODE );
	
	a = 0.0 / 0.0;
	b = 1.0 / 0.0;
	c = b / b;
	d = a + 1;
	e = b + 1;
	f = a + b;
	
	printf ("a = 0.0 / 0.0 = %f \n", a);
	printf ("b = 1.0 / 0.0 = %f \n", b);
	printf ("c = b / b = %f \n", c);
	printf ("d = a + 1 = %f \n", d);
	printf ("e = b + 1 = %f \n", e);
	printf ("f = a + b = %f \n", f);
	
	exit(EXIT_SUCCESS);
}
