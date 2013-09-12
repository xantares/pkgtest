
#include <stdlib.h>
#include <stdio.h>
#include <math.h>
#include <string.h>

#include "nlopt.h"


static void listalgs(FILE *f)
{
  int i;
  fprintf(f, "Available algorithms:\n");
  for (i = 0; i < NLOPT_NUM_ALGORITHMS; ++i)
    fprintf(f, "  %2d: %s\n", i, nlopt_algorithm_name((nlopt_algorithm) i));
}


int main(int argc, char **argv)
{
  nlopt_srand_time();
  

  listalgs(stdout);
      
  return EXIT_SUCCESS;
}
