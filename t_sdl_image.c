#include <stdio.h>
#include <SDL.h>
#include <SDL_image.h>

int main(int argc, char **argv)
{
  int exited=0;
  SDL_Surface *screen, *image;
  SDL_Rect rect;

  if(SDL_Init(SDL_INIT_VIDEO)<0){
    fprintf(stderr,"Couldn't initialise SDL: %s\n",SDL_GetError());
    exit(1);
  }
  atexit(SDL_Quit);
  screen=SDL_SetVideoMode(640,480,16,SDL_SWSURFACE);
  if(screen==NULL){
    fprintf(stderr,"Couldn't set video mode: %s\n",SDL_GetError());
    exit(1);
  }
  image=IMG_Load("../test.jpg");
  if(image==NULL){
    image=IMG_Load("test.jpg");
  }
  if(image==NULL){
    fprintf(stderr,"Couldn't load image\n");
    exit(1);
  }

  if(SDL_SetColorKey(image,SDL_RLEACCEL,SDL_MapRGB(image->format,0,0,0)))
  {
    fprintf(stderr,"Couldn't ser color key: %s\n",SDL_GetError());
    exit(1);
  }
  image=SDL_DisplayFormat(image);
  rect.x=100;rect.y=100;rect.w=image->w;rect.h=image->h;
  SDL_BlitSurface(image,0,screen,&rect);
  SDL_UpdateRects(screen,1,&rect);
  SDL_Delay( 5000 );
  SDL_Quit();
  return 0;
}
