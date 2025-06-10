#include <chrono>
#include <thread>

#include <matplot/matplot.h>

int main() {
    using namespace matplot;

    auto [x, y, z] = peaks();
    contourf(x, y, z);

    const bool ok = save("img/contour.ps");
    std::cout << "ok="<<ok<<std::endl;

    std::this_thread::sleep_for(std::chrono::milliseconds(5000));
    return 0;
}
