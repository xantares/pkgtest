#include <symengine/expression.h>

using namespace SymEngine;

int main()
{
    const Expression x("x");
    const Expression f_x = x * x;
    const Expression df_dx = f_x.diff(x);

    const auto symb_x = symbol("x");
    const Expression df_dsx = f_x.diff(symb_x);
    std::cout << df_dsx<<std::endl;
    return 0;
}