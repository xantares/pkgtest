#include <stdio.h>
#include "cerf.h"

int main(argc, argv)
    int argc;
    char *argv[];
{
    const double v = voigt(0, 1, 0);
    printf("v: %g\n", v);
    return 0;
}
