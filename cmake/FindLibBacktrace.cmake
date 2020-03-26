# - Find LIBBACKTRACE (backtrace.h, libbacktrace.so)
# This module defines
#  LIBBACKTRACE_INCLUDE_DIRS, directory containing headers
#  LIBBACKTRACE_LIBRARIES, path to libbacktrace's library
#  LIBBACKTRACE_FOUND, whether libbacktrace has been found

find_path(LIBBACKTRACE_INCLUDE_DIR NAMES backtrace.h)
find_library(LIBBACKTRACE_LIBRARY NAMES backtrace)

set (LIBBACKTRACE_INCLUDE_DIRS ${LIBBACKTRACE_INCLUDE_DIR})
set (LIBBACKTRACE_LIBRARIES ${LIBBACKTRACE_LIBRARY})

include(FindPackageHandleStandardArgs)
find_package_handle_standard_args(LibBacktrace REQUIRED_VARS
  LIBBACKTRACE_LIBRARIES LIBBACKTRACE_INCLUDE_DIRS)
