pkgtest
=======

The goal is to test various base packages from a custom toolchain (for example MinGW).

Quickstart
----------

    cd /tmp
    git clone https://github.com/xantares/pkgtest.git
    cd pkgtest
    mkdir build && cd build
    cmake ..
    make -j4
    ctest --output-on-failure -j4

