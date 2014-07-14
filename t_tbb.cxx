#include <iostream>
#include <tbb/parallel_reduce.h>
#include <tbb/task_scheduler_init.h>
#include <tbb/blocked_range.h>
#include <tbb/partitioner.h>

static long num_rects = 2e9;

class MyPi {
  double *const my_rects;

public:
  double partialHeight;
  
  MyPi(double * const width) : my_rects(width), partialHeight(0) {}
 
  MyPi(MyPi & x, tbb::split) : my_rects(x.my_rects), partialHeight(0) {}
 
  void operator()(const tbb::blocked_range<size_t> &range) {
    double rectangleWidth = *my_rects;
    for (size_t i=range.begin(); i!=range.end(); ++i) {
      double x = (i + 0.5) * rectangleWidth;
      partialHeight += 4.0/(1. + x*x);
    }
  }
  // join threds and counters
  void join(const MyPi &other) {  
    partialHeight+=other.partialHeight;  
  }


};

int main(int argc, char *argv[])
{
  double area;
  double width = 1./(double)num_rects;
  MyPi my_block((double * const)&width);                    // functor for parallel reduce
  tbb::task_scheduler_init init;        // initiallize TBB task scheduler

  // parallel MC computation of pi 
  tbb::parallel_reduce(tbb::blocked_range<size_t>(0, num_rects), my_block, tbb::auto_partitioner());
  area = my_block.partialHeight * width;
  // print result
  std::cout << "pi = " << area << std::endl;
  return EXIT_SUCCESS;
}


