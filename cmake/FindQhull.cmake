# - Find Qhull
# A general dimension code for computing convex hulls and related structures
# http://www.qhull.org/
#
# The module defines the following variables:
#  QHULL_INCLUDE_DIRS, where to find qhull headers.
#  QHULL_LIBRARIES, the libraries needed to use Cuba.
#  QHULL_FOUND, If false, do not try to use Cuba.
# also defined, but not for general use are
#  QHULL_R_LIBRARY, where to find the qhull reentrant library.

find_path (QHULL_INCLUDE_DIR libqhull_r/qhull_ra.h)

find_library (QHULL_R_LIBRARY NAMES qhull_r)

set (QHULL_LIBRARIES ${QHULL_R_LIBRARY})
set (QHULL_INCLUDE_DIRS ${QHULL_INCLUDE_DIR})

include(FindPackageHandleStandardArgs)
find_package_handle_standard_args(Qhull DEFAULT_MSG QHULL_R_LIBRARY QHULL_INCLUDE_DIRS)

mark_as_advanced (
  QHULL_R_LIBRARY
  QHULL_LIBRARIES
  QHULL_INCLUDE_DIR
  QHULL_INCLUDE_DIRS)

