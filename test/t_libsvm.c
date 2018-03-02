#include <stdio.h>
#include "svm.h"


void my_print(const char *str)
{
  printf("%s\n", str);
}


int main()
{
  svm_set_print_string_function(&my_print);
  printf("LibSVM version %d\n", LIBSVM_VERSION);
  return 0;
}