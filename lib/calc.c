#include <stdio.h>
#include <stdlib.h>
#include "calc.h"

double add(double a, double b)
{
    return a + b;
}

double subtract(double a, double b)
{
    return a - b;
}

double multiply(double a, double b)
{
    return a * b;
}

double divide(double a, double b)
{
    if (b == 0) {
        fprintf(stderr, "Cannot divide by zero.\n");
        exit(EXIT_FAILURE);
    }

    return a / b;
}
