# - Find Cuba
# Cuba is library for mutidimensional numerical integration
# available at www.feynarts.de/cuba/

find_path(CUBA_INCLUDE_DIR
  NAMES cuba.h
  DOC "libharu include directory")
mark_as_advanced(CUBA_INCLUDE_DIR)

find_library(CUBA_LIBRARY
  NAMES cuba
  DOC "libharu release library")
mark_as_advanced(CUBA_LIBRARY)

include(FindPackageHandleStandardArgs)
find_package_handle_standard_args(Cuba
  REQUIRED_VARS CUBA_LIBRARY CUBA_INCLUDE_DIR)

if (CUBA_FOUND)
  set(CUBA_INCLUDE_DIRS "${CUBA_INCLUDE_DIR}")
  set(CUBA_LIBRARIES "${CUBA_LIBRARY}")
endif ()
