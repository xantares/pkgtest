
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <libpsl.h>


int
main (void)
{
  printf("%s\n", psl_get_version());
  return 0;
}
