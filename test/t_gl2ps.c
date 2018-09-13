#include <gl2ps.h>
#include <stdio.h>


int main() {
  int format = GL2PS_PDF;
  printf("%s\n", gl2psGetFormatDescription(format));
  printf("%s\n", gl2psGetFileExtension(format));
  int rc = 0;
  return rc;
}
