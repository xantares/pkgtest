

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <FreeImage.h>

int
main(int argc, char **argv)
{
  printf("%s\n", FreeImage_GetVersion()) ;
  printf("%s\n", FreeImage_GetCopyrightMessage()) ;
  return 0;
}
