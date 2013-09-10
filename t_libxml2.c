#include "libxml/parser.h"

int main()
{
  printf("%d\n", xmlHasFeature(XML_WITH_THREAD));
  return 0;
}
