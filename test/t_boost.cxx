#include <string.h>
#include <iostream>
#include <boost/accumulators/accumulators.hpp>
#include <boost/accumulators/statistics/stats.hpp>
#include <boost/accumulators/statistics/mean.hpp>
#include <boost/accumulators/statistics/moment.hpp>
#include <boost/math/special_functions/gamma.hpp>
#include <boost/math/special_functions.hpp>
#include <boost/regex.hpp>
#include <boost/filesystem.hpp>
#include <boost/filesystem/fstream.hpp>
#include <boost/archive/text_oarchive.hpp>
#include <boost/qvm/quat.hpp>
#include <boost/qvm/quat_operations.hpp>
#include <boost/date_time/posix_time/posix_time.hpp>
#include <boost/thread/thread.hpp>
#include <boost/geometry.hpp>
#include <boost/geometry/geometries/point_xy.hpp>
#include <boost/geometry/geometries/polygon.hpp>

using namespace boost::math;
using namespace boost::accumulators;

int main()
{
    // Define an accumulator set for calculating the mean and the
    // 2nd moment ...
    accumulator_set<double, stats<tag::mean, tag::moment<2> > > acc;

    // push in some data ...
    acc(1.2);
    acc(2.3);
    acc(3.4);
    acc(4.5);

    // Display the results ...
    std::cout << "Mean:   " << mean(acc) << std::endl;
    std::cout << "Moment: " << moment<2>(acc) << std::endl;

    // regex
    std::string s = "Boost Libraries";
    boost::regex expr{"\\w+\\s\\w+"};
    std::cout << std::boolalpha << boost::regex_match(s, expr) << '\n';

    // filesystem
    boost::filesystem::path p{"test.txt"};
    boost::filesystem::ofstream ofs{p};
    ofs << "Hello, world!\n";

    // serialization
    boost::archive::text_oarchive oa{std::cout};
    int i = 1;
    oa << i;

    // qvm
    boost::qvm::quat<float> rx = boost::qvm::rotx_quat(3.14159f);
    rx *= 42.0f;

    // date_time/thread
    boost::posix_time::seconds workTime(3);
    boost::this_thread::sleep(workTime);

    // geometry
    boost::geometry::model::d2::point_xy<int> p1(1, 1), p2(2, 2);
    std::cout << "Distance p1-p2 is: " << boost::geometry::distance(p1, p2) << std::endl;
    return 0;
}
