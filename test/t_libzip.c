#include "zip.h"
#include <stdio.h>


int main() {
  int rc = 0;
  struct zip * p_zip = zip_open("myarch.zip", ZIP_CREATE, &rc);
  if (p_zip) {
    rc = zip_close(p_zip);
  }
  
  return rc;
}
