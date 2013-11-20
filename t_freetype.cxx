
#include <ft2build.h>
#include FT_FREETYPE_H
#include FT_STROKER_H

int
main(int argc,
     char **argv)
{
  // Initialize FreeType.
  FT_Library library;
  FT_Init_FreeType(&library);

  // Clean up the library
  FT_Done_FreeType(library);

  return 0;
}

