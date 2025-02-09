#include <stdio.h>
#include "bzlib.h"

int main(argc, argv)
    int argc;
    char *argv[];
{
    const char * version = BZ2_bzlibVersion();
    printf("version: %s\n", version);
    return 0;
}
