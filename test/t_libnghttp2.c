
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <nghttp2/nghttp2.h>


int
main (void)
{
  const char * strerr = nghttp2_strerror(0);
  printf("%s\n", strerr);
  return 0;
}
