cmake_minimum_required ( VERSION 2.8 )

project ( mingw-test C CXX Fortran )

list ( APPEND CMAKE_MODULE_PATH ${CMAKE_SOURCE_DIR}/cmake )

enable_testing ()

macro ( add_pkgtest PKGNAME )
  set (_EXT .c)
  set (_INCLUDES)
  set (_LIBS)
  set (_CMD)
  foreach ( _ARG ${ARGN} )
    if ( ${_ARG} MATCHES EXT )
      set ( _CMD EXT )
    elseif ( ${_ARG} MATCHES INCLUDES )
      set ( _CMD INCLUDES )
    elseif ( ${_ARG} MATCHES LIBS )
      set ( _CMD LIBS)
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
  
  add_executable ( t_${PKGNAME} t_${PKGNAME}${_EXT} )
  target_link_libraries ( t_${PKGNAME} ${_LIBS} )
  target_include_directories( t_${PKGNAME} PUBLIC ${_INCLUDES})

  install (TARGETS t_${PKGNAME} DESTINATION bin)
  add_test ( t_${PKGNAME} t_${PKGNAME}${CMAKE_EXECUTABLE_SUFFIX} )
endmacro()


option (USE_BLAS "blas" ON)
if (USE_BLAS)
  find_package ( BLAS )
endif ()
if ( BLAS_FOUND )
  add_pkgtest ( blas EXT .f90 LIBS ${BLAS_LIBRARIES})
endif ()

option (USE_BULLET "bullet" ON)
if (USE_BULLET)
  find_package ( Bullet )
endif ()
if ( BULLET_FOUND )
  add_pkgtest ( bullet EXT .cxx INCLUDES ${BULLET_INCLUDE_DIRS} LIBS ${BULLET_LIBRARIES})
endif ()


option (USE_BOX2D "box2d" ON)
if (USE_BOX2D)
  find_package ( Box2D )
endif ()
if ( BOX2D_FOUND )
  add_pkgtest ( box2d EXT .cxx INCLUDES ${BOX2D_INCLUDE_DIR} LIBS ${BOX2D_LIBRARY})
endif ()


option (USE_CONFUSE "confuse" ON)
if (USE_CONFUSE)
  find_package ( Confuse )
endif ()
if ( CONFUSE_FOUND )
  add_pkgtest ( confuse INCLUDES ${CONFUSE_INCLUDE_DIRS} LIBS ${CONFUSE_LIBRARIES})
endif ()


option (USE_EIGEN "eigen" ON)
if (USE_EIGEN)
  find_package ( Eigen )
endif ()
if ( EIGEN_FOUND )
  add_pkgtest ( eigen EXT .cxx INCLUDES ${EIGEN_INCLUDE_DIRS} )
endif ()


option (USE_EXPAT "expat" ON)
if (USE_EXPAT)
  find_package ( EXPAT )
endif ()
if ( EXPAT_FOUND )
  add_pkgtest ( expat INCLUDES ${EXPAT_INCLUDE_DIRS} LIBS ${EXPAT_LIBRARIES})
endif ()


option (USE_FFTW "fftw" ON)
if (USE_FFTW)
  find_package ( FFTW )
endif ()
if ( FFTW_FOUND )
  add_pkgtest ( fftw INCLUDES ${FFTW_INCLUDE_DIRS} LIBS ${FFTW_LIBRARIES})
endif ()


option (USE_FREETYPE "freetype" ON)
if (USE_FREETYPE)
  find_package ( Freetype )
endif ()
if ( FREETYPE_FOUND )
  add_pkgtest ( freetype EXT .cxx INCLUDES ${FREETYPE_INCLUDE_DIRS} LIBS ${FREETYPE_LIBRARIES})
endif ()


option (USE_HDF5 "hdf5" ON)
if (USE_HDF5)
  find_package ( HDF5 )
endif ()
if ( HDF5_FOUND )
  add_pkgtest ( hdf5 INCLUDES ${HDF5_INCLUDE_DIRS} LIBS ${HDF5_LIBRARIES})
endif ()


option (USE_ICONV "iconv" ON)
if (USE_ICONV)
  find_package ( Iconv )
endif ()
if ( ICONV_FOUND )
  add_pkgtest ( iconv INCLUDES ${ICONV_INCLUDE_DIR} LIBS ${ICONV_LIBRARIES})
endif ()


option (USE_JPEG "jpeg" ON)
if (USE_JPEG)
  find_package ( JPEG )
endif ()
if ( JPEG_FOUND )
  if (NOT ${CMAKE_CURRENT_SOURCE_DIR} STREQUAL ${CMAKE_CURRENT_BINARY_DIR})
    execute_process( COMMAND ${CMAKE_COMMAND} -E create_symlink ${CMAKE_CURRENT_SOURCE_DIR}/test.jpg ${CMAKE_CURRENT_BINARY_DIR}/test.jpg )
  endif ()
  add_pkgtest ( jpeg INCLUDES ${JPEG_INCLUDE_DIRS} LIBS ${JPEG_LIBRARIES})
endif ()


option (USE_LIBDL "libdl" ON)
if (USE_LIBDL)
  find_package ( Libdl )
endif ()
if ( LIBDL_FOUND )
  add_definitions(-DCURRENT_BINARY_DIR="${CMAKE_CURRENT_BINARY_DIR}")
  add_library(hello SHARED hello.c)
  add_pkgtest ( libdl INCLUDES ${LIBDL_INCLUDE_DIR} LIBS ${LIBDL_LIBRARIES})
endif ()


option (USE_LAPACK "lapack" ON)
if (USE_LAPACK)
  find_package ( BLAS )
  find_package ( LAPACK )
endif ()
if ( LAPACK_FOUND )
  add_pkgtest ( lapack EXT .f90 LIBS ${LAPACK_LIBRARIES})
endif ()


option (USE_LIBXML2 "libxml2" ON)
if (USE_LIBXML2)
  find_package ( LibXml2 )
endif ()
if ( LIBXML2_FOUND )
  add_pkgtest ( libxml2 INCLUDES ${LIBXML2_INCLUDE_DIR} LIBS ${LIBXML2_LIBRARIES})
endif ()


option (USE_LIBSVM "libsvm" ON)
if (USE_LIBSVM)
  find_package ( LibSVM )
endif ()
if ( LIBSVM_FOUND )
  add_pkgtest ( libsvm INCLUDES ${LIBSVM_INCLUDE_DIRS} LIBS ${LIBSVM_LIBRARIES})
endif ()


option (USE_LIBUSB "libusb" ON)
if (USE_LIBUSB)
  find_package ( LibUSB )
endif ()
if ( LIBUSB_FOUND )
  add_pkgtest ( libusb INCLUDES ${LIBUSB_INCLUDE_DIR} LIBS ${LIBUSB_LIBRARIES})
endif ()


option (USE_LIBFTDI "libFTDI1" ON)
if (USE_LIBFTDI)
  find_package ( LibFTDI1 NO_MODULE )
endif ()
if ( LIBFTDI_FOUND )
  add_pkgtest ( libftdi1 INCLUDES ${LIBFTDI_INCLUDE_DIRS} LIBS ${LIBFTDI_LIBRARIES})
endif ()

option (USE_MUPARSER "muParser" ON)
if (USE_MUPARSER)
  find_package ( MuParser )
endif ()
if ( MUPARSER_FOUND )
  add_pkgtest ( muparser EXT .cxx INCLUDES ${MUPARSER_INCLUDE_DIRS} LIBS ${MUPARSER_LIBRARIES})
endif ()

option (USE_NLOPT "nlopt" ON)
if (USE_NLOPT)
  find_package ( Nlopt )
endif ()
if ( NLOPT_FOUND )
  add_pkgtest ( nlopt EXT .cxx INCLUDES ${NLOPT_INCLUDE_DIRS} LIBS ${NLOPT_LIBRARIES})
endif ()


option (USE_OPENSSL "openssl" ON)
if (USE_OPENSSL)
  find_package ( OpenSSL )
endif ()
if ( OPENSSL_FOUND )
  add_pkgtest ( openssl INCLUDES ${OPENSSL_INCLUDE_DIRS} LIBS ${OPENSSL_LIBRARIES})
endif ()


option (USE_REGEX "regex" ON)
if (USE_REGEX)
  find_package ( Regex )
endif ()
if ( REGEX_FOUND )
  add_pkgtest ( regex INCLUDES ${REGEX_INCLUDE_DIR} LIBS ${REGEX_LIBRARIES})
endif ()


option (USE_ZLIB "zlib" ON)
if (USE_ZLIB)
  find_package ( ZLIB )
endif ()
if ( ZLIB_FOUND )
  add_pkgtest ( zlib  INCLUDES ${ZLIB_INCLUDE_DIRS} LIBS ${ZLIB_LIBRARIES})
endif ()

option(USE_LIBZIP "libzip" on)
if (USE_LIBZIP)
  find_package(LibZip)
endif ()
if (LIBZIP_FOUND)
  add_pkgtest(libzip INCLUDES ${LIBZIP_INCLUDE_DIRS} LIBS ${LIBZIP_LIBRARIES})
endif()

option (USE_TBB "tbb" ON)
if (USE_TBB)
  find_package ( TBB )
endif ()
if ( TBB_FOUND )
  add_pkgtest ( tbb EXT .cxx INCLUDES ${TBB_INCLUDE_DIRS} LIBS ${TBB_LIBRARIES})
endif ()


option (USE_BOOST "boost" ON)
if (USE_BOOST)
  find_package ( Boost )
endif ()
if ( Boost_FOUND )
  add_pkgtest ( boost EXT .cxx INCLUDES ${Boost_INCLUDE_DIRS} LIBS ${Boost_LIBRARIES})
endif ()



option (USE_QT4 "qt4" ON)
if (USE_QT4)
  find_package ( Qt4 REQUIRED QtCore QtGui)
endif ()
if ( QT4_FOUND )
  set (QT4_LIBRARIES ${QT_QTGUI_LIBRARY};${QT_QTCORE_LIBRARY})
  set (QT4_INCLUDE_DIRS ${QT_INCLUDE_DIR};${QT_QTGUI_INCLUDE_DIR};${QT_QTCORE_INCLUDE_DIR})
  add_pkgtest ( qt4 EXT .cxx INCLUDES ${QT4_INCLUDE_DIRS} LIBS ${QT4_LIBRARIES})
endif ()


option (USE_QSCINTILLA "qscintilla" ON)
if (USE_QSCINTILLA)
  find_package ( QScintilla )
endif ()
if ( QSCINTILLA_FOUND AND QT4_FOUND)
  add_pkgtest ( qscintilla EXT .cxx INCLUDES ${QT4_INCLUDE_DIRS};${QSCINTILLA_INCLUDE_DIRS} LIBS ${QT4_LIBRARIES};${QSCINTILLA_LIBRARIES})
endif ()


option (USE_QWT "qwt" ON)
if (USE_QWT)
  find_package ( Qwt )
endif ()
if ( QWT_FOUND AND QT4_FOUND)
  add_pkgtest ( qwt EXT .cxx INCLUDES ${QT4_INCLUDE_DIRS};${QWT_INCLUDE_DIRS} LIBS ${QT4_LIBRARIES};${QWT_LIBRARIES})
endif ()


option (USE_QSINT "qsint" ON)
if (USE_QSINT)
  find_package ( QSint )
endif ()
if ( QSINT_FOUND AND QT4_FOUND)
  add_pkgtest ( qsint EXT .cxx INCLUDES ${QT4_INCLUDE_DIRS};${QSINT_INCLUDE_DIRS} LIBS ${QT4_LIBRARIES};${QSINT_LIBRARIES})
endif ()


option (USE_QT5 "qt5" ON)
if (USE_QT5)
  find_package ( Qt5Widgets )
endif ()
if ( Qt5Widgets_FOUND )
  add_pkgtest ( qt5 EXT .cxx INCLUDES ${Qt5Widgets_INCLUDE_DIRS} LIBS ${Qt5Widgets_LIBRARIES} )
endif ()


