cmake_minimum_required (VERSION 3.5)

if (NOT DEFINED CMAKE_BUILD_TYPE)
  set(CMAKE_BUILD_TYPE RelWithDebInfo CACHE STRING "Build type")
endif ()

project (pkgtest)

if (POLICY CMP0020)
  cmake_policy (SET CMP0020 NEW)
endif ()

if (POLICY CMP0072)
  cmake_policy (SET CMP0072 NEW)
endif ()

if (POLICY CMP0076)
  cmake_policy (SET CMP0076 NEW)
endif ()

option(USE_FORTRAN "fortran" ON)
if (USE_FORTRAN)
  enable_language(Fortran)
endif ()

list (APPEND CMAKE_MODULE_PATH ${CMAKE_SOURCE_DIR}/cmake)

enable_testing ()


macro (add_pkgtest PKGNAME)
  set (_EXT .c)
  set (_INCLUDES)
  set (_LIBS)
  set (_CMD)
  foreach (_ARG ${ARGN})
    if (${_ARG} MATCHES EXT)
      set (_CMD EXT)
    elseif (${_ARG} MATCHES INCLUDES)
      set (_CMD INCLUDES)
    elseif (${_ARG} MATCHES LIBS)
      set (_CMD LIBS)
    else ()
      if (${_CMD} MATCHES EXT)
        set (_EXT ${_ARG})
      elseif (${_CMD} MATCHES INCLUDES)
        list (APPEND _INCLUDES  ${_ARG})
      elseif (${_CMD} MATCHES LIBS)
        list (APPEND _LIBS  ${_ARG})
      endif ()
    endif ()
  endforeach()

  add_executable (t_${PKGNAME} test/t_${PKGNAME}${_EXT})
  target_link_libraries (t_${PKGNAME} ${_LIBS})
  target_include_directories(t_${PKGNAME} PUBLIC ${_INCLUDES})

  install (TARGETS t_${PKGNAME} DESTINATION bin)
  add_test (NAME t_${PKGNAME} COMMAND t_${PKGNAME})
endmacro()


option (USE_COIN "coin" ON)
if (USE_COIN)
  find_package (COIN)
endif ()
if (COIN_FOUND)
  add_pkgtest (coin EXT .cxx INCLUDES ${COIN_INCLUDE_DIRS} LIBS ${COIN_BONMIN_LIBRARIES})
  target_sources (t_coin  PRIVATE test/MyTMINLP.cpp)
endif ()


option (USE_AGG "agg" OFF)
if (USE_AGG)
  find_package (AGG)
endif ()
if (AGG_FOUND)
  add_pkgtest (agg EXT .cxx INCLUDES ${AGG_INCLUDE_DIRS} LIBS "${AGG_LIBRARIES}")
endif ()

option (USE_ARPACK "arpack" ON)
if (USE_ARPACK)
  find_package (arpack-ng MODULE)
endif ()
if (arpack-ng_FOUND)
  add_pkgtest (arpack EXT .cxx INCLUDES ${arpack_ng_INCLUDE_DIRS} LIBS "${arpack_ng_LIBRARIES}")
endif()

option(USE_PUGIXML "pygixml" ON)
if (USE_PUGIXML)
  find_package(pugixml)
endif ()
if (pugixml_FOUND)
  add_pkgtest (pugixml EXT .cxx LIBS pugixml)
endif ()


option (USE_AGRUM "agrum" ON)
if (USE_AGRUM)
  find_package (aGrUM)
endif ()
if (aGrUM_FOUND)
  add_pkgtest (agrum EXT .cxx INCLUDES ${AGRUM_INCLUDE_DIRS} LIBS ${AGRUM_LIBRARIES_RELEASE})
endif ()


option (USE_ARMADILLO "armadillo" ON)
if (USE_ARMADILLO)
  find_package (Armadillo)
endif ()
if (ARMADILLO_FOUND)
  add_pkgtest (armadillo EXT .cxx INCLUDES ${ARMADILLO_INCLUDE_DIRS} LIBS ${ARMADILLO_LIBRARIES})
endif ()


option (USE_ASMJIT "asmjit" ON)
if (USE_ASMJIT)
  find_package (AsmJit)
endif ()
if (ASMJIT_FOUND)
  add_pkgtest (asmjit EXT .cxx INCLUDES ${ASMJIT_INCLUDE_DIRS} LIBS ${ASMJIT_LIBRARIES})
endif ()


option (USE_ASSIMP "assimp" OFF)
if (USE_ASSIMP)
  find_package (Assimp NO_MODULE)
  if (ASSIMP_INCLUDE_DIRS AND ASSIMP_LIBRARIES)
    set (ASSIMP_FOUND TRUE)
  endif ()
endif ()
if (ASSIMP_FOUND)
  add_pkgtest (assimp EXT .cxx INCLUDES ${ASSIMP_INCLUDE_DIRS} LIBS ${ASSIMP_LIBRARIES})
endif ()


option (USE_BLAS "blas" ON)
if (USE_BLAS)
  find_package (BLAS)
endif ()
if (BLAS_FOUND)
  add_pkgtest (blas EXT .f90 LIBS ${BLAS_LIBRARIES})
endif ()


option (USE_BULLET "bullet" ON)
if (USE_BULLET)
  find_package (Bullet)
endif ()
if (BULLET_FOUND)
  add_pkgtest (bullet EXT .cxx INCLUDES ${BULLET_INCLUDE_DIRS} LIBS ${BULLET_LIBRARIES})
endif ()


option (USE_BOX2D "box2d" ON)
if (USE_BOX2D)
  find_package (Box2D)
endif ()
if (BOX2D_FOUND)
  add_pkgtest (box2d EXT .cxx INCLUDES ${BOX2D_INCLUDE_DIR} LIBS ${BOX2D_LIBRARY})
endif ()


option(USE_CERES "ceres" ON)
if (USE_CERES)
  find_package (Ceres NO_MODULE)
endif ()
if (Ceres_FOUND)
  add_pkgtest (ceres EXT .cxx INCLUDES ${CERES_INCLUDE_DIRS} LIBS ${CERES_LIBRARIES})
endif ()


option(USE_CGAL "cgal" ON)
if (USE_CGAL)
  find_package (CGAL NO_MODULE)
endif ()
if (CGAL_FOUND)
  add_pkgtest (cgal EXT .cxx INCLUDES ${CGAL_INCLUDE_DIRS} LIBS ${CGAL_LIBRARY} ${CGAL_3RD_PARTY_LIBRARIES} ${GMP_LIBRARIES})
endif ()


option (USE_CONFUSE "confuse" ON)
if (USE_CONFUSE)
  find_package (Confuse)
endif ()
if (CONFUSE_FOUND)
  add_pkgtest (confuse INCLUDES ${CONFUSE_INCLUDE_DIRS} LIBS ${CONFUSE_LIBRARIES})
endif ()


option (USE_CXSPARSE "cxsparse" ON)
if (USE_CXSPARSE)
  find_package (CXSparse)
endif ()
if (CXSparse_FOUND)
  add_pkgtest (cxsparse INCLUDES ${CXSPARSE_INCLUDE_DIRS} LIBS ${CXSPARSE_LIBRARIES})
endif ()

option (USE_EIGEN "eigen" ON)
if (USE_EIGEN)
  find_package (Eigen)
endif ()
if (EIGEN_FOUND)
  add_pkgtest (eigen EXT .cxx INCLUDES ${EIGEN_INCLUDE_DIRS})
endif ()


option (USE_EXPAT "expat" ON)
if (USE_EXPAT)
  find_package (EXPAT)
endif ()
if (EXPAT_FOUND)
  add_pkgtest (expat INCLUDES ${EXPAT_INCLUDE_DIRS} LIBS ${EXPAT_LIBRARIES})
endif ()


option (USE_EXPRTK "exprtk" ON)
if (USE_EXPRTK)
  find_package (ExprTk)
endif ()
if (EXPRTK_FOUND)
  add_pkgtest (exprtk EXT .cxx INCLUDES ${EXPRTK_INCLUDE_DIRS})
  if (MINGW)
    # avoid assembler t_exprtk.cxx.obj: too many sections
    set_source_files_properties (test/t_exprtk.cxx PROPERTIES COMPILE_FLAGS "-Wa,-mbig-obj -g0")
  endif ()
endif ()


option (USE_FANN "fann" ON)
if (USE_FANN)
  find_package (FANN)
endif ()
if (FANN_FOUND)
  if (NOT ${CMAKE_CURRENT_SOURCE_DIR} STREQUAL ${CMAKE_CURRENT_BINARY_DIR})
    execute_process(COMMAND ${CMAKE_COMMAND} -E create_symlink ${CMAKE_CURRENT_SOURCE_DIR}/parity8.train ${CMAKE_CURRENT_BINARY_DIR}/parity8.train)
    execute_process(COMMAND ${CMAKE_COMMAND} -E create_symlink ${CMAKE_CURRENT_SOURCE_DIR}/parity8.test ${CMAKE_CURRENT_BINARY_DIR}/parity8.test) 
  endif ()
  add_pkgtest (fann INCLUDES ${FANN_INCLUDE_DIRS} LIBS ${FANN_LIBRARIES})
endif ()


option (USE_FFTW "fftw" ON)
if (USE_FFTW)
  find_package (FFTW)
endif ()
if (FFTW_FOUND)
  add_pkgtest (fftw INCLUDES ${FFTW_INCLUDE_DIRS} LIBS ${FFTW_LIBRARIES})
endif ()


option (USE_FREEGLUT "freeglut" ON)
if (USE_FREEGLUT)
  find_package (FREEGLUT)
  find_package (OpenGL)
endif ()
if (FREEGLUT_FOUND)
  add_pkgtest (freeglut INCLUDES ${FREEGLUT_INCLUDE_DIRS} LIBS ${FREEGLUT_LIBRARIES} ${OPENGL_LIBRARIES})
endif ()


option (USE_FREEIMAGE "freeimage" ON)
if (USE_FreeImage)
  find_package (FreeImage)
endif ()
if (FreeImage_FOUND)
  add_pkgtest (freeimage INCLUDES ${FreeImage_INCLUDE_DIRS} LIBS ${FreeImage_LIBRARIES})
endif ()


option (USE_FREETYPE "freetype" ON)
if (USE_FREETYPE)
  find_package (Freetype)
endif ()
if (FREETYPE_FOUND)
  add_pkgtest (freetype EXT .cxx INCLUDES ${FREETYPE_INCLUDE_DIRS} LIBS ${FREETYPE_LIBRARIES})
endif ()


option (USE_GLEW "glew" ON)
if (USE_GLEW)
  find_package (GLEW)
  find_package (Qt5OpenGL NO_MODULE)
  find_package (OpenGL)
endif ()
if (GLEW_FOUND AND Qt5OpenGL_FOUND)
  add_pkgtest (glew EXT .cxx INCLUDES ${Qt5OpenGL_INCLUDE_DIRS} ${GLEW_INCLUDE_DIRS} LIBS GLEW::glew ${OPENGL_LIBRARIES} ${Qt5OpenGL_LIBRARIES})
  qt5_wrap_cpp (GLEW_MOC test/widget.h)
  target_sources(t_glew PUBLIC test/widget.cpp ${GLEW_MOC})
endif ()


option (USE_GLOG "glog" OFF)
if (0 AND USE_GLOG)
  find_package (GLOG NO_MODULE)
  if (GLOG_FOUND)
    add_pkgtest (glog EXT .cxx INCLUDES ${GLOG_INCLUDE_DIRS}LIBS glog::glog)
  endif ()
endif ()


option (USE_GL2PS "gl2ps" ON)
if (USE_GL2PS)
  find_package (GL2PS)
endif ()
if (GL2PS_FOUND)
  add_pkgtest (gl2ps INCLUDES ${GL2PS_INCLUDE_DIRS} LIBS ${GL2PS_LIBRARIES})
endif ()


option (USE_HDF5 "hdf5" ON)
if (USE_HDF5)
  # hdf5 was compiled using cmake and provides cmake config files
  find_package (HDF5 COMPONENTS CXX NO_MODULE)
endif ()
if (HDF5_FOUND)
  add_pkgtest (hdf5 INCLUDES ${HDF5_INCLUDE_DIR} LIBS hdf5)
  add_pkgtest (hdf5cpp EXT .cxx INCLUDES ${HDF5_INCLUDE_DIR} LIBS hdf5 hdf5_cpp)
else ()
  # hdf5 was compiled using autotools
  if (USE_HDF5)
    find_package (HDF5 COMPONENTS CXX)
  endif ()
  if (HDF5_FOUND)
    add_pkgtest (hdf5 INCLUDES ${HDF5_INCLUDE_DIRS} LIBS ${HDF5_LIBRARIES})
    add_pkgtest (hdf5cpp EXT .cxx INCLUDES ${HDF5_INCLUDE_DIRS} LIBS ${HDF5_LIBRARIES})
    target_compile_definitions (t_hdf5cpp PRIVATE ${HDF5_DEFINITIONS})
  endif ()
endif ()


option (USE_HMAT "hmat" ON)
if (USE_HMAT)
  find_package (HMAT NO_MODULE)
endif ()
if (HMAT_FOUND)
  add_pkgtest (hmat INCLUDES ${HMAT_INCLUDE_DIRS} LIBS ${HMAT_LIBRARIES})
endif ()


option (USE_ICONV "iconv" ON)
if (USE_ICONV)
  find_package (Iconv)
endif ()
if (ICONV_FOUND)
  add_pkgtest (iconv INCLUDES ${ICONV_INCLUDE_DIR} LIBS ${ICONV_LIBRARIES})
endif ()


option (USE_JPEG "jpeg" ON)
if (USE_JPEG)
  find_package (JPEG)
endif ()
if (JPEG_FOUND)
  if (NOT ${CMAKE_CURRENT_SOURCE_DIR} STREQUAL ${CMAKE_CURRENT_BINARY_DIR})
    execute_process(COMMAND ${CMAKE_COMMAND} -E create_symlink ${CMAKE_CURRENT_SOURCE_DIR}/test.jpg ${CMAKE_CURRENT_BINARY_DIR}/test.jpg)
  endif ()
  add_pkgtest (jpeg INCLUDES ${JPEG_INCLUDE_DIRS} LIBS ${JPEG_LIBRARIES})
endif ()


option (USE_JSONCPP "jsoncpp" ON)
if (USE_JSONCPP)
  find_package (jsoncpp NO_MODULE)
endif ()
if (jsoncpp_FOUND)
  add_pkgtest (jsoncpp EXT .cxx INCLUDES ${JSONCPP_INCLUDE_DIRS} LIBS jsoncpp_lib)
endif ()


option (USE_LIBDL "libdl" ON)
if (USE_LIBDL)
  find_package (Libdl)
endif ()
if (LIBDL_FOUND)
  add_definitions(-DCURRENT_BINARY_DIR="${CMAKE_CURRENT_BINARY_DIR}")
  add_library(hello SHARED hello.c)
  add_pkgtest (libdl INCLUDES ${LIBDL_INCLUDE_DIR} LIBS ${LIBDL_LIBRARIES})
endif ()


option (USE_LAPACK "lapack" ON)
if (USE_LAPACK)
  find_package (BLAS)
  find_package (LAPACK)
endif ()
if (LAPACK_FOUND)
  add_pkgtest (lapack EXT .f90 LIBS ${BLAS_LIBRARIES} ${LAPACK_LIBRARIES})
endif ()


option (USE_LIBBACKTRACE "libbacktrace" ON)
if (USE_LIBBACKTRACE)
  find_package (LibBacktrace)
endif ()
if (LibBacktrace_FOUND)
  add_pkgtest (backtrace INCLUDES ${LIBBACKTRACE_INCLUDE_DIRS} LIBS ${LIBBACKTRACE_LIBRARIES})
  if (CMAKE_CXX_COMPILER_ID STREQUAL "GNU")
    target_compile_options (t_backtrace PRIVATE "-g;-no-pie;-fno-inline")
  endif ()
endif ()


option (USE_LIBCMAES "libcmaes" ON)
if (USE_LIBCMAES)
  find_package (LibCmaes)
endif ()
if (LibCmaes_FOUND)
  add_pkgtest (libcmaes EXT .cxx INCLUDES ${LIBCMAES_INCLUDE_DIR} LIBS ${LIBCMAES_LIBRARIES} -fopenmp)
endif ()


option (USE_LIBHARU "libharu" ON)
if (USE_LIBHARU)
  find_package(LibHaru)
endif ()
if (LibHaru_FOUND)
  add_pkgtest (libharu INCLUDES ${LibHaru_INCLUDE_DIRS} LIBS ${LibHaru_LIBRARIES})
endif ()


option (USE_LIBXML2 "libxml2" ON)
if (USE_LIBXML2)
  find_package (LibXml2)
endif ()
if (LIBXML2_FOUND)
  add_pkgtest (libxml2 INCLUDES ${LIBXML2_INCLUDE_DIR} LIBS ${LIBXML2_LIBRARIES})
endif ()


option (USE_LIBSVM "libsvm" ON)
if (USE_LIBSVM)
  find_package (LibSVM)
endif ()
if (LIBSVM_FOUND)
  add_pkgtest (libsvm INCLUDES ${LIBSVM_INCLUDE_DIRS} LIBS ${LIBSVM_LIBRARIES})
endif ()


option (USE_LIBUSB "libusb" ON)
if (USE_LIBUSB)
  find_package (LibUSB)
endif ()
if (LibUSB_FOUND)
  add_pkgtest (libusb INCLUDES ${LIBUSB_INCLUDE_DIR} LIBS ${LIBUSB_LIBRARIES})
endif ()


option (USE_LIBFTDI "libFTDI" ON)
if (USE_LIBFTDI)
  find_package (LibFTDI1 NO_MODULE)
endif ()
if (LIBFTDI_FOUND)
  add_pkgtest (libftdi INCLUDES ${LIBFTDI_INCLUDE_DIRS} LIBS ${LIBFTDI_LIBRARIES})
endif ()


option (USE_LLVM "llvm" ON)
if (USE_LLVM)
  find_package (LLVM CONFIG)
endif ()
if (LLVM_FOUND)
  message(STATUS "Found LLVM ${LLVM_PACKAGE_VERSION}")
  llvm_map_components_to_libnames (LLVM_LIBRARIES core ExecutionEngine Interpreter MC MCJIT Support nativecodegen)
  add_pkgtest (llvm EXT .cxx INCLUDES ${LLVM_INCLUDE_DIRS} LIBS ${LLVM_LIBRARIES})
  target_compile_definitions (t_llvm PRIVATE ${LLVM_DEFINITIONS})
  target_include_directories (t_llvm PRIVATE ${LLVM_INCLUDE_DIRS})
endif ()


option (USE_LPSOLVE "lpsolve" ON)
if (USE_LPSOLVE)
  find_package (LpSolve)
endif ()
if (LPSOLVE_FOUND)
  add_pkgtest (lpsolve INCLUDES ${LPSOLVE_INCLUDE_DIRS} LIBS ${LPSOLVE_LIBRARIES})
endif ()


option (USE_MINIZIP "minizip" ON)
if (USE_MINIZIP)
  find_package (MiniZip)
endif ()
if (MiniZip_FOUND)
  add_pkgtest (minizip INCLUDES ${MINIZIP_INCLUDE_DIRS} LIBS ${MINIZIP_LIBRARIES})
endif ()


option (USE_MUPARSER "muParser" ON)
if (USE_MUPARSER)
  find_package (muParser)
endif ()
if (muParser_FOUND)
  add_pkgtest (muparser EXT .cxx INCLUDES ${MUPARSER_INCLUDE_DIRS} LIBS ${MUPARSER_LIBRARIES})
endif ()


option (USE_MUMPS "MUMPS" ON)
if (USE_MUMPS)
  find_package (MUMPS)
endif ()
if (MUMPS_FOUND)
  add_pkgtest (mumps INCLUDES ${MUMPS_INCLUDE_DIRS} LIBS ${MUMPS_LIBRARIES})
endif ()


option (USE_NAUTY "nauty" ON)
if (USE_NAUTY)
  find_package (NAUTY)
endif ()
if (NAUTY_FOUND)
  add_pkgtest (nauty LIBS ${NAUTY_LIBRARIES} INCLUDES ${NAUTY_INCLUDE_DIRS})
endif ()


option (USE_NETCDF "netcdf" ON)
if (USE_NETCDF)
  find_package (netCDF NO_MODULE)
endif ()
if (netCDF_FOUND)
  add_pkgtest (netcdf LIBS netcdf)
endif ()

option (USE_NLOPT "nlopt" ON)
if (USE_NLOPT)
  find_package (NLopt)
endif ()
if (NLOPT_FOUND)
  add_pkgtest (nlopt EXT .cxx INCLUDES ${NLOPT_INCLUDE_DIRS} LIBS ${NLOPT_LIBRARIES})
endif ()

option (USE_OPENCV "opencv" ON)
if (USE_OPENCV)
  find_package (OpenCV COMPONENTS opencv_core opencv_highgui opencv_imgproc opencv_imgcodecs)
endif ()
if (OPENCV_CORE_FOUND AND OPENCV_HIGHGUI_FOUND AND OPENCV_IMGPROC_FOUND AND OPENCV_IMGCODECS_FOUND)
  if (NOT ${CMAKE_CURRENT_SOURCE_DIR} STREQUAL ${CMAKE_CURRENT_BINARY_DIR})
    execute_process(COMMAND ${CMAKE_COMMAND} -E create_symlink ${CMAKE_CURRENT_SOURCE_DIR}/test.jpg ${CMAKE_CURRENT_BINARY_DIR}/lena.jpg)
  endif ()
  add_pkgtest (opencv EXT .cxx INCLUDES ${OpenCV_INCLUDE_DIRS} LIBS ${OpenCV_LIBS})
endif ()


option (USE_OPENMESH "openmesh" ON)
if (USE_OPENMESH)
  find_package (OpenMesh)
endif ()
if (OPENMESH_FOUND)
  add_pkgtest (openmesh EXT .cxx INCLUDES ${OPENMESH_INCLUDE_DIRS} LIBS ${OPENMESH_LIBRARIES})
endif ()


option (USE_OPENMP "openmp" ON)
if (USE_OPENMP)
  find_package (OpenMP)
endif ()
if (OPENMP_FOUND)
  set (CMAKE_C_FLAGS "${OpenMP_C_FLAGS} ${CMAKE_C_FLAGS}")
  add_pkgtest (openmp)
endif ()


option (USE_OPENSSL "openssl" ON)
if (USE_OPENSSL)
  find_package (OpenSSL)
endif ()
if (OPENSSL_FOUND)
  add_pkgtest (openssl INCLUDES ${OPENSSL_INCLUDE_DIRS} LIBS ${OPENSSL_LIBRARIES})
endif ()


option (USE_PAGMO "pagmo" ON)
if (USE_PAGMO)
  find_package (pagmo)
endif ()
if (pagmo_FOUND)
  add_pkgtest (pagmo EXT .cxx LIBS Pagmo::pagmo)
endif ()


option (USE_PROJ "proj" ON)
if (USE_PROJ)
  find_package (LibPROJ)
endif ()
if (LibPROJ_FOUND)
  add_pkgtest (proj EXT .cxx LIBS ${LibPROJ_LIBRARIES})
endif ()


option (USE_REGEX "regex" ON)
if (USE_REGEX)
  find_package (Regex)
endif ()
if (REGEX_FOUND)
  add_pkgtest (regex INCLUDES ${REGEX_INCLUDE_DIR} LIBS ${REGEX_LIBRARIES})
endif ()


option (USE_ZLIB "zlib" ON)
if (USE_ZLIB)
  find_package (ZLIB)
endif ()
if (ZLIB_FOUND)
  add_pkgtest (zlib  INCLUDES ${ZLIB_INCLUDE_DIRS} LIBS ${ZLIB_LIBRARIES})
endif ()

option(USE_LIBZIP "libzip" on)
if (USE_LIBZIP)
  find_package(LibZip)
endif ()
if (LibZip_FOUND)
  add_pkgtest(libzip INCLUDES ${LIBZIP_INCLUDE_DIRS} LIBS ${LIBZIP_LIBRARIES})
endif()

option (USE_TBB "tbb" ON)
if (USE_TBB)
  find_package (TBB CONFIG)
endif ()
if (TBB_FOUND)
  add_pkgtest (tbb EXT .cxx INCLUDES ${TBB_INCLUDE_DIRS} LIBS TBB::tbb)
endif ()


option (USE_BOOST "boost" ON)
if (USE_BOOST)
  find_package (Boost COMPONENTS regex filesystem serialization date_time thread)
  if (TARGET Boost::regex)
    set (Boost_LIBRARIES Boost::regex Boost::filesystem Boost::serialization Boost::date_time Boost::thread)
  endif ()
endif ()
if (Boost_FOUND)
  add_pkgtest (boost EXT .cxx INCLUDES ${Boost_INCLUDE_DIRS} LIBS ${Boost_LIBRARIES})
  target_compile_definitions(t_boost PRIVATE BOOST_ERROR_CODE_HEADER_ONLY)
endif ()


option (USE_READLINE "readline" OFF)
if (USE_READLINE)
  find_package (Readline)
endif ()
if (READLINE_FOUND)
  add_pkgtest (readline INCLUDES ${Readline_INCLUDE_DIRS} LIBS ${Readline_LIBRARIES})
endif ()


option(USE_PYTHON "python" ON)
if (USE_PYTHON)
  find_package(PythonLibs)
endif()
if (PYTHONLIBS_FOUND)
  add_pkgtest (python INCLUDES ${PYTHON_INCLUDE_DIR} LIBS ${PYTHON_LIBRARIES})
endif()


option(USE_PNG "png" ON)
if (USE_PNG)
  find_package(PNG)
endif()
if (PNG_FOUND)
  if (NOT ${CMAKE_CURRENT_SOURCE_DIR} STREQUAL ${CMAKE_CURRENT_BINARY_DIR})
    execute_process(COMMAND ${CMAKE_COMMAND} -E create_symlink ${CMAKE_CURRENT_SOURCE_DIR}/test.png ${CMAKE_CURRENT_BINARY_DIR}/test.png)
  endif ()
  add_pkgtest (png INCLUDES ${PNG_INCLUDE_DIR} LIBS ${PNG_LIBRARY};z)
endif()


option (USE_SGPP "sgpp" ON)
if (USE_SGPP)
  find_package (SGpp)
endif()
if (SGpp_FOUND)
  add_pkgtest (sgpp EXT .cxx INCLUDES ${SGPP_INCLUDE_DIR} LIBS ${SGPP_LIBRARIES})
endif()

option (USE_SPECTRA "spectra" ON)
if (USE_SPECTRA)
  find_package (Spectra)
endif ()
if (Spectra_FOUND)
  add_pkgtest (spectra EXT .cxx INCLUDES ${EIGEN_INCLUDE_DIRS} ${SPECTRA_INCLUDE_DIR})
endif()


option (USE_TRILINOS "trilinos" OFF)
if (USE_TRILINOS)
  find_package (ROL)
endif()
if (ROL_FOUND)
  add_pkgtest (trilinos EXT .cxx INCLUDES ${ROL_INCLUDE_DIR} LIBS ${ROL_LIBRARIES})
endif()


option (USE_QT4 "qt4" OFF)
if (USE_QT4)
  find_package (Qt4 REQUIRED QtCore QtGui)
endif ()
if (QT4_FOUND)
  set (QT4_LIBRARIES ${QT_QTGUI_LIBRARY};${QT_QTCORE_LIBRARY})
  set (QT4_INCLUDE_DIRS ${QT_INCLUDE_DIR};${QT_QTGUI_INCLUDE_DIR};${QT_QTCORE_INCLUDE_DIR})
  add_pkgtest (qt4 EXT .cxx INCLUDES ${QT4_INCLUDE_DIRS} LIBS ${QT4_LIBRARIES})
endif ()


option (USE_QSCINTILLA "qscintilla" ON)
if (USE_QSCINTILLA)
  find_package (QScintilla)
endif ()
if (QSCINTILLA_FOUND AND QT4_FOUND)
  add_pkgtest (qscintilla EXT .cxx INCLUDES ${QT4_INCLUDE_DIRS};${QSCINTILLA_INCLUDE_DIRS} LIBS ${QT4_LIBRARIES};${QSCINTILLA_LIBRARIES})
endif ()


option (USE_QSINT "qsint" ON)
if (USE_QSINT)
  find_package (QSint)
endif ()
if (QSINT_FOUND AND QT4_FOUND)
  add_pkgtest (qsint EXT .cxx INCLUDES ${QT4_INCLUDE_DIRS};${QSINT_INCLUDE_DIRS} LIBS ${QT4_LIBRARIES};${QSINT_LIBRARIES})
endif ()


option (USE_QT5 "qt5" ON)
if (USE_QT5)
  find_package (Qt5Widgets NO_MODULE)
endif ()
if (Qt5Widgets_FOUND)
  add_pkgtest (qt5 EXT .cxx INCLUDES ${Qt5Widgets_INCLUDE_DIRS} LIBS ${Qt5Widgets_LIBRARIES})
endif ()


option (USE_QT6 "qt6" ON)
if (USE_QT6)
  find_package (Qt6Widgets NO_MODULE)
endif ()
if (Qt6Widgets_FOUND)
  add_pkgtest (qt6 EXT .cxx INCLUDES ${Qt6Widgets_INCLUDE_DIRS} LIBS ${Qt6Widgets_LIBRARIES})
endif ()



option (USE_QWT "qwt" ON)
if (USE_QWT)
  find_package (Qwt 6)
endif ()
if (QWT_FOUND AND Qt5Widgets_FOUND)
  add_pkgtest (qwt EXT .cxx INCLUDES ${Qt5Widgets_INCLUDE_DIRS};${QWT_INCLUDE_DIRS} LIBS ${Qt5Widgets_LIBRARIES};${QWT_LIBRARIES})
endif ()


option (USE_SDL "sdl" ON)
if (USE_SDL)
  find_package (SDL)
endif ()
if (SDL_FOUND)
  add_pkgtest (sdl INCLUDES ${SDL_INCLUDE_DIR} LIBS ${SDL_LIBRARY})
endif ()


option (USE_SDL_IMAGE "sdl_image" ON)
if (USE_SDL_IMAGE)
  find_package (SDL_image)
endif ()
if (SDL_IMAGE_FOUND)
  add_pkgtest (sdl_image INCLUDES ${SDL_IMAGE_INCLUDE_DIR} LIBS ${SDL_IMAGE_LIBRARY} ${SDL_LIBRARY})
endif ()


option (USE_SDL_GFX "sdl_gfx" ON)
if (USE_SDL_GFX)
  find_package (SDL_gfx)
endif ()
if (SDL_GFX_FOUND)
  add_pkgtest (sdl_gfx INCLUDES ${SDL_GFX_INCLUDE_DIR} LIBS ${SDL_GFX_LIBRARY} ${SDL_LIBRARY})
endif ()


option (USE_SDL_MIXER "sdl_mixer" ON)
if (USE_SDL_MIXER)
  find_package (SDL_mixer)
endif ()
if (SDL_MIXER_FOUND)
  if (NOT ${CMAKE_CURRENT_SOURCE_DIR} STREQUAL ${CMAKE_CURRENT_BINARY_DIR})
    execute_process(COMMAND ${CMAKE_COMMAND} -E create_symlink ${CMAKE_CURRENT_SOURCE_DIR}/test.wav ${CMAKE_CURRENT_BINARY_DIR}/test.wav)
  endif ()
  add_pkgtest (sdl_mixer INCLUDES ${SDL_MIXER_INCLUDE_DIRS} LIBS ${SDL_MIXER_LIBRARIES} ${SDL_LIBRARY})
endif ()


option (USE_SDL2 "sdl2" ON)
if (USE_SDL2)
  find_package (SDL2)
endif ()
if (SDL2_FOUND)
  add_pkgtest (sdl2 INCLUDES ${SDL2_INCLUDE_DIR} LIBS ${SDL2_LIBRARY})
endif ()


option (USE_SDL2_IMAGE "sdl2_image" ON)
if (USE_SDL2_IMAGE)
  find_package (SDL2_image)
endif ()
if (SDL2_IMAGE_FOUND)
  add_pkgtest (sdl2_image INCLUDES ${SDL2_IMAGE_INCLUDE_DIR} LIBS ${SDL2_IMAGE_LIBRARY} ${SDL2_LIBRARY})
endif ()


option (USE_SDL2_MIXER "sdl2_mixer" ON)
if (USE_SDL2_MIXER)
  find_package (SDL2_mixer)
endif ()
if (SDL2_MIXER_FOUND)
  if (NOT ${CMAKE_CURRENT_SOURCE_DIR} STREQUAL ${CMAKE_CURRENT_BINARY_DIR})
    execute_process(COMMAND ${CMAKE_COMMAND} -E create_symlink ${CMAKE_CURRENT_SOURCE_DIR}/test.wav ${CMAKE_CURRENT_BINARY_DIR}/test.wav)
  endif ()
  add_pkgtest (sdl2_mixer INCLUDES ${SDL2_MIXER_INCLUDE_DIRS} LIBS ${SDL2_MIXER_LIBRARIES} ${SDL2_LIBRARY})
endif ()


option (USE_VORBIS "vorbis" ON)
if (USE_VORBIS)
  find_package (Vorbis)
endif ()
if (Vorbis_FOUND)
  add_pkgtest (vorbis INCLUDES ${VORBIS_INCLUDE_DIRS} LIBS ${VORBIS_LIBRARIES})
endif ()


option (USE_VTK "vtk" ON)
if (USE_VTK)
  find_package(VTK COMPONENTS vtkChartsCore vtkFiltersSources NO_MODULE)
endif ()
if (VTK_FOUND)
  add_pkgtest (vtk EXT .cxx LIBS ${VTK_LIBRARIES})
endif ()

option (USE_Z3 "z3" ON)
if (USE_Z3)
  find_package(Z3 NO_MODULE)
endif ()
if (Z3_FOUND)
  add_pkgtest (z3 EXT .cxx INCLUDES ${Z3_CXX_INCLUDE_DIRS} LIBS ${Z3_LIBRARIES})
endif ()
