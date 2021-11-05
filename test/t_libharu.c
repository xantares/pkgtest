#include <stdio.h>
#include <stdlib.h>
#include <hpdf.h>

int main (int argc, char** argv)
{
  printf("haru version=%s\n", HPDF_GetVersion());
  return 0;
};
