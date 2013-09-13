#include <dlfcn.h>
#include <stdio.h> /*for printf() */
#include <stdlib.h> /* for exit() */

#ifndef CURRENT_BINARY_DIR
#error "define CURRENT_BINARY_DIR"
#endif

typedef void (*pf)();
int main()
{
  void *lib;
  pf greet;
  const char * err;

  lib = dlopen(CURRENT_BINARY_DIR "/libhello"
#ifndef WIN32
 ".so"
#else
".dll"
#endif
  , RTLD_NOW);
  

  if (!lib)
  {
    printf("failed to open: %s \n", dlerror());
    exit(1);
  }
  dlerror(); /*first clear any previous error; redundant 
              in this case but a useful habit*/
  greet= (pf) dlsym(lib, "hello");/*locate hello() */
  err=dlerror();/*check for errors and copy error message*/
  if (err)
  {
    printf("failed to locate hello(): %s \n", err);
    exit(1);
  }
  greet(); /*call hello() */
  dlclose(lib); 
  return 0;
}