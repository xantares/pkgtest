
#include <cs.h>
typedef CS_INT csi;

int main(int argc, const char * argv[])
{
  cs A;
  int  N = 3;
  double b[]={1,2,3};
  double data[]={1,1,1};
  csi columnIndices[]={0,1,2};
  csi rowIndices[]={0,1,2};
  A.nzmax =3;
  A.m = N;
  A.n = N;
  A.p = &columnIndices[0];
  A.i = &rowIndices[0];
  A.x = &data[0];
  A.nz = 3;

  cs *B = cs_compress(&A);
  int status =  cs_cholsol(0,B,&b[0]);
  printf("status=%d\n", status);
  
  cs_print(&A, 0);
  
  return 0;
}
