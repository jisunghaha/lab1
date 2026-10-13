#include <stdio.h>
#include "calc.h"

int main(void)
{
    double a = 20;
    double b = 4;

    printf("add: %.2f\n", add(a, b));
    printf("subtract: %.2f\n", subtract(a, b));
    printf("multiply: %.2f\n", multiply(a, b));
    printf("divide: %.2f\n", divide(a, b));

    return 0;
}
