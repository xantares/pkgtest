# - Find FLINT

find_path(FLINT_INCLUDE_DIR
  NAMES flint/flint.h
  DOC "flint.h include directory")
mark_as_advanced(FLINT_INCLUDE_DIR)

if (FLINT_INCLUDE_DIR)
  set(FLINT_INCLUDE_DIRS ${FLINT_INCLUDE_DIR})
endif ()

find_library(FLINT_LIBRARY
  NAMES flint
  DOC "flint library")
mark_as_advanced(FLINT_LIBRARY)

if (FLINT_LIBRARY)
  set(FLINT_LIBRARIES ${FLINT_LIBRARY})
endif ()

include(FindPackageHandleStandardArgs)
find_package_handle_standard_args(FLINT
  REQUIRED_VARS FLINT_LIBRARY FLINT_INCLUDE_DIR)
