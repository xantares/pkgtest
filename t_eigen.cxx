#include<Eigen/Core>
#include <iostream>

int main()
{
  int size = 10;
  // VectorXf is a vector of floats, with dynamic size.
  Eigen::VectorXf u(size), v(size), w(size);
  for (int i = 0; i < size; ++ i) {
    v[i] = 8.*i;
    w[i] = -5.*i+6.;
  }
  u = v + w;
  for (int i = 0; i < size; ++ i) {
    std::cout << u[i] << std::endl;
  }
}
