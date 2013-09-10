cmake_minimum_required ( VERSION 2.8 )

project ( mingw-test C CXX Fortran )

list ( APPEND CMAKE_MODULE_PATH ${CMAKE_SOURCE_DIR}/cmake )

find_package ( LibXml2 )
find_package ( BLAS )
find_package ( LAPACK )
find_package ( TBB )
find_package ( LibSVM )



enable_testing ()

if ( MINGW )
  file (GLOB DLLS "${CMAKE_FIND_ROOT_PATH}/*/*.dll")
  foreach( DLL ${DLLS})
    execute_process(COMMAND ${CMAKE_COMMAND} -E copy ${DLL} ${CMAKE_CURRENT_BINARY_DIR})
  endforeach()
endif ()

if ( LAPACK_FOUND )
  include_directories ( ${LAPACK_INCLUDE_DIRS} )
  add_executable ( t_lapack t_lapack.f90 )
  add_dependencies(t_lapack eeee)
  target_link_libraries ( t_lapack ${LAPACK_LIBRARIES} )
  add_test( t_lapack t_lapack${CMAKE_EXECUTABLE_SUFFIX} )
endif ()

if ( LIBXML2_FOUND )
  include_directories ( ${LIBXML2_INCLUDE_DIR} )
  add_executable ( t_libxml2 t_libxml2.c )
  target_link_libraries ( t_libxml2 ${LIBXML2_LIBRARIES} )
  add_test( t_libxml2 t_libxml2${CMAKE_EXECUTABLE_SUFFIX} )
endif ()

if ( LIBSVM_FOUND )
  include_directories ( ${LIBSVM_INCLUDE_DIRS} )
  add_executable ( t_libsvm t_libsvm.c )
  target_link_libraries ( t_libsvm ${LIBSVM_LIBRARIES} )
  add_test( t_libsvm t_libsvm${CMAKE_EXECUTABLE_SUFFIX} )
endif ()

if ( TBB_FOUND )
  include_directories ( ${TBB_INCLUDE_DIRS} )
  add_executable ( t_tbb t_tbb.cxx )
  target_link_libraries ( t_tbb ${TBB_LIBRARIES} )
  add_test( t_tbb t_tbb${CMAKE_EXECUTABLE_SUFFIX} )
endif ()


