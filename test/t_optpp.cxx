/** \example tstLBFGS.C
 *
 * Test program for LBFGS optimization objects
 * 
 * 1. Limited Memory BFGS method with More-Thuente Search on an NLF1
 *
 */

#ifdef HAVE_CONFIG_H
#include "OPT++_config.h"
#endif

#include <fstream>
#ifdef HAVE_STD
#include <cstdio>
#else
#include <stdio.h>
#endif

#include "OptLBFGS.h"
#include "NLF.h"

// #include "tstfcn.h"

using NEWMAT::ColumnVector;

using namespace OPTPP;
void update_model(int, int, ColumnVector) {}


void init_rosen (int ndim, ColumnVector& x)
{
  if (ndim != 2)
  {
    exit (1);
  }
  x(1) = -1.2;
  x(2) =  1.0;
}

void rosen(int mode, int n, const ColumnVector& x, double& fx, ColumnVector& g, int& result)
{ // Rosenbrock's function
  double f1, f2, x1, x2;

  if (n != 2) return;

  x1 = x(1);
  x2 = x(2);
  f1 = (x2 - x1 * x1);
  f2 = 1. - x1;

  if (mode & NLPFunction) {
    fx  = 100.* f1*f1 + f2*f2;
    result = NLPFunction;
  }
  if (mode & NLPGradient) {
    g(1) = -400.*f1*x1 - 2.*f2;
    g(2) = 200.*f1;
    result = NLPGradient;
  }
}


int main ()
{
  int n = 2;
  
  static char *status_file = {"tstLBFGS.out"};

  //  Create a Nonlinear problem object

  NLF1 nlp(n,rosen,init_rosen);
  
  //  Build a LBFGS object and optimize 

  OptLBFGS objfcn(&nlp);   
  objfcn.setUpdateModel(update_model);
  if (!objfcn.setOutputFile(status_file, 0))
    cerr << "main: output file open failed" << endl;
  objfcn.setGradTol(1.e-6);
  objfcn.setMaxBacktrackIter(10);
  objfcn.setPrintFinalX(true);
  objfcn.optimize();
    
  objfcn.printStatus("Solution from LBFGS: More and Thuente's linesearch");

  int ret = 0;
  ColumnVector x_sol = nlp.getXc();
  double f_sol = nlp.getF();
  if ((1.0 - x_sol(1) <= 1.e-2) && (1.0 - x_sol(2) <= 1.e-2) && (f_sol
								 <=
								 1.e-2))
    std::cout << "LBFGS 1 PASSED" << endl;
  else {
    ret = 1;
    std::cout << "LBFGS 1 FAILED" << endl;
  }

  objfcn.cleanup();
  return ret;
}
