#include <iostream>

#include "armadillo"

using namespace arma;
using namespace std;


int main(int argc, char** argv)
  {
mat A = randu<mat>(50,50);
    mat B = trans(A)*A; // generate a symmetric matrix

    vec eigval;
    mat eigvec;

    // use standard algorithm by default
    eig_sym(eigval, eigvec, B);

    // use divide & conquer algorithm
    eig_sym(eigval, eigvec, B, "dc");
    return 0;
  }

