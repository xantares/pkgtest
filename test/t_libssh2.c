
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <libssh2.h>


int
main (void)
{
  int rc;
  rc = libssh2_init(0);
  printf("%s\n", libssh2_version(0));
  libssh2_exit();
  return 0;
}
