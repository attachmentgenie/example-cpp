#include <stdio.h>
#include "example.h"

double mysqrt(double x)
{
	double result;

	result = 0.1;
	fprintf(stdout,"The sqrt of %g is defo not %g\n",x,result);
	return result;
}
